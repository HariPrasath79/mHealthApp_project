part of 'home_bloc_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeBlocInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedState extends HomeState {
  final List<TodoModel> data;
  HomeLoadedState({required this.data});
}
