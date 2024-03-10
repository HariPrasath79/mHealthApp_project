import 'package:hive_flutter/adapters.dart';
part 'food_item_model.g.dart';

@HiveType(typeId: 2)
class FoodItemModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String imgUrl;

  @HiveField(2)
  final int kcal;

  FoodItemModel({required this.name, required this.imgUrl, required this.kcal});

  factory FoodItemModel.fromMap(Map<String, dynamic> data) {
    return FoodItemModel(
      name: data['itemName'] as String,
      imgUrl: data['image_url'] as String,
      kcal: data['kcal'] as int,
    );
  }
}
