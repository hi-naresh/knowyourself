import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knowyourself/data/repo/user/user_repo.dart';

import '../../../../features/personalisation/model/user_onboard_model.dart';

class UserProfileRepo {

  static UserProfileRepo get instance => Get.find();

  final GetStorage _storage = GetStorage();

  static const String _userProfileKey = 'user_profile';

  void saveUserProfile(UserProfileModel userProfile) {
    _storage.writeIfNull(_userProfileKey, userProfile);
    UserRepo.instance.addNewCollectionUnderUser(_userProfileKey,userProfile.toJson());
  }

  void removeUserProfile() {
    _storage.remove(_userProfileKey);
  }

  void updateUserProfile(UserProfileModel userProfile) {
    _storage.write(_userProfileKey, userProfile.toJson());
  }

  Future<UserProfileModel> getUserProfile() async {
    final json = _storage.read(_userProfileKey);
    if (json != null) {
      return UserProfileModel.fromJson(json);
    }else {
      final userProfile = await fetchUserProfileData();
      _storage.write(_userProfileKey, userProfile.toJson());
      return userProfile;
    }
  }

  Future<UserProfileModel> fetchUserProfileData() {
    return UserRepo.instance.fetchUserProfileFirestore();
  }

}