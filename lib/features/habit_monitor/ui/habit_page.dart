import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_cdm/features/habit_monitor/ui/food_list_page.dart';

class HabitPage extends StatelessWidget {
  const HabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('services');
    final totalCal = box.get('totalcal');
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: MaterialButton(
        shape: const CircleBorder(),
        color: Colors.blue,
        padding: const EdgeInsets.all(15),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const FoodListPage()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          'Habit Page',
          style: GoogleFonts.outfit(fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.25,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(enabled: true),
                sections: [
                  PieChartSectionData(
                      value: 80, color: Colors.green, showTitle: true),
                  PieChartSectionData(
                    value: 20,
                    color: Colors.red,
                    showTitle: true,
                  ),
                ],
                centerSpaceRadius: 50,
                sectionsSpace: 0,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Total Calories: $totalCal',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
