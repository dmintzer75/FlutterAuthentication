import 'package:authentication_app/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'custom_theme.dart';
import 'helpers/status_color.dart';
import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myTheme = CustomTheme().customTheme;
    changeStatusDark();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      theme: myTheme,
      home: const AuthPage(),
    );
  }
}
