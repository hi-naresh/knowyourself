import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:knowyourself/routes.dart';

import '../../../../data/repo/auth/auth_repo.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class PasswordResetController extends GetxController{
  static PasswordResetController instance = Get.find();

  final emailReset =TextEditingController();
  final GlobalKey<FormState> _passwordResetFormKey = GlobalKey<FormState>();

  //getter for form key
  GlobalKey<FormState> get passwordResetFormKey => _passwordResetFormKey;

  @override
  void onClose() {
    emailReset.dispose();
    super.onClose();
  }

  void resetPassword() async{
    try{
      // final isConnected = await NetworkManager.instance.isConnected();
      // if (!isConnected) {
      //   KHelper.showSnackBar("No Internet", "Please check your internet connection");
      //   return;
      // }
      if (!_passwordResetFormKey.currentState!.validate()) {
        KHelper.showSnackBar(
          KTexts.invalidEmailTitle,
          KTexts.invalidEmailMessage,
        );
        return;
      }

      await AuthRepo.instance.resetPassword(emailReset.text.trim());
      KHelper.showSnackBar(
        KTexts.emailSentTitle,
        KTexts.emailSentMessage,
      );
      Get.toNamed(KRoutes.getLoginRoute());
    }catch(e){
      Get.snackbar(KTexts.error, e.toString(),snackPosition: SnackPosition.BOTTOM);
    }
  }
}