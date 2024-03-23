import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/add_mood_controller.dart';

class AddMoodScreen extends StatelessWidget {
  const AddMoodScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddMoodController());
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      children: controller.journalPages,
    );
  }
}