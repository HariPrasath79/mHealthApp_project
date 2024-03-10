part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthStateInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthErrorState extends AuthState {
  final String? error;
  AuthErrorState({required this.error});
}

class ResetPasswordSuccesState extends AuthState {}
