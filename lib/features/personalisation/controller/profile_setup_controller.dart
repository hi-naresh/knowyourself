import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/data/repo/auth/auth_repo.dart';
import 'package:knowyourself/features/personalisation/controller/user_controller.dart';
import 'package:knowyourself/features/personalisation/screens/profile/pages/profile_review_ask.dart';
import 'package:knowyourself/routes.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';

import '../../../data/repo/user/local/user_profile_repo.dart';
import '../../../utils/constants/enums.dart';
import '../model/user_onboard_model.dart';

class ProfileSetupController extends GetxController {
  static ProfileSetupController get instance => Get.find();

  final UserProfileRepo _repository = UserProfileRepo();
  final Rx<UserProfileModel> userProfile = UserProfileModel().obs;

  RxInt pageIndex = 0.obs;

  RxString name = ''.obs;
  RxString avatar = ''.obs;
  Rx<DateTime?> dob = Rx<DateTime?>(null);
  RxList<bool> genderSelections = RxList<bool>([false, false, false]);
  RxString occupation = ''.obs;
  RxString institution = ''.obs;
  Rx<UserType?> userType = UserType.regularUser.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final fetchedProfile = await _repository.getUserProfile();
    userProfile(fetchedProfile);
  }

  void setGender(int index) {
    for (int i = 0; i < genderSelections.length; i++) {
      genderSelections[i] = i == index;
    }
    genderSelections.refresh(); // Trigger update in UI
  }

  void goToNextPage() {
    if (pageIndex.value < 3) pageIndex.value++;
  }

  void goToPreviousPage() {
    if (pageIndex.value > 0) {
      pageIndex.value--;
    } else {
      Get.back();
    }
  }

  void finishOnboarding() {
    if (_validateInputs()) {
      final userProfileValue = UserProfileModel(
        userId: AuthRepo.instance.authUser!.uid,
        name: name.value,
        avatarPath: avatar.value,
        dob: dob.value,
        gender: genderSelections[0] ? 'Male' : genderSelections[1] ? 'Female' : 'Other',
        occupation: occupation.value,
        institution: institution.value,
        userType: userType.value == UserType.regularUser ? UserType.regularUser : UserType.sailcMember,
        isFirstTimeCreate: false,
      );
      _repository.saveUserProfile(userProfileValue);
      userProfile(userProfileValue);
      userProfile.refresh();
      Get.offAllNamed(KRoutes.getReviewAskRoute());
    } else {
      KHelper.showSnackBar('Error', 'Please fill in all the fields correctly.');
    }
  }

  bool _validateInputs() {
    if (name.isEmpty || dob.value == null || !genderSelections.contains(true) || occupation.isEmpty || institution.isEmpty || userType.value == null) {
      return false;
    }
    return true;
  }

  void setDOB(DateTime value) => userProfile.update((val) {
    val?.dob = value;
  });

  void pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      dob.value = pickedDate;
    }
  }

  void setAvatar(String value) {
    avatar.value = value;
  }

}
