import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:knowyourself/screens/Extras/Avatar%20Select%20Screen/avatar_select_screen.dart';
import 'package:knowyourself/screens/Home/home_screen.dart';
import '../../auth/auth_service.dart';
import '../Main Screen/main_screen.dart';
import '../widgets/AppButtons.dart';
import '../widgets/Constants.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/CustomError.dart';
import '../widgets/CustomField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthService _authService = AuthService(); // Add this line

  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      UserCredential userCredential = await _authService.signIn(email, password);

      // Navigate to the next screen (CreatePasscode screen)
      Timer(const Duration(seconds: 0), () {
        showGlobalSnackBar(context, 'Logged in successfully');
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AvatarSelectScreen()),
        );
      });
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          // User with the specified email doesn't exist
          showGlobalSnackBar(context,'Please sign up first.');
        } else if (e.code == 'wrong-password') {
          // User with the specified email exists but entered the wrong password
          showGlobalSnackBar(context,'Incorrect password.');
        } else {
          // Other login errors
          showGlobalSnackBar(context,'Login failed. Error: ${e.message}');
        }
      } else {
        // Other errors
        showGlobalSnackBar(context,'Login failed. Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: myAppBar(context, 'Sign In'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            myField(context, 'Email', emailController, false),
            myField(context, 'Password', passwordController, true),
            const SizedBox(height: 16.0),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: appButtonFunc(context,margin: const EdgeInsets.only(bottom: 10.0),
                      gradient(context), 'Sign In', login)),
            )
          ],
        ),
      ),
    );
  }
}
