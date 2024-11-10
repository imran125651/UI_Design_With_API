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

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskInProgress = false;
  List<TaskModel> _taskCompletedModelList = [];

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async{
          await _getCompletedTaskList();
        },
        child: Visibility(
          visible: !_getCompletedTaskInProgress,
          replacement: const CenterCircularProgressIndicator(),
          child: _taskCompletedModelList.isNotEmpty?
          ListView.builder(
            shrinkWrap: true,
            itemCount: _taskCompletedModelList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskModel: _taskCompletedModelList[index],
                onRefreshList: _getCompletedTaskList,
              );
            },
          )
              :
          _noDataFound()
        ),
      ),
    );
  }

  Future<void> _getCompletedTaskList() async{
    setState(() {
      _taskCompletedModelList.clear();
      _getCompletedTaskInProgress = true;
    });
    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.completedTaskList
    );
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      _taskCompletedModelList.addAll(taskListModel.data ?? []);
    }
    else{
      showSnackBarMessage(context, response.errorMessage, true);
    }

    setState(() {
      _getCompletedTaskInProgress = false;
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
