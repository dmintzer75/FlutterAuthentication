import 'package:authentication_app/components/my_textfield.dart';
import 'package:authentication_app/components/square_tile.dart';
import 'package:authentication_app/services/auth_services.dart';
import 'package:flutter/material.dart';

import '../components/login_form.dart';
import '../custom_theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.onTap});
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    final myTheme = CustomTheme().customTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  // Logo
                  const Icon(
                    Icons.lock,
                    size: 90,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Welcome back, you've been missed!",
                    style: myTheme.textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const LoginForm(),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Expanded(
                        child: Divider(
                          thickness: 0.6,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Or continue with',
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.6,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                        onTap: () {
                          AuthService().signInWithGoogle();
                        },
                        imagePath: 'assets/images/google.png',
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SquareTile(
                        onTap: () {},
                        imagePath: 'assets/images/apple.png',
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not a member?'),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          onTap();
                        },
                        child: const Text(
                          'Register now',
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
