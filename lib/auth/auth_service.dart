import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final currentUser = FirebaseAuth.instance.currentUser;

  Future<bool> isUserSignedIn() async {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSignedIn', false);
    // Perform any other sign-out related actions
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
    } catch (e) {
      if (kDebugMode) {
        throw Exception('Signup failed: $e');
      }
    }
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User signed in successfully
      return userCredential;
    } catch (e) {
      // Forward the error for handling
      throw e;
    }
  }

  Future<UserCredential> signInWithCredential(
      PhoneAuthCredential credential) async {
    return await _auth.signInWithCredential(credential);
  }

}