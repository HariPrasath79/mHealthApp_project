import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:project_cdm/core/firebase_service.dart';
import 'package:project_cdm/features/habit_monitor/repository/firebase/custom_product_update.dart';

part 'food_list_event.dart';
part 'food_list_state.dart';

class FoodListBloc extends Bloc<FoodListEvent, FoodListState> {
  FoodListBloc() : super(FoodListInitial()) {
    on<CustomProductUpdateEvent>((event, emit) async {
      final userUid = FirebaseService.getUserId();
      if (event.file != null) {
        final imgUrl =
            await CustomProductService.uploadImage('food_items', event.file!);
        await CustomProductService.updateDoc(
          id: userUid,
          url: imgUrl,
          productName: event.productName,
          servingSize: event.servingSize,
          category: event.category,
          carb: event.carb,
          protien: event.protien,
          fat: event.fat,
          kcal: event.kcal,
        );
      } else {
        CustomProductService.updateDoc(
          id: userUid,
          url: null,
          productName: event.productName,
          servingSize: event.servingSize,
          category: event.category,
          carb: event.carb,
          protien: event.protien,
          fat: event.fat,
          kcal: event.kcal,
        );
      }
    });
  }
}
