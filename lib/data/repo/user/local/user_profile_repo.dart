import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knowyourself/data/repo/user/user_repo.dart';

import '../../../../features/personalisation/model/user_onboard_model.dart';

class UserProfileRepo {

  static UserProfileRepo get instance => Get.find();

  final GetStorage _box = GetStorage();

  static const String _userProfileKey = 'user_profile';

  void saveUserProfile(UserProfileModel userProfile) {
    _box.write(_userProfileKey, userProfile.toJson());
    UserRepo.instance.addNewCollectionUnderUser(_userProfileKey,userProfile.toJson());
  }

  void removeUserProfile() {
    _box.remove(_userProfileKey);
  }

  void updateUserProfile(UserProfileModel userProfile) {
    _box.write(_userProfileKey, userProfile.toJson());
  }

  UserProfileModel? getUserProfile() {
    final json = _box.read<Map<String, dynamic>>(_userProfileKey);
    if (json != null) {
      return UserProfileModel.fromJson(json);
    }
    return null;
  }
}