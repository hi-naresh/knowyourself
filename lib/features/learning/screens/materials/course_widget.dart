import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/learning/controller/resources_controller.dart';
import 'package:knowyourself/features/learning/screens/materials/pages/resources_page.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/enums.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../../../../common/widgets/my_card.dart';
import '../../../../utils/constants/text_strings.dart';

class CourseSection extends StatelessWidget {
  const CourseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final resources = [
      {"title": KTexts.auroSocietyTitle, "color": KColors.kApp1,"type":ResourceType.auroSociety},
      {"title": KTexts.magazinesAndNewslettersTitle, "color": KColors.kApp2,"type":ResourceType.magazine},
      {"title": KTexts.videosTitle, "color": KColors.kApp1,"type":ResourceType.video},
      {"title": KTexts.eBooksTitle, "color": KColors.kApp4,"type":ResourceType.eBooks},
      {"title": KTexts.guideTitle, "color": KColors.kApp3,"type":ResourceType.guide},
      {"title": KTexts.centersTitle, "color": KColors.kApp4,"type":ResourceType.centers},

    ];
    final controller = Get.put(ResourcesController());

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
            controller.setType(resource["type"] as ResourceType);
            Get.to(() => const ResourcesPage());
          },
        );
      },
    );
  }
}
