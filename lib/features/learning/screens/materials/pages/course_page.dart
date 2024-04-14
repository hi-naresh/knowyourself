import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/common/widgets/appbar/appbar.dart';
import 'package:knowyourself/features/learning/screens/materials/course_info_card.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../controller/course_controller.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CourseController());
    return Scaffold(
      appBar: const KAppBar(
        back: true,
      ),
      body: Obx(
          ()=> ListView.separated(
            separatorBuilder: (ctx, index) => const SizedBox(height: KSizes.defaultSpace),
          padding: const EdgeInsets.all(KSizes.md),
            itemCount: controller.materialsList.length,
            itemBuilder: (ctx, index) {
              final course = controller.materialsList[index];
              return CourseInfoCard(courseModel: course);
            },
        ),
      ),
    );
  }
}
