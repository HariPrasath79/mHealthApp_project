import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_cdm/features/authentication/components/google_auth_button.dart';
import 'package:project_cdm/features/authentication/components/submit_button.dart';
import 'package:project_cdm/features/authentication/components/text_field.dart';
import 'package:project_cdm/features/authentication/bloc/auth_bloc.dart';
import 'package:project_cdm/features/authentication/screens/forgot_password_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    super.key,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _focusNode = FocusNode();

  bool obscuredText = true;
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
                  focusNode: _focusNode,
                  controller: _emailController,
                  hint: 'Email',
                  prefIcon: const Icon(Icons.mail),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                InputTextFieldComponent(
                  onFieldSubmitted: (val) {},
                  controller: _passwordController,
                  hint: 'Password',
                  obscuredText: obscuredText,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(obscuredText
                        ? CupertinoIcons.eye_fill
                        : CupertinoIcons.eye_slash_fill),
                    onPressed: () {
                      setState(() {
                        _focusNode.unfocus();
                        obscuredText = !obscuredText;
                      });
                    },
                  ),
                  prefIcon: const Icon(Icons.password),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: double.maxFinite,
                    child: SubmitButtonComponent(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          bloc.add(UserSignInEvent(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim()));
                        }
                      },
                    )),
                const SizedBox(height: 25),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const ForgotPasswordScreen()));
                    },
                    child: const Text('Forgot Password ?'))
              ],
            ),
            // SizedBox(height: 50),
            SizedBox(
                width: double.maxFinite,
                child: GoogleAuthButton(
                  hint: 'Continue with Google',
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
