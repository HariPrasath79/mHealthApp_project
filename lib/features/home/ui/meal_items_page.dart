import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_cdm/features/home/models/food_item_model.dart';
import 'package:project_cdm/features/home/repository/firestore_meal.dart';

class MealPage extends StatefulWidget {
  const MealPage({super.key, required this.id, required this.title});
  final String title;
  final int id;

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  List<FoodItemModel> data = [];
  Box<FoodItemModel>? box;
  Future<void> initalFetch() async {
    box = await Hive.openBox<FoodItemModel>(widget.id.toString());
    data = box!.values.toList();
  }

  @override
  void initState() {
    super.initState();
    initalFetch();
  }

  @override
  Widget build(BuildContext context) {
    Map<int, String> weekDay = {
      0: 'mon',
      1: 'tue',
      2: 'wed',
      3: 'thur',
      4: 'fri',
      5: 'sat',
      6: 'sun',
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: FirestoreHome.fetchMeal(widget.id.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snapshot.hasData) {
              List data = snapshot.data!['items'];
              // Map<String, dynamic> weekData = snapshot.data!['weekly_diet'];

              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: weekDay.length,
                        itemBuilder: (context, index) {
                          String key = widget.id.toString() + index.toString();

                          return SizedBox(
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                DragTarget<FoodItemModel>(
                                  builder: (BuildContext context,
                                      List<Object?> candidateData,
                                      List<dynamic> rejectedData) {
                                    return Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: const CircleBorder(),
                                      child: SizedBox(
                                        height: 70,
                                        child: Image.network(
                                          box!.containsKey(key)
                                              ? box!.get(key)!.imgUrl
                                              : 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Plus_symbol.svg/1200px-Plus_symbol.svg.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                  onAccept: (data) async {
                                    await box!.put(key, data);
                                  },
                                ),
                                Text(weekDay.values.elementAt(index)),
                              ],
                            ),
                          );
                        }),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, right: 8, left: 8),
                      child: GridView.builder(
                          itemCount: data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            final drag = data[index] as Map<String, dynamic>;
                            final itemData = FoodItemModel.fromMap(drag);
                            Widget card({required double height}) => Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: const CircleBorder(),
                                child: SizedBox(
                                  height: height,
                                  child: Image.network(
                                    itemData.imgUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ));
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                LongPressDraggable<FoodItemModel>(
                                  data: itemData,
                                  feedback: card(height: 110),
                                  childWhenDragging: card(height: 100),
                                  child: card(height: 120),
                                ),
                                Text(itemData.name),
                              ],
                            );
                          }),
                    ),
                  ),
                ],
              );
            }

            return const Text('no data');
          }),
    );
  }
}
