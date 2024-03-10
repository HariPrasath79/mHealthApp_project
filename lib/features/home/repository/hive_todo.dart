import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_cdm/features/home/repository/todo_list.dart';
import 'package:project_cdm/features/home/models/todo_model.dart';

class HiveService {
  static final box = Hive.box('services');
  static final todoBox = Hive.box<TodoModel>('todoList');

  static Future<void> setTodoList(String currDate) async {
    await todoBox.clear();
    List<TodoModel> todoList = mealData();
    await todoBox.addAll(todoList);
    await box.put('currentDate', currDate);
  }
}
