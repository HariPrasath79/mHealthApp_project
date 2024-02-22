import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_cdm/bar_graph/bar_chart.dart';
import 'package:project_cdm/components/checklist_component.dart';
import 'package:project_cdm/db/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final data = mealData();
  double currval = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.grey[300],
          title: Text(
            'NutriCare',
            style: GoogleFonts.outfit(fontWeight: FontWeight.w500),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Container(
                height: height * 0.3,
                margin: const EdgeInsets.only(top: 60),
                child: WeeklyGraph(
                  monValue: currval,
                  tueValue: 30,
                  wedValue: 70,
                  thurValue: 100,
                  friValue: 88,
                  satValue: 90,
                  sunValue: 30,
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                    //  physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return LabeledCheckbox(
                          label: item.meal,
                          value: item.isCompleted,
                          time: item.time,
                          onChanged: (val) {
                            setState(() {
                              item.isCompleted = val;
                              if (item.isCompleted == true) {
                                currval = currval + item.point;
                              } else {
                                currval = currval - item.point;
                              }
                              print(currval);
                            });
                          });
                    }),
              ),
            ],
          ),
        ));
  }
}
