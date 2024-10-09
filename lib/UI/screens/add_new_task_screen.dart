import 'package:flutter/material.dart';

import '../widgets/task_manager_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();


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
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(hintText: "Title"),
        ),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          maxLines: 5,
          decoration: const InputDecoration(hintText: "Description"),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _addNewTask,
          child: const Icon(Icons.arrow_circle_right_outlined),
        )
      ],
    );
  }

  void _addNewTask() {}
}
