import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:project_cdm/features/authentication/service/auth_service.dart';
import 'package:project_cdm/features/authentication/service/shared_prefs.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateInitial()) {
    on<UserSignInEvent>(
      (event, emit) async {
        FocusManager.instance.primaryFocus?.unfocus();
        try {
          emit(AuthLoadingState());
          await AuthService.signInWithEmailPassword(
              email: event.email, password: event.password);
          emit(AuthSuccessState());
          await SharedPrefs.addSignInStatus();
        } catch (err) {
          emit(AuthErrorState(error: 'Incorrect password or email'));
        }
      },
    );

    on<UserSignUpEvent>(
      (event, emit) async {
        try {
          emit(AuthLoadingState());
          await AuthService.signUpWithEmail(
              userName: event.userName,
              email: event.email,
              password: event.password);
          emit(AuthSuccessState());
          await SharedPrefs.addSignInStatus();
        } catch (err) {
          emit(AuthErrorState(error: err.toString()));
        }
      },
    );

    on<ForgotPasswordEvent>(
      (event, emit) async {
        try {
          emit(AuthLoadingState());
          await AuthService.resetPassword(email: event.email);
          emit(ResetPasswordSuccesState());
        } catch (err) {
          emit(AuthErrorState(error: err.toString()));
        }
      },
    );

    on<UserGoogleAuthEvent>(
      (event, emit) async {
        try {
          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
          if (googleUser == null) {
            return;
          }
          emit(AuthLoadingState());
          await AuthService.googleAuth(googleUser);
          SharedPrefs.addSignInStatus();
          emit(AuthSuccessState());
        } catch (err) {
          if (err.toString() != 'AccountNotSelected') {
            emit(AuthErrorState(error: err.toString()));
          }
        }
      },
    );
  }
}
