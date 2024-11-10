class TaskStatusListModel {
  TaskStatusListModel({
    String? id,
    int? sum,}){
    _id = id;
    _sum = sum;
  }

  TaskStatusListModel.fromJson(dynamic json) {
    _id = json['_id'];
    _sum = json['sum'];
  }
  String? _id;
  int? _sum;

  String? get id => _id;
  int? get sum => _sum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['sum'] = _sum;
    return map;
  }

}