import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../utils/app_color.dart';

class TaskCard extends StatefulWidget {

  const TaskCard({super.key, this.taskModel});
  final TaskModel? taskModel;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
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

            Text(widget.taskModel?.description ?? "",),

            Text(widget.taskModel?.createdDate ?? "",),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTaskStatusChip(),

                OverflowBar(
                  children: [
                    IconButton(
                      onPressed: _onTapEditButton,
                      icon: const Icon(Icons.edit, color: AppColors.themeColor),
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
      label: const Text("New"),
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
                onTap: (){},
                title: Text(e),
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
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.themeColor
            ),
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("Okay", style: TextStyle(color: Colors.white))
          ),
        ],
      )
    );
  }

  void _onTapDeleteButton(){

  }
}
