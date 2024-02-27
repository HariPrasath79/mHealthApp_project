import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_cdm/authentication/auth_page.dart';
import 'package:project_cdm/authentication/service/shared_prefs.dart';
import 'package:project_cdm/bottom_navigation_bar.dart';
import 'package:project_cdm/firebase_options.dart';
import 'package:project_cdm/models/todo_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox('services');
  await Hive.openBox<TodoModel>('todoList');
  await SharedPrefs.checkSignInStatus().then(
    (value) {
      runApp(MyApp(
        signInStatus: value,
      ));
    },
  );
}

class MyApp extends StatelessWidget {
  final bool signInStatus;
  const MyApp({super.key, required this.signInStatus});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: signInStatus ? const BottomNavigationBarWidget() : const AuthPage(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}
