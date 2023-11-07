import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:knowyourself/screens/Home/home_screen.dart';

import '../../auth/auth_service.dart';
import '../Extras/Avatar Select Screen/avatar_select_screen.dart';
import '../widgets/AppButtons.dart';
import '../widgets/Constants.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/CustomField.dart';

class SignupInfoScreen extends StatefulWidget {
  const SignupInfoScreen({super.key});

  @override
  _SignupInfoScreenState createState() => _SignupInfoScreenState();
}

class _SignupInfoScreenState extends State<SignupInfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isPasswordValid(String password) {
    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return password.length >= 6 &&
        hasDigits &&
        hasUppercase &&
        hasLowercase &&
        hasSpecialCharacters;
  }

  String? _validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter an email address';
    }

    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9._%-]+@aurouniversity.edu.in$").hasMatch(email)) {
      return 'Enter a valid email from @aurouniversity.edu.in';
    }

    return null;
  }

  Future<void> signUp(String fullName, String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.updateDisplayName(fullName);

      final CollectionReference users = _firestore.collection('users');
      await users.doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'email': email,
        // 'phoneNumber': phoneNumber,
      });

      // Navigate to Home Screen upon successful signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AvatarSelectScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Signup failed. Please try again.';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Signup failed: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Sign Up'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      myField(
                          context,
                          'Full Name',
                          _fullNameController,
                          false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          }
                      ),
                      myField(
                          context,
                          'Email',
                          _emailController,
                          false,
                          validator: _validateEmail
                      ),
                      myField(
                          context,
                          'Password',
                          _passwordController,
                          true,
                          subLabel: '\n Password must be at least 6 chars long, with special\n char, upper & lower case, and digits',
                          validator: (value) {
                            if (value == null || !_isPasswordValid(value)) {
                              return 'Password must be at least 6 chars long, with special char, upper & lower case, and digits';
                            }
                            return null;
                          }
                      ),
                      myField(
                          context,
                          'Confirm Password',
                          _confirmPasswordController,
                          true,
                          validator: (value) {
                            if (value == null || value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          }
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: appButtonFunc(
                  context,
                  gradient(context),
                  'Sign Up',
                      () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      await signUp(
                        _fullNameController.text.trim(),
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                    }
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
