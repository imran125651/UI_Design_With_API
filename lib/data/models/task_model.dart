class TaskModel {
  TaskModel({
    String? id,
    String? title,
    String? description,
    String? status,
    String? email,
    String? createdDate,}){
    _id = id;
    _title = title;
    _description = description;
    _status = status;
    _email = email;
    _createdDate = createdDate;
  }

  TaskModel.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _description = json['description'];
    _status = json['status'];
    _email = json['email'];
    _createdDate = json['createdDate'];
  }
  String? _id;
  String? _title;
  String? _description;
  String? _status;
  String? _email;
  String? _createdDate;

  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get status => _status;
  String? get email => _email;
  String? get createdDate => _createdDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['status'] = _status;
    map['email'] = _email;
    map['createdDate'] = _createdDate;
    return map;
  }

}