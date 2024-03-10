import 'package:flutter/material.dart';
import 'package:project_cdm/features/feedback/ui/feedback_page.dart';
import 'package:project_cdm/features/habit_monitor/ui/habit_page.dart';
import 'package:project_cdm/features/home/ui/home_page.dart';
import 'package:project_cdm/features/profile/ui/profile_page.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int currentindex = 0;
  List pages = const [
    HomePage(),
    HabitPage(),
    FeedbackPage(),
    ProfliePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,

        currentIndex: currentindex,
        onTap: (value) {
          setState(() {
            currentindex = value;
          });
        },
        //  fixedColor: Colors.deepPurple,
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        useLegacyColorScheme: false,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.checklist),
              label: 'Todo',
              backgroundColor: Colors.grey[300]),
          BottomNavigationBarItem(
              icon: const Icon(Icons.grid_4x4_outlined),
              label: 'Habit',
              backgroundColor: Colors.grey[300]),
          BottomNavigationBarItem(
              icon: const Icon(Icons.message_outlined),
              label: 'Feedback',
              backgroundColor: Colors.grey[300]),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.grey[300])
        ],
      ),
      body: pages[currentindex],
    );
  }
}
