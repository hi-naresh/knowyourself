import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/common/widgets/appbar/pagebar.dart';
import 'package:knowyourself/common/widgets/custom_container.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../controller/chapter_controller.dart';
import '../../model/chapter_model.dart';

class ChapterLearningScreen extends StatelessWidget {
  final LearningController controller = Get.put(LearningController());

  ChapterLearningScreen({super.key, required String aspect}) {
    // controller.loadMaterialsForAspect(aspect);
    controller.loadMaterialsFromJson(aspect);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KPageBar(
        title: KTexts.learningMaterialsTitle,
        onTap: () => Get.back(),
      ),
      body: Obx(() => ListView.builder(
            padding: const EdgeInsets.all(KSizes.md),
            itemCount: controller.chaptersList.length,
            itemBuilder: (context, index) {
              ChapterModel material = controller.getMaterialAtIndex(index);
              return CustomContainer(
                padding: const EdgeInsets.all(KSizes.sm),
                margin: const EdgeInsets.only(bottom: KSizes.md),
                child: ListTile(
                  minVerticalPadding: KSizes.md,
                  // tileColor: KHelper.isDark()? kEmptyProgressDark : kEmptyProgress,
                  title: Text(overflow: TextOverflow.ellipsis, material.title),
                  subtitle:
                      Text(overflow: TextOverflow.ellipsis, material.subTitle),
                  // leading: CircularProgressIndicator(value: material.progress),
                  trailing: material.progress == 1 ?
                  const Icon(
                  CupertinoIcons.checkmark_alt_circle_fill,
                  color: KColors.kApp3,
                  size: KSizes.iconLg,
                ) : material.progress > 0 ?
                  CircularProgressIndicator(
                strokeWidth: 6.0,
                value: material.progress,
                backgroundColor: KHelper.isDark()
                    ? KColors.kEmptyProgressDark
                    : KColors.kEmptyProgress,
                valueColor: AlwaysStoppedAnimation<Color>(
                    KHelper.isDark() ? KColors.kEmptyProgressDark : KColors.kApp3),
              ) : null,
                  onTap: () => controller.navigateToChapterContent(index),
                ),
              );
            },
          )),
    );
  }
}

class ChapterContentView extends StatelessWidget {
  final int index;

  const ChapterContentView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    LearningController controller = Get.find();
    ChapterModel material = controller.getMaterialAtIndex(index);

    return Scaffold(
      appBar: KPageBar(
        title: material.title.split(":").first,
        onTap: () => Get.back(),
        action: IconButton(
          icon: const Icon(CupertinoIcons.clear_circled),
          onPressed: () => controller.closeChapterContent(),
        ),
      ),
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        itemCount: material.contentChunks.length, // Include one more for the quiz
        itemBuilder: (context, pageIndex) {
          if (pageIndex < material.contentChunks.length) {
            return buildContentPage(context, material.contentChunks[pageIndex], pageIndex, material.contentChunks.length);
          }
          // else {
          //   return buildQuizPage(context, material.quizQuestions ?? [], index);
          // }
        },
      ),
    );
  }

  Widget buildContentPage(BuildContext context, String content, int pageIndex, int totalLength) {
    final LearningController controller = Get.find();
    return Padding(
      padding: const EdgeInsets.all(KSizes.defaultSpace),
      child: Column(
        children: [
          Expanded(
              child: Text(
                content,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyMedium,
              )
          ),
          if (pageIndex == totalLength - 1)
            ElevatedButton(
              onPressed: ()=> controller.chapterCompleted(index),
              child: const Text(KTexts.completeChapter),
            ),
          if (pageIndex < totalLength - 1)
            ElevatedButton(
              onPressed: () => controller.jumpToNextPage(index),
              child: const Text(KTexts.nextPage),
            ),
        ],
      ),
    );
  }

  // Widget buildQuizPage(BuildContext context, List<QuizModel> questions, int chapterIndex) {
  //   final LearningController controller = Get.find();
  //   //each question on new page and must have button answer and next question
  //   return Padding(
  //     padding: const EdgeInsets.all(KSizes.defaultSpace),
  //     child: Column(
  //       children: [
  //         Expanded(
  //           child: PageView.builder(
  //             itemCount: questions.length,
  //             itemBuilder: (context, questionIndex) {
  //               QuizModel question = questions[questionIndex];
  //               return Column(
  //                 children: [
  //                   Text(question.question,
  //                     textAlign: TextAlign.center,
  //                     style: Theme.of(context).textTheme.headlineMedium,
  //                   ),
  //                   const SizedBox(height: KSizes.defaultSpace),
  //                   ListView.builder(
  //                     shrinkWrap: true,
  //                     physics: const NeverScrollableScrollPhysics(),
  //                     itemCount: question.options.length,
  //                     itemBuilder: (context, answerIndex) {
  //                       return RadioListTile(
  //                         title: Text(question.options[answerIndex]),
  //                         value: answerIndex,
  //                         groupValue: question.correctAnswerIndex,
  //                         onChanged: (value) {
  //                           controller.answerQuizQuestion(chapterIndex, questionIndex, value!);
  //                         },
  //                       );
  //                     },
  //                   ),
  //                 ],
  //               );
  //             },
  //           ),
  //         ),
  //         if (controller.getSelectedOptionForQuestion(chapterIndex, questions.length - 1) != null)
  //           ElevatedButton(
  //             onPressed: () => controller.chapterCompleted(index),
  // child: const Text(KTexts.completeChapter),
  //           ),
  //       ],
  //     ),
  //   );
  // }
}

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
