import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static Future<void> signInWithEmailPassword(
      {String? email, String? password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
    } on FirebaseAuthException catch (err) {
      throw err.message.toString();
    }
  }

  static Future<void> signUpWithEmail(
      {String? email, String? password, String? userName}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(AuthService.getUserId())
          .set({'userName': userName, 'userEmail': email});
    } on FirebaseAuthException catch (err) {
      throw err.message.toString();
    }
  }

  static Future<void> resetPassword({String? email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email!);
    } on FirebaseAuthException catch (err) {
      throw err.message.toString();
    }
  }

  static Future<void> googleAuth(GoogleSignInAccount? googleUser) async {
    try {
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'userName': userCredential.user!.displayName,
            'userEmail': userCredential.user!.email,
          });
        }
      }
      //   if (userCredential.user != null) {
      //     if (userCredential.additionalUserInfo!.isNewUser) {

      //     }
      //   }
    } on FirebaseAuthException catch (err) {
      throw err.code.toString();
    }
  }

  static String getUserId() {
    return _auth.currentUser!.uid;
  }
}
