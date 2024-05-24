import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/routes.dart';
import 'package:knowyourself/utils/constants/image_strings.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:knowyourself/utils/device/device_utility.dart';
import 'package:lottie/lottie.dart';

import '../../../../../utils/constants/text_strings.dart';

class PromptReviewTest extends StatelessWidget {
  const PromptReviewTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset(KImages.health16,width: 300,),
            Lottie.asset(
                KImages.meditateAnim,
                repeat: true,
                reverse: true,
                animate: true,
                frameRate: FrameRate.max,
                width: double.infinity,),
            const SizedBox(height: KSizes.spaceBtwSections),
            Text(
              KTexts.reviewTestPrompt,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: KSizes.spaceBtwItems),
            Text(
              KTexts.reviewTestDescription,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: KSizes.spaceBtwSections),
            TextButton(
              // onPressed: () => AuthRepo.instance.screenRedirect(),
              onPressed: () => Get.offAllNamed(KRoutes.getMasterRoute()),
              child: Text(KTexts.skipForNowButton, style : Theme.of(context).textTheme.titleLarge),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: KSizes.defaultSpace,vertical: KDeviceUtils.getBottomNavigationBarHeight()/2),
        child: ElevatedButton(
          onPressed: ()=> Get.toNamed(KRoutes.getChoiceScreenRoute()),
          child: const Text(KTexts.takeReviewTestButton),
        ),
      )
    );
  }
}
