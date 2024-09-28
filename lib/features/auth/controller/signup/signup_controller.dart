import 'package:get/get.dart';
import 'package:flutter/material.dart';


import '../../../../data/repo/auth/auth_repo.dart';
import '../../../../data/repo/user/remote/user_repo.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../personalisation/model/user_model.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //variables
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final fullName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  //functions
  void signup() async {
    try {
      //loader
      //check internet
      // final isConnected = await NetworkManager.instance.isConnected();
      // if(!isConnected) {
      //   KHelper.showSnackBar("No Internet", "Please check your internet connection");
      //   return;
      // }

      //check form
      if (!signupFormKey.currentState!.validate()) {
        KHelper.showSnackBar(KTexts.invalidFormTitle, KTexts.invalidFormMessage);
        return;
      }

      if (!privacyPolicy.value) {
        KHelper.showSnackBar(
          KTexts.acceptPrivacyPolicyTitle,
          KTexts.acceptPrivacyPolicyMessage,
        );
      }
      //register user to firebase
      final user = await AuthRepo.instance.registerUser(email.text.trim(), password.text.trim());


      //save auth user data
      final newUser = UserModel(
        id: user.user!.uid,
        email: user.user!.email!,
        fullName: fullName.text.trim(),
        username: email.text.trim().split('@').first,
      );

      final userRepo = Get.put(UserRepo());
      await userRepo.saveUserRecord(newUser);

      //show success
      KHelper.showSnackBar(
        KTexts.congratulationsTitle,
        KTexts.accountCreatedMessage,
      );
      //redirect to home
      // Get.offAllNamed(KRoutes.getMasterRoute());

    } catch (e) {
      KHelper.showSnackBar(KTexts.errorTitle, e.toString());
    }
    // finally{
    //   KHelper.showSnackBar("Some Error Encountered", " ");
    // }
  }
}
