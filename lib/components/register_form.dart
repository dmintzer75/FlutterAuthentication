import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    final _formKey = GlobalKey<FormState>();

    String _email = '';
    String _password = '';
    String _confirmedPassword = '';

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

    void signUserUp() async {
      // validate form
      if (!_formKey.currentState!.validate()) return;
      _formKey.currentState!.save();
      if (_confirmedPassword != _password) {
        anErrorOcurredMessage('Passwords do not match.');
        return;
      }
      // show loading circle
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // try creating user
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        print('done!');
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        print(e.message!);
        Navigator.pop(context);
        // WRONG EMAIL
        if (e.code == 'user-not-found') {
          anErrorOcurredMessage(e.message!);
        }
        // WRONG PASSWORD
        else if (e.code == 'wrong-password') {
          anErrorOcurredMessage('e.message!');
        } else {
          anErrorOcurredMessage(e.message!.substring(e.message!.lastIndexOf(':') + 1, e.message!.indexOf('(') - 1));
        }
      }
    }

    FocusNode emailFocus = FocusNode();
    FocusNode passwordFocus = FocusNode();
    FocusNode confirmPasswordFocus = FocusNode();
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
                passwordFocus.unfocus();
                confirmPasswordFocus.requestFocus();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              focusNode: confirmPasswordFocus,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Confirm password',
                hintStyle: TextStyle(color: Colors.grey[400]),
                contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                filled: true,
                fillColor: Colors.grey[50],
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) {
                _confirmedPassword = value!;
              },
              onEditingComplete: () {
                signUserUp();
              },
            ),

            const SizedBox(
              height: 20,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  signUserUp();
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
                      'Sign Up',
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
