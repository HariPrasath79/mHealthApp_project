import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HabitPage extends StatelessWidget {
  const HabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('services');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await box.put('currentDate', '');
          },
          child: const Text('Change Date'),
        ),
      ),
    );
  }
}
