part of 'login_status_cubit.dart';

abstract class LoginStatusState {}

final class LoginStatusInitial extends LoginStatusState {}

class LoggedInState extends LoginStatusState {}

class NotLoggedInState extends LoginStatusState {}
