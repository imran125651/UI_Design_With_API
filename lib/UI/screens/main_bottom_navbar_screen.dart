import 'package:flutter/material.dart';
import 'package:ui_design_with_api/UI/screens/progress_task_screen.dart';
import '../widgets/task_manager_app_bar.dart';
import 'cancelled_task_screen.dart';
import 'completed_task_screen.dart';
import 'new_task_screen.dart';


class MainBottomNavbarScreen extends StatefulWidget {
  const MainBottomNavbarScreen({super.key});

  @override
  State<MainBottomNavbarScreen> createState() => _MainBottomNavbarScreenState();
}

class _MainBottomNavbarScreenState extends State<MainBottomNavbarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
    ProgressTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskMangerAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int selectedTabIndex){
          setState(() {
            _selectedIndex = selectedTabIndex;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.new_label),
            label: "New"
          ),

          NavigationDestination(
            icon: Icon(Icons.check_box),
            label: "Completed"
          ),

          NavigationDestination(
            icon: Icon(Icons.close),
            label: "Cancelled"
          ),

          NavigationDestination(
            icon: Icon(Icons.access_time_filled_outlined),
            label: "Progress"
          )
        ]
      ),
    );
  }
}
