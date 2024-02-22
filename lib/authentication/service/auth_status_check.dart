import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_cdm/authentication/auth_page.dart';
import 'package:project_cdm/authentication/service/cubit/login_status_cubit.dart';
import 'package:project_cdm/bottom_navigation_bar.dart';

class AuthStatusChecker extends StatefulWidget {
  const AuthStatusChecker({super.key});

  @override
  State<AuthStatusChecker> createState() => _AuthStatusCheckerState();
}

class _AuthStatusCheckerState extends State<AuthStatusChecker> {
  final cubid = LoginStatusCubit();
  @override
  void initState() {
    cubid.checkLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginStatusCubit, LoginStatusState>(
        bloc: cubid,
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoggedInState:
              return const BottomNavigationBarWidget();
            default:
              return const AuthPage();
          }
        });
  }
}
