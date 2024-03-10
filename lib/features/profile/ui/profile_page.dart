import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:project_cdm/features/authentication/auth_page.dart';
import 'package:project_cdm/features/authentication/service/shared_prefs.dart';

class ProfliePage extends StatefulWidget {
  const ProfliePage({super.key});

  @override
  State<ProfliePage> createState() => _ProfliePageState();
}

class _ProfliePageState extends State<ProfliePage> {
  @override
  Widget build(BuildContext context) {
    Future<void> signOut() async {
      await FirebaseAuth.instance.signOut();

      await GoogleSignIn().signOut();
      await SharedPrefs.removeSignInStatus();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            signOut().then((value) => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const AuthPage())));
          },
          child: const Text('Log Out'),
        ),
      ),
    );
  }
}
