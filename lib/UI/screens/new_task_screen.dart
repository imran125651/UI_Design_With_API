import 'package:flutter/material.dart';
import 'package:ui_design_with_api/UI/widgets/center_circular_progress_indicator.dart';
import 'package:ui_design_with_api/UI/widgets/snack_bar_message.dart';
import 'package:ui_design_with_api/data/models/network_response.dart';
import 'package:ui_design_with_api/data/models/task_list_model.dart';
import 'package:ui_design_with_api/data/services/network_caller.dart';
import 'package:ui_design_with_api/data/utils/urls.dart';
import 'package:ui_design_with_api/main.dart';
import '../../data/models/data_model.dart';
import '../../data/models/task_model.dart';
import '../../data/models/task_status_count_model.dart';
import '../utils/app_color.dart';
import '../widgets/task_card.dart';
import '../widgets/task_summary_card.dart';
import 'add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskInProgress = false;
  bool _getTaskStatusCountListInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];
  final List<TaskModel> _taskModelList = [];

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
    _getTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async{
          await _getNewTaskList();
        },
        child: Visibility(
          visible: !_getNewTaskInProgress,
          replacement: const CenterCircularProgressIndicator(),
          child: Column(
            children: [
              _buildSummaryWidget(),
              Expanded(
                child: _taskModelList.isNotEmpty?
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _taskModelList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskModel: _taskModelList[index],
                      onRefreshList: _getNewTaskList,
                    );
                  },
                )
                  :
                _noDataFound()
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewScreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: AppColors.themeColor,
        elevation: 0,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSummaryWidget() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TaskSummaryCard(count: "09", progressType: "New"),
        TaskSummaryCard(count: "09", progressType: "Completed"),
        TaskSummaryCard(count: "09", progressType: "Cancelled"),
        TaskSummaryCard(count: "09", progressType: "Progress"),
      ],
    );
  }

  void _onTapAddNewScreen() async{
    bool? shouldRefresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));
    if(shouldRefresh == true){
      _getNewTaskList();
    }
  }

  Future<void> _getNewTaskList() async{
    setState(() {
      _taskModelList.clear();
      _getNewTaskInProgress = true;
    });
    NetworkResponse response = await NetworkCaller.getRequest( url: Urls.newTaskList);
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      _taskModelList.addAll(taskListModel.data ?? []);
    }
    else{
      showSnackBarMessage(context, response.errorMessage, true);
    }

    setState(() {
      _getNewTaskInProgress = false;
    });
  }


  Future<void> _getTaskStatusCount() async{
    _taskStatusCountList.clear();
    _getTaskStatusCountListInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.taskCountStatus
    );
    if(response.isSuccess){
      TaskStatusCountModel taskStatusCountModel = TaskStatusCountModel.fromJson(response.responseData);
      _taskStatusCountList = taskStatusCountModel.taskStatusListModel!.cast<TaskStatusCountModel>();
    }
    else{
      showSnackBarMessage(context, response.errorMessage, true);
    }

    setState(() {
      _getTaskStatusCountListInProgress = false;
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
