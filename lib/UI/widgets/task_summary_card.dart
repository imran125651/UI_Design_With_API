import 'package:flutter/material.dart';

class TaskSummaryCard extends StatelessWidget {
  final String number;
  final String progressType;

  const TaskSummaryCard({super.key, required this.number, required this.progressType});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Card(
          elevation: 0.4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(number, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                FittedBox(child: Text(progressType, style: const TextStyle(fontSize: 12)))
              ],
            ),
          ),
        ),
      ),
    );;
  }
}
