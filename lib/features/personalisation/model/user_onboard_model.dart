import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/constants/enums.dart';

class UserProfileModel {
  final String? userId;
  final String? avatarPath;
  final String? name;
  late final DateTime? dob;
  final String? gender;
  final String? occupation;
  final String? institution;
  final UserType userType;
  final bool isFirstTimeCreate;

  UserProfileModel({
    this.userId,
    this.avatarPath,
    this.name,
    this.dob,
    this.gender,
    this.occupation,
    this.institution,
    this.userType = UserType.individualConsumer,
    this.isFirstTimeCreate = true,
  });

  static UserProfileModel empty() => UserProfileModel(
    userId: '',
    avatarPath: '',
    name: '',
    dob: null,
    gender: '',
    occupation: '',
    institution: '',
    userType: UserType.individualConsumer,
    isFirstTimeCreate: true,
  );

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'avatarPath': avatarPath,
      'name': name,
      'dob': dob?.toIso8601String(),
      'gender': gender,
      'occupation': occupation,
      'institution': institution,
      'userType': userType.toString(),
      'isFirstTimeCreate': isFirstTimeCreate,
    };
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    userId: json['userId'],
    name: json['name'],
    dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
    gender: json['gender'],
    occupation: json['occupation'],
    institution: json['institution'],
    userType: UserType.values.firstWhere(
          (e) => e.toString() == json['userType'],
      orElse: () => UserType.individualConsumer,
    ),
    isFirstTimeCreate: json['isFirstTimeCreate'] ?? true,
  );

  factory UserProfileModel.fromDocument(DocumentSnapshot<Map<String,dynamic>> document ) {
    if(document.data() != null){
      final data = document.data()!;
      return UserProfileModel(
        userId: document.id,
        avatarPath: data['avatarPath']??'',
        name: data['name']??'',
        dob: data['dob'] != null ? DateTime.parse(data['dob']) : null ,
        gender: data['gender']??'',
        occupation: data['occupation']??'',
        institution: data['institution']??'',
        userType: UserType.values.firstWhere(
              (e) => e.toString() == data['userType'],
          orElse: () => UserType.individualConsumer,
        ),
        isFirstTimeCreate: data['isFirstTimeCreate'] ?? true,
      );
    }else{
      return UserProfileModel.empty();
    }
  }

}
