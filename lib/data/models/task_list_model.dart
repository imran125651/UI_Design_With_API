
import 'package:ui_design_with_api/data/models/task_model.dart';

class TaskListModel {
  TaskListModel({
      String? status, 
      List<TaskModel>? taskList,}){
    _status = status;
    _data = data;
}

  TaskListModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TaskModel.fromJson(v));
      });
    }
  }
  String? _status;
  List<TaskModel>? _data;

  String? get status => _status;
  List<TaskModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


