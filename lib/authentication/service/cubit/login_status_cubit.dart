import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_status_state.dart';

class LoginStatusCubit extends Cubit<LoginStatusState> {
  LoginStatusCubit() : super(LoginStatusInitial());
  static const String _key = 'SignInStatus';

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLogin = prefs.containsKey(_key);
    emit(isLogin ? LoggedInState() : NotLoggedInState());
  }

  Future<void> setLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }

  Future<void> setLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
