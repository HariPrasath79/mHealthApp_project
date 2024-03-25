import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:project_cdm/features/home/models/todo_model.dart';
import 'package:project_cdm/features/home/repository/hive_todo.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeBlocInitial()) {
    on<HomeInitialFetchEvent>((event, emit) async {
      emit(HomeLoadingState());
      await HiveService.setTodoList(currDate: event.date, day: event.day);
      final todoList = HiveService.getTodoList();
      emit(HomeLoadedState(data: todoList));
    });
  }
}
