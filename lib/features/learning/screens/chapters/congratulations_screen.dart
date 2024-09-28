import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/common/widgets/appbar/pagebar.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../controller/chapter_controller.dart';


class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LearningController controller = Get.find();
    return Scaffold(
      appBar: KPageBar(
        title: KTexts.congratulationsTitle,
        onTap: () => controller.closeChapterContent(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(KSizes.defaultSpace),
        child: Column(
          children: [
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.checkmark_alt_circle_fill,
                      color: KColors.kApp3,
                      size: KSizes.xxl,
                    ),
                    const SizedBox(height: KSizes.defaultSpace),
                    Text(
                      KTexts.congratulationsMessage,
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                )
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: KColors.kApp3,
              ),
              onPressed: () {
                KHelper.launchUrl("https://incarnateword.in/compilations");
              },
              child: const Text("In-Depth Reading"),
            ),
            const SizedBox(height: KSizes.defaultSpace),
            ElevatedButton(
              onPressed: () {
                controller.closeChapterContent();
                Get.back();
              },
              child: const Text(KTexts.close),
            ),
          ],
        ),
      ),
    );
  }
}
