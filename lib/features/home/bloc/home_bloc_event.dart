part of 'home_bloc_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialFetchEvent extends HomeEvent {
  final String date;
  final int day;

  HomeInitialFetchEvent({required this.date, required this.day});
}
