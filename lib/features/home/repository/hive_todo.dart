import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_cdm/features/home/repository/todo_list.dart';
import 'package:project_cdm/features/home/models/todo_model.dart';

class HiveService {
  static final box = Hive.box('services');
  static final todoBox = Hive.box<TodoModel>('todoList');

  static Future<void> setTodoList(
      {required String currDate, required int day}) async {
    final boxDate = box.get('currentDate', defaultValue: '');
    if (boxDate != currDate && day != 0) {
      await todoBox.clear();
      List<TodoModel> todoList = mealData();
      await todoBox.addAll(todoList);
      await box.put('currentDate', currDate);
      var weekData = <double>[0, 0, 0, 0, 0, 0, 0];
      await box.put('wd', weekData);
    } else if (boxDate != currDate) {
      await todoBox.clear();
      List<TodoModel> todoList = mealData();
      await todoBox.addAll(todoList);
      await box.put('currentDate', currDate);
    }
  }

  static List<TodoModel> getTodoList() {
    List<TodoModel> todoData;

    todoData = todoBox.values
        .where((element) => element.isCompleted == false)
        .toList();
    List<TodoModel> checkedList =
        todoBox.values.where((element) => element.isCompleted == true).toList();
    todoData.addAll(checkedList);
    return todoData;
  }

  static List<double> getWeekData() {
    return box.get('wd', defaultValue: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]);
  }
}
