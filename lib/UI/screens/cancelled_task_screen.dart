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

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelledTaskInProgress = false;
  List<TaskModel> _taskCancelledModelList = [];

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
            visible: !_getCancelledTaskInProgress,
            replacement: const CenterCircularProgressIndicator(),
            child: _taskCancelledModelList.isNotEmpty?
            ListView.builder(
              shrinkWrap: true,
              itemCount: _taskCancelledModelList.length,
              itemBuilder: (context, index) {
                return TaskCard(taskModel: _taskCancelledModelList[index],);
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
      _taskCancelledModelList.clear();
      _getCancelledTaskInProgress = true;
    });
    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.cancelledTaskList
    );
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      _taskCancelledModelList.addAll(taskListModel.data ?? []);
    }
    else{
      showSnackBarMessage(context, response.errorMessage, true);
    }

    setState(() {
      _getCancelledTaskInProgress = false;
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
