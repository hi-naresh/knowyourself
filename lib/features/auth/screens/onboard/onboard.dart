import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controller/onboard/onboard_controller.dart';


class OnBoard extends StatelessWidget {
  const OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(KSizes.defaultSpace*2),
        child: Column(
          children: [
            Text(
              KTexts.onBoardingTitle,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
              ),
            const SizedBox(height:KSizes.spaceBtwItems),
            Text(
              KTexts.onBoardingSubtitle,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height:KSizes.defaultSpace*4),
            GestureDetector(
              onTap: () {
                // Get.toNamed(KRoutes.getRegisterRoute());
                controller.nextPage();
              },
              child: Text(
                KTexts.onBoardingTitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
