part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class UserSignInEvent extends AuthEvent {
  final String email;
  final String password;

  UserSignInEvent({required this.email, required this.password});
}

class UserSignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String userName;

  UserSignUpEvent({
    required this.email,
    required this.password,
    required this.userName,
  });
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;
  ForgotPasswordEvent({required this.email});
}

class UserGoogleAuthEvent extends AuthEvent {}
