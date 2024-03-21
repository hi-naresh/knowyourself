import 'package:get/get.dart';

import '../../../../routes.dart';

class OnBoardController extends GetxController {
  static OnBoardController get instance => Get.find();

  void nextPage(){
    Get.toNamed(KRoutes.getLoginRoute());
  }

}