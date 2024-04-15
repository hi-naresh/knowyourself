import 'package:get/get.dart';

import '../../../utils/constants/text_strings.dart';

class DashboardController extends GetxController{
  static DashboardController get instance => Get.find();

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12 && hour > 5) {
      // return 'Good Morning, ';
      return '${KTexts.goodMorning}, ';
    } else if (hour < 17 && hour > 12) {
      return '${KTexts.goodAfternoon}, ';
    }
    return '${KTexts.goodEvening}, ';
  }
}