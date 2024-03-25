import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_cdm/bottom_navigation_bar.dart';
import 'package:project_cdm/features/authentication/auth_page.dart';
import 'package:project_cdm/features/authentication/bloc/auth_bloc.dart';
import 'package:project_cdm/features/authentication/service/shared_prefs.dart';
import 'package:project_cdm/features/home/models/food_item_model.dart';
import 'package:project_cdm/features/home/models/todo_model.dart';
import 'package:project_cdm/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );
  bool signInStatus = await SharedPrefs.checkSignInStatus();
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(TodoModelAdapter());
  Hive.registerAdapter(FoodItemModelAdapter());
  await Hive.openBox<TodoModel>('todoList');
  await Hive.openBox('services');
  runApp(MyApp(signInStatus: signInStatus));
}

class MyApp extends StatelessWidget {
  final bool signInStatus;
  const MyApp({super.key, required this.signInStatus});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
            signInStatus ? const BottomNavigationBarWidget() : const AuthPage(),
        theme: ThemeData(useMaterial3: true),
      ),
    );
  }
}
