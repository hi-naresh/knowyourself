import 'package:get/get.dart';

class DashboardController extends GetxController{
  static DashboardController get instance => Get.find();

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12 && hour > 5) {
      return 'Good Morning, ';
    } else if (hour < 17 && hour > 12) {
      return 'Good Afternoon, ';
    }
    return 'Good Evening, ';
  }
}