// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodItemModelAdapter extends TypeAdapter<FoodItemModel> {
  @override
  final int typeId = 2;

  @override
  FoodItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodItemModel(
      name: fields[0] as String,
      imgUrl: fields[1] as String,
      kcal: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FoodItemModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imgUrl)
      ..writeByte(2)
      ..write(obj.kcal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
