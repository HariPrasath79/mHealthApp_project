import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static String getUserId() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return uid;
  }
}
