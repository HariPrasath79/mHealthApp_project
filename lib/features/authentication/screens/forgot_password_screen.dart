import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_cdm/features/authentication/components/text_field.dart';
import 'package:project_cdm/features/authentication/bloc/auth_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bloc = AuthBloc();
  bool isPopUpScreen = false;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            bloc: bloc,
            listener: (context, state) {
              if (state is ResetPasswordSuccesState) {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Success'),
                    content:
                        const Text('Reset password link has send to your mail'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).popUntil((_) => count++ >= 2);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
              if (state is AuthErrorState) {
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
                    child: CircularProgressIndicator(),
                  );

                default:
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: InputTextFieldComponent(
                            controller: _emailController,
                            hint: 'Email',
                            prefIcon: const Icon(Icons.mail),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Field should not be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.maxFinite,
                          child: MaterialButton(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              color: const Color.fromARGB(255, 166, 131, 228),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  bloc.add(ForgotPasswordEvent(
                                      email: _emailController.text.trim()));
                                }
                              },
                              child: const Text(
                                'Reset Password',
                                style: TextStyle(fontSize: 16),
                              )),
                        )
                      ],
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
