import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class UserModel {
  final String? uid;
  final String? email;
  final String? fullName;
  final String? phoneNumber;
  final String? profilePhotoUrl;

  UserModel({
    this.uid,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.profilePhotoUrl,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>?; // Cast the data to a Map.
    if (data == null) {
      throw Exception("Document data is null");
    }
    return UserModel(
      uid: doc.id,
      email: data['email'] as String?,
      fullName: data['fullName'] as String?,
      phoneNumber: data['phoneNumber'] as String?,
      profilePhotoUrl: data['profilePhotoUrl'] as String?,
    );
  }

  static Future<UserModel> fetchCurrentUserDetails() async {
    final userId = firebase_auth.FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      try {
        final userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userSnapshot.exists) {
          UserModel user = UserModel.fromDocument(userSnapshot);
          return user;
        } else {
          print('User document does not exist');
          throw Exception('User not found');
        }
      } catch (e) {
        print('Error retrieving user data: $e');
        throw e;
      }
    } else {
      throw Exception('User not logged in');
    }
  }
}
