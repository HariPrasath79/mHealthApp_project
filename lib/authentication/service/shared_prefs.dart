import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String _key = 'SignInStatus';

  static addSignInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_key, true);
  }

  static removeSignInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_key);
  }

  static Future<bool> checkSignInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_key);
  }
}
