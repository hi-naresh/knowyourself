import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../data/repo/auth/auth_repo.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../personalisation/controller/user_controller.dart';

class LoginController extends GetxController{
  static LoginController get instance => Get.find();

  //variables
  final rememberMe =false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email =TextEditingController();
  final password =TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  GlobalKey<FormState> get loginFormKey => _loginFormKey;


  //function login
  Future<void> emailLogin() async{
    try{
      // final isConnected = await NetworkManager.instance.isConnected();
      // if(!isConnected) {
      //   KHelper.showSnackBar("No Internet", "Please check your internet connection");
      //   return;
      // }
      //check form
      if (!_loginFormKey.currentState!.validate()) {
        KHelper.showSnackBar(KTexts.invalidFormTitle, KTexts.invalidFormMessage);
        return;
      }
      if(rememberMe.value){
        final String rememberEmail= email.text.trim().toString();
        final String rememberPass = password.text.trim().toString();
        localStorage.writeIfNull("REMEMBER_ME_EMAIL", rememberEmail);
        localStorage.writeIfNull("REMEMBER_ME_PASSWORD",rememberPass );
      }

      await AuthRepo.instance.loginUser(email.text.trim(), password.text.trim());
      //redirect
      KHelper.showSnackBar(KTexts.loginSuccessTitle, KTexts.loginSuccessMessage);
      AuthRepo.instance.screenRedirect();

    }catch(e){
      KHelper.showSnackBar(KTexts.errorTitle, e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // final isConnected = await NetworkManager.instance.isConnected();
      // if (!isConnected) {
      //   KHelper.showSnackBar("No Internet", "Please check your internet connection");
      //   return;
      // }
      final userCredentials = await AuthRepo.instance.signInWithGoogle();
      //redirect
      await userController.saveUserRecord(userCredentials);

      KHelper.showSnackBar(KTexts.loginSuccessTitle, KTexts.loginSuccessMessage);
      AuthRepo.instance.screenRedirect();
    } catch (e) {
      KHelper.showSnackBar(KTexts.errorTitle, e.toString());
    }
  }

  @override
  void onInit() {
    // email.text = localStorage.read("REMEMBER_ME_EMAIL").toString();
    // password.text = localStorage.read("REMEMBER_ME_PASSWORD").toString();
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }

}