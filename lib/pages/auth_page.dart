// ignore_for_file: prefer_const_constructors

import 'package:authentication_app/pages/login_or_register_page.dart';
import 'package:authentication_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // is the user logged in
          if (snapshot.hasData) {
            return HomePage();
          }
          // is the user not logged in
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
