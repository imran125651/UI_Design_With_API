import 'package:flutter/material.dart';
import 'package:ui_design_with_api/UI/controller/auth_controller.dart';
import 'package:ui_design_with_api/UI/widgets/center_circular_progress_indicator.dart';
import 'package:ui_design_with_api/UI/widgets/snack_bar_message.dart';
import 'package:ui_design_with_api/data/models/network_response.dart';
import 'package:ui_design_with_api/data/services/network_caller.dart';
import 'package:ui_design_with_api/data/utils/urls.dart';

import '../widgets/task_manager_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewTaskInProgress = false;




  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskMangerAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Text(
                "Add New Task",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 15),
              _buildAddNewTaskForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddNewTaskForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: "Title"),
            validator: (value){
              if(value?.trim().isEmpty ?? true){
                return "Enter your title";
              }
              return null;
            },
          ),

          const SizedBox(height: 8),
          TextFormField(
            controller: _descriptionController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            maxLines: 5,
            decoration: const InputDecoration(hintText: "Description"),
            validator: (value){
              if(value?.trim().isEmpty ?? true){
                return "Enter your description";
              }
              return null;
            },
          ),

          const SizedBox(height: 16),
          Visibility(
            visible: !_addNewTaskInProgress,
            replacement: const CenterCircularProgressIndicator(),
            child: ElevatedButton(
              onPressed: _addNewTask,
              child: const Icon(Icons.arrow_circle_right_outlined),
            ),
          )
        ],
      ),
    );
  }

  void _addNewTask() async{
    if(!_formKey.currentState!.validate()) return;

    setState(() {
      _addNewTaskInProgress = true;
    });

    Map<String, dynamic> addNewTask = {
      "title": _titleController.text.trim(),
      "description": _descriptionController.text.trim(),
      "status":"New"
    };
    
    final NetworkResponse networkResponse = await NetworkCaller.postRequest(
      url: Urls.createTask,
      body: addNewTask
    );

    if(networkResponse.isSuccess){
      _clearAllFields();
      showSnackBarMessage(context, "Successfully added new task");
    }
    else{
      showSnackBarMessage(context, networkResponse.errorMessage, true);
    }

    setState(() {
      _addNewTaskInProgress = false;
    });

  }

  void _clearAllFields(){
    _titleController.clear();
    _descriptionController.clear();
  }
}
