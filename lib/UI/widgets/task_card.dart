import 'package:flutter/material.dart';
import 'package:ui_design_with_api/UI/widgets/center_circular_progress_indicator.dart';
import 'package:ui_design_with_api/UI/widgets/snack_bar_message.dart';
import 'package:ui_design_with_api/data/models/network_response.dart';
import 'package:ui_design_with_api/data/services/network_caller.dart';
import 'package:ui_design_with_api/data/utils/urls.dart';
import '../../data/models/task_model.dart';
import '../utils/app_color.dart';


class TaskCard extends StatefulWidget {

  const TaskCard({
    super.key,
    this.taskModel,
    required this.onRefreshList
  });
  final TaskModel? taskModel;
  final VoidCallback onRefreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  String _selectedStatus = '';
  bool _changeStatusInProgress = false;


  bool _isScienceSelected = true;
  bool _isArtSelected = true;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.taskModel!.status!;
  }


  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel?.title ?? "",
              style: textTheme.headlineSmall,
            ),

            Text(widget.taskModel?.description ?? ""),

            Text(widget.taskModel?.createdDate ?? ""),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTaskStatusChip(),

                OverflowBar(
                  children: [
                    Visibility(
                      visible: !_changeStatusInProgress,
                      replacement: const CenterCircularProgressIndicator(),
                      child: IconButton(
                        onPressed: _onTapEditButton,
                        icon: const Icon(Icons.edit, color: AppColors.themeColor),
                      ),
                    ),

                    IconButton(
                      onPressed: _onTapDeleteButton,
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTaskStatusChip(){
    return Chip(
      label: Text(widget.taskModel!.status!),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
    );
  }

  void _onTapEditButton(){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Edit Status"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ["New", "Completed", "Cancelled", "Progress"].map((e)=>
              ListTile(
                onTap: (){
                  _changeStatus(e);
                  Navigator.pop(context);
                },
                title: Text(e),
                trailing:  _selectedStatus == e ? const Icon(Icons.check) : null,
              )
          ).toList(),
        ),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("Cancel")
          ),
        ],
      )
    );
  }

  Future<void>  _onTapDeleteButton() async{

    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.deleteTask(widget.taskModel!.id!)
    );

    if(response.isSuccess){
      widget.onRefreshList();
      showSnackBarMessage(context, "Deleted successfully.");
    }
    else{
      showSnackBarMessage(context, response.errorMessage);
    }
  }

  Future<void> _changeStatus(String newStatus) async{
    _changeStatusInProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.changeStatus(widget.taskModel!.id!, newStatus)
    );
    
    if(response.isSuccess){
      widget.onRefreshList();
      showSnackBarMessage(context, "Updated successfully.");
    }
    else{
      _changeStatusInProgress = false;
      showSnackBarMessage(context, response.errorMessage);
    }
  }
}
