import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repo/auth/auth_repo.dart';
import '../../../../utils/helpers/helper_functions.dart';

class PasswordResetController extends GetxController{
  static PasswordResetController instance = Get.find();

  final email =TextEditingController();
  GlobalKey<FormState> passwordResetFormKey = GlobalKey<FormState>();

  void resetPassword() async{
    try{
      // final isConnected = await NetworkManager.instance.isConnected();
      // if (!isConnected) {
      //   KHelper.showSnackBar("No Internet", "Please check your internet connection");
      //   return;
      // }
      if (!passwordResetFormKey.currentState!.validate()) {
        KHelper.showSnackBar("Invalid Email", "Please write your Email correctly");
        return;
      }

      await AuthRepo.instance.resetPassword(email.text.trim());

      KHelper.showSnackBar("Email sent!", "Password reset link sent to your email");
      Get.back();
    }catch(e){
      Get.snackbar('Error', e.toString(),snackPosition: SnackPosition.BOTTOM);
    }
  }
}