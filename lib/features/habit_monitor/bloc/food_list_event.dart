part of 'food_list_bloc.dart';

@immutable
sealed class FoodListEvent {}

class InitialFetchEvent extends FoodListEvent {}

class CustomProductUpdateEvent extends FoodListEvent {
  final XFile? file;
  final String url;
  final String productName;
  final String servingSize;
  final String category;
  final double carb;
  final double protien;
  final double fat;
  final double kcal;

  CustomProductUpdateEvent({
    required this.file,
    required this.url,
    required this.productName,
    required this.servingSize,
    required this.category,
    required this.carb,
    required this.protien,
    required this.fat,
    required this.kcal,
  });
}
