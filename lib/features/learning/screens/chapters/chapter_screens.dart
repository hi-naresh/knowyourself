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
    controller.loadMaterialsFromJson(aspect);
    // controller.fetchMaterials(aspect);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KPageBar(
        title: KTexts.learningMaterialsTitle,
        onTap: () => Get.back(),
        action: Obx(() {
          return IconButton(
            icon: Icon(controller.isPlaying.value ? CupertinoIcons.pause_circle : Icons.play_circle_outlined),
            onPressed: () => controller.toggleAudio()
          );
        }),
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
                  tileColor: KHelper.isDark()? KColors.kEmptyProgressDark : KColors.kEmptyProgress,
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

}