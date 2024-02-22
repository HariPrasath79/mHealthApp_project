import 'package:project_cdm/models/todo_model.dart';

List<TodoModel> mealData() {
  return [
    TodoModel(
      id: '01',
      meal: 'Water Time (400 ML)',
      time: 'First Thing in Morning',
      isCompleted: false,
      point: 5,
    ),
    TodoModel(
      id: '02',
      meal: 'Morning Snack',
      time: '6:30 - 7:00 AM',
      isCompleted: false,
      point: 10,
    ),
    TodoModel(
      id: '03',
      meal: 'Water Time (200 ML)',
      time: '30 Min after morning snack',
      isCompleted: false,
      point: 5,
    ),
    TodoModel(
      id: '04',
      meal: 'Break Fast',
      time: '8:00 - 8:30 AM',
      isCompleted: false,
      point: 15,
    ),
    TodoModel(
      id: '05',
      meal: 'Water Time (400 ML)',
      time: '10:00 AM',
      isCompleted: false,
      point: 5,
    ),
    TodoModel(
      id: '06',
      meal: 'Pre-Lunch Snack',
      time: '10:30 - 11:00 AM',
      isCompleted: false,
      point: 10,
    ),
    TodoModel(
      id: '07',
      meal: 'Lunch',
      time: '12:30 - 1:00 PM',
      isCompleted: false,
      point: 15,
    ),
    TodoModel(
      id: '08',
      meal: 'Water Time(400 ML)',
      time: '02:30 PM',
      isCompleted: false,
      point: 5,
    ),
    TodoModel(
      id: '09',
      meal: 'Post-Lunch Snack Time',
      time: '03:30 - 04:00 PM',
      isCompleted: false,
      point: 10,
    ),
    TodoModel(
      id: '10',
      meal: 'Water Time(200 ML)',
      time: '05:00 PM',
      isCompleted: false,
      point: 5,
    ),
    TodoModel(
      id: '10',
      meal: 'Dinner',
      time: '07:00 - 08:00 PM',
      isCompleted: false,
      point: 15,
    ),
  ];
}

List<TodoModel>? database;
