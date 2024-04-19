import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/routes.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:knowyourself/utils/constants/text_strings.dart';

import '../../../../../common/widgets/custom_container.dart';

class RecommendSection extends StatelessWidget {
  const RecommendSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomContainer(
      color: KColors.kApp1Light.withOpacity(0.9),
      padding: const EdgeInsets.all(KSizes.defaultSpace),
      onTap: ()=>Get.toNamed(KRoutes.getActivitiesRoute()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: KTexts.recommend,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextSpan(
                  text: "\n${KTexts.startYourDay}",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),

          ),
          Icon(
            CupertinoIcons.play_circle,
            size: KSizes.iconLg,
            color: Theme.of(context).iconTheme.color,
          ),
        ],
      ),
    );
  }
}
