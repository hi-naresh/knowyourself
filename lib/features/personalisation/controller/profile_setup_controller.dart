import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/data/repo/auth/auth_repo.dart';
import 'package:knowyourself/routes.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';

import '../../../data/repo/user/local/user_profile_repo.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/text_strings.dart';
import '../model/user_onboard_model.dart';

class ProfileSetupController extends GetxController {
  static ProfileSetupController get instance => Get.find();

  final UserProfileRepo _repository = UserProfileRepo();
  final Rx<UserProfileModel> userProfile = UserProfileModel().obs;

  RxInt pageIndex = 0.obs;

  String get userID => AuthRepo.instance.authUser!.uid;

  RxString name = ''.obs;
  RxString avatar = ''.obs;
  Rx<DateTime?> dob = Rx<DateTime?>(null);
  final Rx<Gender> selectedGender = Gender.other.obs;
  RxString occupation = ''.obs;
  RxString institution = ''.obs;
  Rx<UserType?> userType = UserType.individualConsumer.obs;

  void setAvatar(String path) {
    // userProfile.update((val) {
    //   avatar.value = path;
    // });
    avatar.value = path;
  }

  final StreamSubscription<User?> _authListener = AuthRepo.instance.authStateChanges.listen((User? user) {
    if (user != null) {
      ProfileSetupController.instance.fetchUserProfile();
    } else {
      ProfileSetupController.instance.userProfile(UserProfileModel()); // Resets to an empty profile
    }
  });

  @override
  void onInit() {
    super.onInit();
    // Attach an auth state changes listener
    _authListener;
    userProfile.refresh();
  }

  @override
  void onClose() {
    super.onClose();
    _authListener.cancel(); // Don't forget to cancel the listener
    userProfile.close();
  }

  Future<void> fetchUserProfile() async {
    final user = AuthRepo.instance.authUser;
    if (user != null) {
      final fetchedProfile = await _repository.getUserProfile();
      userProfile(fetchedProfile);
      userProfile.refresh(); // This triggers the UI to update with the new profile
    } else {
      userProfile(UserProfileModel()); // Resets to an empty profile
    }
  }

  // Future<void> updateProfile() async {
  //   final userProfileValue = UserProfileModel(
  //     occupation: occupation.value,
  //     institution: institution.value,
  //     userType: userType.value!.toString().split('.').last,
  //   );
  //   _repository.updateUserProfile(userProfileValue);
  //   userProfile(userProfileValue);
  //   userProfile.refresh();
  //   Get.back();
  //   KHelper.showSnackBar('Profile Updated', 'Your profile has been updated successfully.');
  //
  // }
  Future<void> updateProfile() async {
    final updatedProfile = userProfile.value.copyWith(
      name: name.value,
      avatarPath: avatar.value,
      occupation: occupation.value,
      institution: institution.value,
      userType: userType.value?.toString().split('.').last,
    );

    await _repository.updateUserProfile(updatedProfile);

    // This updates the local observable UserProfileModel with the new values
    userProfile.value = updatedProfile;

    // Since we updated the whole value, this line is redundant:
    // userProfile.refresh();

    Get.back();
    KHelper.showSnackBar(KTexts.profileUpdated, KTexts.profileUpdatedMessage);
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
        gender: selectedGender.value.toString().split('.').last,
        occupation: occupation.value,
        institution: institution.value,
        userType: userType.value!.toString().split('.').last,
        isFirstTimeCreate: false,
      );
      _repository.saveUserProfile(userProfileValue);
      userProfile(userProfileValue);
      userProfile.refresh();
      Get.offAllNamed(KRoutes.getReviewAskRoute());
    } else {
      KHelper.showSnackBar(KTexts.completeDetails, KTexts.completeDetailsMessage);
    }
  }

  bool _validateInputs() {
    if (name.isEmpty || dob.value == null || occupation.isEmpty || institution.isEmpty || userType.value == null) {
      return false;
    }
    return true;
  }

  bool _validatePage1Inputs() {
    if (name.isEmpty) {
      return false;
    }
    return true;
  }

  bool _validatePage2Inputs() {
    if (dob.value == null ) {
      return false;
    }
    return true;
  }

  bool _validatePage3Inputs() {
    if (occupation.isEmpty || institution.isEmpty || userType.value == null) {
      return false;
    }
    return true;
  }

  void goToNextPage(){
    if(pageIndex.value == 0){
      if(_validatePage1Inputs()){
        pageIndex.value++;
      }else{
        KHelper.showSnackBar(KTexts.fillUpDetails, KTexts.fillUpDetailsMessage);
      }
    }else if(pageIndex.value == 1){
      if(_validatePage2Inputs()){
        pageIndex.value++;
      }else{
        KHelper.showSnackBar(KTexts.fillUpDetails, KTexts.fillUpDetailsMessage);
      }
    }else if(pageIndex.value == 2){
      if(_validatePage3Inputs()){
        finishOnboarding();
      }else{
        KHelper.showSnackBar(KTexts.fillUpDetails, KTexts.fillUpDetailsMessage);
      }
    }
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

}
