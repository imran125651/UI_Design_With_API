import 'package:flutter/material.dart';
import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../../main.dart';
import '../widgets/center_circular_progress_indicator.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTaskInProgress = false;
  List<TaskModel> _taskProgressModelList = [];

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async{
          await _getCancelledTaskList();
        },
        child: Visibility(
            visible: !_getProgressTaskInProgress,
            replacement: const CenterCircularProgressIndicator(),
            child: _taskProgressModelList.isNotEmpty?
            ListView.builder(
              shrinkWrap: true,
              itemCount: _taskProgressModelList.length,
              itemBuilder: (context, index) {
                return TaskCard(taskModel: _taskProgressModelList[index],);
              },
            )
                :
            _noDataFound()
        ),
      ),
    );
  }

  Future<void> _getCancelledTaskList() async{
    setState(() {
      _taskProgressModelList.clear();
      _getProgressTaskInProgress = true;
    });
    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.progressTaskList
    );
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      _taskProgressModelList.addAll(taskListModel.data ?? []);
    }
    else{
      showSnackBarMessage(context, response.errorMessage, true);
    }

    setState(() {
      _getProgressTaskInProgress = false;
    });
  }

  Widget _noDataFound() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        height: screenSize.height * 0.8,
        alignment: Alignment.center,
        child: const Text("No Data Found"),
      ),
    );
  }
}
