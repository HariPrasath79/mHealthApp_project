import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:project_cdm/features/home/repository/hive_todo.dart';
import 'package:project_cdm/features/home/ui/bar_graph/bar_chart.dart';
import 'package:project_cdm/features/home/ui/components/checklist_component.dart';
import 'package:project_cdm/features/home/models/food_item_model.dart';
import 'package:project_cdm/features/home/models/todo_model.dart';

import 'package:project_cdm/features/home/ui/meal_items_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final date = DateTime.now();
  final day = DateTime.now().weekday - 1;
  var weekData = <double>[0, 0, 0, 0, 0, 0, 0];

  Box<TodoModel> todoBox = Hive.box<TodoModel>('todoList');
  Box box = Hive.box('services');
  Future<void>? initialFetch;

  @override
  void initState() {
    super.initState();
    initialFetch = setData();
  }

  Future<void> setData() async {
    final currDate = DateFormat().add_yMd().format(date);
    final boxDate = box.get('currentDate', defaultValue: '');
    if (currDate != boxDate && day == 1) {
      await HiveService.setTodoList(currDate);
      await box.delete('wd');
      await box.put('wd', weekData);
    } else if (currDate != boxDate) {
      await HiveService.setTodoList(currDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    int totalcal = box.get('totalcal', defaultValue: 0);
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
      body: FutureBuilder(
          future: initialFetch,
          builder: (context, snapshot) {
            List<TodoModel>? todoData;

            todoData = todoBox.values
                .where((element) => element.isCompleted == false)
                .toList();
            List<TodoModel>? checkedList = todoBox.values
                .where((element) => element.isCompleted == true)
                .toList();
            todoData.addAll(checkedList);

            List<double> weekData = box
                .get('wd', defaultValue: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]);

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Container(
                    height: height * 0.25,
                    margin: const EdgeInsets.only(top: 60),
                    child: WeeklyGraph(
                      maxY: 100,
                      monValue: weekData[0],
                      tueValue: weekData[1],
                      wedValue: weekData[2],
                      thurValue: weekData[3],
                      friValue: weekData[4],
                      satValue: weekData[5],
                      sunValue: weekData[6],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView.builder(
                        //  physics: const NeverScrollableScrollPhysics(),
                        itemCount: todoData.length,
                        itemBuilder: (context, index) {
                          final item = todoData![index];
                          final key = item.id.toString() + day.toString();
                          //    final item = todoBox.get(key);
                          return LabeledCheckbox(
                              label: item.meal,
                              value: item.isCompleted,
                              time: item.time,
                              isWater: item.isWater,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => MealPage(
                                        id: item.id, title: item.meal)));
                              },
                              onChanged: (val) async {
                                item.isCompleted = val;
                                final todokey = todoBox.keyAt(item.id);

                                if (item.isCompleted == true) {
                                  weekData[day] += item.point;
                                  await box.put('wd', weekData);
                                  final mealBox =
                                      await Hive.openBox<FoodItemModel>(
                                          item.id.toString());

                                  if (mealBox.containsKey(key)) {
                                    final mealItem = mealBox.get(key);
                                    totalcal += mealItem!.kcal;
                                    await box.put('totalcal', totalcal);
                                  }

                                  await todoBox.put(todokey, item);
                                } else {
                                  weekData[day] -= item.point;
                                  await box.put('wd', weekData);
                                  await todoBox.put(todokey, item);
                                }
                                setState(() {});
                              });
                        }),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
