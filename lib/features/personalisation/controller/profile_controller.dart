import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/repo/auth/auth_repo.dart';
import '../../../routes.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  final deviceStorage = GetStorage();

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  //logout user
  void logoutUser() async {
    try{
      await AuthRepo.instance.logoutUser();
      await deviceStorage.remove("isLogged");
      Get.offAllNamed(KRoutes.getOnBoardingRoute());
    } catch (e){
      throw 'Something went Wrong. Try Again';
    }
  }
}