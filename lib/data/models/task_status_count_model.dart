
import 'data_model.dart';

class TaskStatusCountModel {
  TaskStatusCountModel({
      String? status, 
      List<TaskStatusListModel>? taskStatusListModel,}){
    _status = status;
    _taskStatusListModel = taskStatusListModel;
}

  TaskStatusCountModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _taskStatusListModel = [];
      json['data'].forEach((v) {
        _taskStatusListModel?.add(TaskStatusListModel.fromJson(v));
      });
    }
  }
  String? _status;
  List<TaskStatusListModel>? _taskStatusListModel;

  String? get status => _status;
  List<TaskStatusListModel>? get taskStatusListModel => _taskStatusListModel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_taskStatusListModel != null) {
      map['data'] = _taskStatusListModel?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
