import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/learning/controller/resources_controller.dart';
import 'package:knowyourself/features/learning/model/resources_model.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../../common/widgets/custom_container.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class CourseInfoCard extends StatelessWidget {
  final ResourcesModel courseModel;
  const CourseInfoCard({super.key,required this.courseModel});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResourcesController());
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //image
          ClipRRect(
            borderRadius: BorderRadius.circular(KSizes.borderRadiusLg),
            child: Image.asset(
              courseModel.imageUrl,
              width: double.infinity,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          //title
          const SizedBox(
            height: KSizes.spaceBtwItems,
          ),
          Text(
            courseModel.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          //text
          const SizedBox(
            height: KSizes.spaceBtwItems,
          ),

          Text(
              courseModel.description,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.justify,
              // overflow: TextOverflow.ellipsis,
              // maxLines: 10,
          ),
          TextButton(
            onPressed: () {
              KHelper.launchUrl(courseModel.url);
            },
            child:
                Text( KTexts.viewNow, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
