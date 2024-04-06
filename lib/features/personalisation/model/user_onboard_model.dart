import '../../../utils/constants/enums.dart';

class UserProfileModel {
  String? userId;
  String? avatarPath;
  String? name;
  DateTime? dob;
  String? gender;
  String? occupation;
  String? institution;
  UserType userType;
  bool isFirstTimeCreate;

  UserProfileModel({
    this.userId,
    this.avatarPath,
    this.name,
    this.dob,
    this.gender,
    this.occupation,
    this.institution,
    this.userType = UserType.regularUser,
    this.isFirstTimeCreate = true,
  });

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
      orElse: () => UserType.regularUser,
    ),
    isFirstTimeCreate: json['isFirstTimeCreate'] ?? true,
  );


}
