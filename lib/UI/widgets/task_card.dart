import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class TaskCard extends StatefulWidget {

  const TaskCard({super.key});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Lorem ipsum is imply dummy",
              style: textTheme.headlineSmall,
            ),

            const Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),

            const Text("Date: 02/02/2020"),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTaskStatusChip(),

                OverflowBar(
                  children: [
                    IconButton(
                      onPressed: _onTapEditButton,
                      icon: const Icon(Icons.edit, color: AppColors.themeColor),
                    ),

                    IconButton(
                      onPressed: _onTapDeleteButton,
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                )


              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTaskStatusChip(){
    return Chip(
      label: const Text("New"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
    );
  }

  void _onTapEditButton(){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Edit Status"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ["New", "Completed", "Cancelled", "Progress"].map((e)=>
              ListTile(
                onTap: (){},
                title: Text(e),
              )
          ).toList(),
        ),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("Cancel")
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.themeColor
            ),
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("Okay", style: TextStyle(color: Colors.white))
          ),
        ],
      )
    );
  }

  void _onTapDeleteButton(){

  }
}
