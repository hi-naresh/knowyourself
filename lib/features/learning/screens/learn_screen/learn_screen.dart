import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowyourself/features/learning/screens/learn_screen/widgets/progress_bar.dart';
import 'package:knowyourself/features/learning/screens/materials/course_widget.dart';
import 'package:knowyourself/utils/constants/image_strings.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/my_card.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controller/article_controller.dart';
import 'package:get/get.dart';

import '../articles/article_widget.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ArticleController());
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
                      fontSize: 26,
                      imageUrl: KImages.mental,
                  ),
                  MyCard(
                      width: KSizes.wCardMedium,
                      height: KSizes.hCardMedium,
                      title: KTexts.physical,
                      color: kApp2,
                      fontSize: 26,
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
                      fontSize: 26,

                      imageUrl: KImages.vital),
                  MyCard(
                      width: KSizes.wCardMedium,
                      height: KSizes.hCardMedium,
                      title: KTexts.spiritual,
                      color: kApp4,
                      fontSize: 26,
                      imageUrl: KImages.spiritual),
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
                "Resources Available",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: KSizes.defaultSpace),
              const CourseSection(),
              const SizedBox(height: KSizes.defaultSpace),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    KTexts.learnHead3,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  IconButton(
                    onPressed: () => controller.deleteCache(),
                    icon: const Icon(
                      CupertinoIcons.refresh_circled,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: KSizes.defaultSpace),
              SizedBox(
                height: Get.height*0.5,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 10,
                        direction: Axis.horizontal,
                        children: LifeAspects.values.map((aspect) {
                          return Obx(
                            () => ChoiceChip(
                              backgroundColor: KHelper.isDark()
                                  ? kEmptyProgressDark
                                  : kEmptyProgress,
                              selectedColor: kApp3Light,
                              label: Text(
                                  aspect.toString().split('.').last.capitalize!),
                              selected: controller.selectedAspect.value == aspect,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: kApp3,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.all(10),
                              disabledColor: kEmptyProgress,
                              onSelected: (_) => controller.changeAspect(aspect),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Expanded(
                      child: Obx(() {
                        if (controller.articles.isNotEmpty) {
                          return ListView.builder(
                            itemCount: controller.filteredArticles.length,
                            itemBuilder: (context, index) {
                              return ArticleWidget(
                                  article: controller.filteredArticles[index]);
                            },
                          );
                        } else {
                          // Show a loading indicator or a placeholder widget instead.
                          return const Center(child: CircularProgressIndicator());
                        }
                      }),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: KSizes.defaultSpace * 4),
            ],
          ),
        ),
      ),
    );
  }
}
