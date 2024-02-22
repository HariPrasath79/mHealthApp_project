import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_cdm/authentication/bloc/auth_bloc.dart';
import 'package:project_cdm/authentication/screens/sign_in_screen.dart';
import 'package:project_cdm/authentication/screens/sign_up_screen.dart';
import 'package:project_cdm/bottom_navigation_bar.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = AuthBloc();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: BlocConsumer<AuthBloc, AuthState>(
            bloc: bloc,
            listener: (context, state) {
              if (state is AuthLoadingState) {
                CircularProgressIndicator.adaptive();
              }
              if (state is AuthSuccessState) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            const BottomNavigationBarWidget()),
                    (route) => false);
              } else if (state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.error.toString()),
                  backgroundColor: Colors.red,
                ));
              }
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case AuthLoadingState:
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                default:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3.5,
                        child: SafeArea(
                            child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Text("NutriCare",
                                style: GoogleFonts.outfit(
                                    fontSize: 35, fontWeight: FontWeight.bold)),
                            Text(
                              "Your Personalized Health Care Application",
                              style: GoogleFonts.dancingScript(
                                  fontSize: 19, fontWeight: FontWeight.w700),
                            )
                          ],
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 50),
                        child: TabBar(controller: tabController, tabs: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Sign In',
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 19),
                            ),
                          )
                        ]),
                      ),
                      Expanded(
                        child: TabBarView(controller: tabController, children: [
                          SignInScreen(
                            bloc: bloc,
                          ),
                          //Sign Up
                          SignUpScreen(
                            bloc: bloc,
                          ),
                        ]),
                      )
                    ],
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
