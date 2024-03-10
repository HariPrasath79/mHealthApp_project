import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_cdm/features/authentication/components/google_auth_button.dart';
import 'package:project_cdm/features/authentication/components/submit_button.dart';
import 'package:project_cdm/features/authentication/components/text_field.dart';
import 'package:project_cdm/features/authentication/bloc/auth_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hidePass = true;
  Icon passEye = const Icon(CupertinoIcons.eye_fill);
  bool constainsUppercase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool containsEightChar = false;
  String? errorText;
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AuthBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                InputTextFieldComponent(
                  controller: _nameController,
                  hint: 'Name',
                  prefIcon: const Icon(Icons.person),
                ),
                const SizedBox(height: 20),
                InputTextFieldComponent(
                  controller: _emailController,
                  hint: 'Email',
                  prefIcon: const Icon(Icons.mail),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'This field is required';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                        .hasMatch(val)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  errorText: errorText,
                ),
                const SizedBox(height: 20),
                InputTextFieldComponent(
                    controller: _passwordController,
                    obscuredText: hidePass,
                    hint: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(hidePass
                          ? CupertinoIcons.eye_fill
                          : CupertinoIcons.eye_slash_fill),
                      onPressed: () {
                        setState(() {
                          hidePass = !hidePass;
                        });
                      },
                    ),
                    prefIcon: const Icon(Icons.password),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'This field is required';
                      } else if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                          .hasMatch(val)) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      if (val.contains(RegExp(r'[A-Z]'))) {
                        setState(() {
                          constainsUppercase = true;
                        });
                      } else {
                        setState(() {
                          constainsUppercase = false;
                        });
                      }

                      if (val.contains(RegExp(r'[0-9]'))) {
                        setState(() {
                          containsNumber = true;
                        });
                      } else {
                        containsNumber = false;
                      }
                      if (val.contains(RegExp(
                          r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
                        setState(() {
                          containsSpecialChar = true;
                        });
                      } else {
                        setState(() {
                          containsSpecialChar = false;
                        });
                      }
                      if (val.length >= 8) {
                        setState(() {
                          containsEightChar = true;
                        });
                      } else {
                        setState(() {
                          containsEightChar = false;
                        });
                      }
                    }),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '⚈  1 uppercase',
                      style: TextStyle(
                          color:
                              constainsUppercase ? Colors.green : Colors.black),
                    ),
                    const SizedBox(width: 23),
                    Text(
                      '⚈  1 number',
                      style: TextStyle(
                          color: containsNumber ? Colors.green : Colors.black),
                    ),
                  ],
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '⚈  1 specialChar',
                      style: TextStyle(
                          color: containsSpecialChar
                              ? Colors.green
                              : Colors.black),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      '⚈ >8 char',
                      style: TextStyle(
                          color:
                              containsEightChar ? Colors.green : Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: double.maxFinite,
                    child: SubmitButtonComponent(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          bloc.add(UserSignUpEvent(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                              userName: _nameController.text.trim()));
                        }
                      },
                    )),
              ],
            ),
            SizedBox(
                width: double.maxFinite,
                child: GoogleAuthButton(
                  hint: 'Continue With Google',
                  onPressed: () {
                    bloc.add(UserGoogleAuthEvent());
                  },
                )),
          ],
        ),
      ),
    );
  }
}
