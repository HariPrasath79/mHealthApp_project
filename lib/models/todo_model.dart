import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String meal;

  @HiveField(2)
  final String time;

  @HiveField(3)
  final double point;

  @HiveField(4, defaultValue: false)
  bool isCompleted;

  TodoModel({
    required this.id,
    required this.meal,
    required this.time,
    required this.isCompleted,
    required this.point,
  });
}
