import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_cdm/db/todo_list.dart';
import 'package:project_cdm/models/todo_model.dart';

class HiveService {
  static final box = Hive.box('services');
  static final todoBox = Hive.box<TodoModel>('todoList');
  static Future<Box<double>> get weekBox async =>
      await Hive.openBox<double>('weekData');

  static Future<bool> isNewDate({required String curDate}) async {
    final boxDate = box.get('currentDate', defaultValue: '');
    if (curDate != boxDate) {
      await box.put('currentDate', curDate);
      return true;
    }
    return false;
  }

  static Future<void> setWeekData(List<double> week) async {
    final box = Hive.box<double>('weekData');
    await box.clear();
    await box.addAll(week);
  }

  static List getWeekData() {
    final box = Hive.box<double>('weekData');
    return box.keys.toList();
  }

  static Future<void> setTodoList(String currDate) async {
    await todoBox.clear();
    List<TodoModel> todoList = mealData();
    await todoBox.addAll(todoList);
    await box.put('currentDate', currDate);
  }

  static Future<List<TodoModel>> getTodoList() async {
    final data = todoBox.values.toList();
    return data;
  }

  static List<TodoModel> getUncheckedList() {
    return todoBox.values
        .where((element) => element.isCompleted == false)
        .toList();
  }

  static List<TodoModel> getCheckedList() {
    return todoBox.values
        .where((element) => element.isCompleted == true)
        .toList();
  }

  static List<dynamic> getKeys() {
    return todoBox.keys.toList();
  }

  static TodoModel? getTodoModel(key) {
    return todoBox.get(key);
  }
}
