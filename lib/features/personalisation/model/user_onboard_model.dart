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
  final String? userType;
  final bool isFirstTimeCreate;
  final int? rewardPoints;

  UserProfileModel({
    this.userId,
    this.avatarPath,
    this.name,
    this.dob,
    this.gender,
    this.occupation,
    this.institution,
    this.userType,
    this.isFirstTimeCreate = true,
    this.rewardPoints,
  });

  static UserProfileModel empty() => UserProfileModel(
    userId: '',
    avatarPath: '',
    name: '',
    dob: null,
    gender: '',
    occupation: '',
    institution: '',
    // userType: UserType.individualConsumer,
    userType: UserType.individualConsumer.toString(),
    isFirstTimeCreate: true,
    rewardPoints: 0,
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
      'rewardPoints': rewardPoints??0,
    };
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    userId: json['userId'],
    avatarPath: json['avatarPath'],
    name: json['name'],
    dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
    gender: json['gender'],
    occupation: json['occupation'],
    institution: json['institution'],
    // userType: UserType.values.firstWhere(
    //       (e) => e.toString() == json['userType'],
    //   orElse: () => UserType.individualConsumer,
    // ),
    userType: json['userType'],
    isFirstTimeCreate: json['isFirstTimeCreate'] ?? true,
    rewardPoints: json['rewardPoints']??0,
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
        // userType: UserType.values.firstWhere(
        //       (e) => e.toString() == data['userType'],
        //   orElse: () => UserType.individualConsumer,
        // ),
        userType: data['userType']??'',
        isFirstTimeCreate: data['isFirstTimeCreate'] ?? true,
        rewardPoints: data['rewardPoints']??0,
      );
    }else{
      return UserProfileModel.empty();
    }
  }

}
