import 'package:flutter/material.dart';
import 'package:knowyourself/features/learning/screens/widgets/progress_bar.dart';
import 'package:knowyourself/utils/constants/image_strings.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../common/widgets/my_card.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/text_strings.dart';


class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                KTexts.learnHead,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: KSizes.defaultSpace),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyCard(
                      width: KSizes.wCardMedium,
                      height: KSizes.hCardMedium,
                      title: KTexts.mental,
                      color: kApp1,
                      imageUrl: KImages.mental),
                  MyCard(
                      width: KSizes.wCardMedium,
                      height: KSizes.hCardMedium,
                      title: KTexts.physical,
                      color: kApp2,
                      imageUrl: KImages.physical),
                ],
              ),
              const SizedBox(height: KSizes.defaultSpace),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyCard(
                      width: KSizes.wCardMedium,
                      height: KSizes.hCardMedium,
                      title: KTexts.vital,
                      color: kApp3,
                      imageUrl: KImages.vital),
                  MyCard(
                      width: KSizes.wCardMedium,
                      height: KSizes.hCardMedium,
                      title: KTexts.spiritual,
                      color: kApp4,
                      imageUrl:KImages.spiritual),
                ],
              ),
              const SizedBox(height: KSizes.defaultSpace),
              Text(
                KTexts.learnHead2,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: KSizes.defaultSpace),
              const LearningProgressBars(
                learningAspectsProgress: {
                  KTexts.mental: 0.65, // 75%
                  KTexts.physical: 0.5, // 50%
                  KTexts.vital: 0.7, // 90%
                  KTexts.spiritual: 0.6, // 60%
                },
              ),
              const SizedBox(height: KSizes.defaultSpace),
              Text(
                KTexts.learnHead3,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 300,
                // child: ArticleScreen(),
              ),
              const SizedBox(height: KSizes.defaultSpace*4),
            ],
          ),
        ),
      ),
    );
  }
}
