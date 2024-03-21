import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String? id;
  final String? email;
  final String? fullName;
  final String? profilePhotoUrl;
  final String? username;

  UserModel({
    this.id,
    this.email,
    this.fullName,
    this.profilePhotoUrl,
    this.username,
  });

  //generate username from email
  String get usernameFromEmail => email!.split('@').first;
  //static method to create an empty user
  static UserModel empty() => UserModel(
    id: '',
    email: '',
    fullName: '',
    profilePhotoUrl: '',
    username: '',
  );

  //convert user data to json
  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'fullName': fullName,
    'profilePhotoUrl': profilePhotoUrl,
    'username': username,
  };

  //factory method to create user from json snapshot
  factory UserModel.fromDocument(DocumentSnapshot<Map<String,dynamic>> document ) {
    if(document.data() != null){
      final data = document.data()!;
      return UserModel(
        id: document.id,
        email: data['email']??'',
        fullName: data['fullName']??'',
        profilePhotoUrl: data['profilePhotoUrl']??'',
        username: data['username']??'',
      );
    }else{
      return UserModel.empty();
    }
  }
}