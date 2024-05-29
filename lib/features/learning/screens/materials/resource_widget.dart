import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/learning/screens/materials/pages/resources_page.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/enums.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../../../../common/widgets/my_card.dart';
import '../../controller/resources_controller.dart';

class CourseSection extends StatelessWidget {
  const CourseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final resources = [
      {"title": "Auro Society", "color": KColors.kApp1,"type":ResourceType.auroSociety},
      {"title": "Magazines", "color": KColors.kApp2,"type":ResourceType.magazine},
      {"title": "Videos", "color": KColors.kApp1,"type":ResourceType.video},
      {"title": "E-books", "color": KColors.kApp4,"type":ResourceType.eBooks},
      {"title": "Guide", "color": KColors.kApp3,"type":ResourceType.guide},
      {"title": "Centers", "color": KColors.kApp4,"type":ResourceType.centers},
    ];
    final controller = Get.put(ResourcesController());

    return Column(
      children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: resources.length,
          padding: const EdgeInsets.all(KSizes.zero),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.5,
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
        ),
        const SizedBox(height: KSizes.defaultSpace),
        // ElevatedButton(onPressed: (){},
        //     child: Text("More resources", style: Theme.of(context).textTheme.titleMedium?.copyWith(
        //       color: KColors.white,
        //       fontWeight: FontWeight.bold
        //     )
        //     ) )
      ],
    );
  }
}
