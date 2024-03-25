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
    ProfilePage(),
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
        elevation: 20,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: 'Foods',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: 'Feeds',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Profile',
          )
        ],
      ),
      body: pages[currentindex],
    );
  }
}
