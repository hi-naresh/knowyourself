import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/learning/screens/materials/pages/course_page.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/enums.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../../../../common/widgets/my_card.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controller/course_controller.dart';

class CourseSection extends StatelessWidget {
  const CourseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final resources = [
      {"title": KTexts.auroSocietyTitle, "color": KColors.kApp1,"type":CourseType.auroSociety},
      {"title": KTexts.magazinesAndNewslettersTitle, "color": KColors.kApp2,"type":CourseType.magazine},
      {"title": KTexts.videosTitle, "color": KColors.kApp1,"type":CourseType.video},
      {"title": KTexts.eBooksTitle, "color": KColors.kApp4,"type":CourseType.eBooks},
      {"title": KTexts.guideTitle, "color": KColors.kApp3,"type":CourseType.guide},
      {"title": KTexts.centersTitle, "color": KColors.kApp4,"type":CourseType.centers},

    ];
    final controller = Get.put(CourseController());

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: resources.length,
      padding: const EdgeInsets.all(KSizes.zero),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: KSizes.defaultSpace,
        mainAxisSpacing: KSizes.defaultSpace,
      ),
      itemBuilder: (context, index) {
        final Map<String, dynamic> resource = resources[index];
        return MyCard(
          title: resource["title"] as String,
          color: resource["color"] as Color,
          onTap: () {
            controller.setType(resource["type"] as CourseType);
            Get.to(() => const CoursePage());
          },
        );
      },
    );
  }
}
