import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    final _formKey = GlobalKey<FormState>();

    String _email = '';
    String _password = '';

    // error message popup
    void anErrorOcurredMessage(String errorMessage) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("An error ocurred"),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void signUserIn() async {
      // validate form
      if (!_formKey.currentState!.validate()) return;

      _formKey.currentState!.save();

      // show loading circle
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // try sign in
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        // WRONG EMAIL
        if (e.code == 'user-not-found') {
          anErrorOcurredMessage(e.message!);
        }
        // WRONG PASSWORD
        else if (e.code == 'wrong-password') {
          anErrorOcurredMessage(e.message!);
        } else {
          anErrorOcurredMessage('Please try again');
        }
      }
    }

    FocusNode emailFocus = FocusNode();
    FocusNode passwordFocus = FocusNode();
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Add TextFormFields and ElevatedButton here.

            TextFormField(
              focusNode: emailFocus,
              obscureText: false,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.grey[400]),
                contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                filled: true,
                fillColor: Colors.grey[50],
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
              ),
              onSaved: (value) {
                _email = value!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onEditingComplete: () {
                emailFocus.unfocus();
                passwordFocus.requestFocus();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              focusNode: passwordFocus,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey[400]),
                contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                filled: true,
                fillColor: Colors.grey[50],
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
              ),
              onSaved: (value) {
                _password = value!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onEditingComplete: () {
                signUserIn();
              },
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.centerRight,
              child: const Text(
                'Forgot Password?',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  signUserIn();
                },
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
