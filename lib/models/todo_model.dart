class TodoModel {
  final String id;
  final String meal;
  final String time;
  final double point;
  bool isCompleted;

  TodoModel({
    required this.id,
    required this.meal,
    required this.time,
    required this.isCompleted,
    required this.point,
  });
}
