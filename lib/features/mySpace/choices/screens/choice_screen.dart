import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/common/widgets/appbar/appbar.dart';
import 'package:knowyourself/features/mySpace/choices/controller/choice_controller.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChoiceController());
    return Scaffold(
      appBar: const KAppBar(title: '${KTexts.user} ${KTexts.review}', back: true),
      body: Obx(() {
        final currentQuestion = controller.questionnaire[controller.pageIndex.value];
        // final answers = List<String>.filled(3, ''); // Create a list that can be modified
        // for (int i = 0; i < currentQuestion.answers.length && i < 3; i++) {
        //   answers[i] = currentQuestion.answers[i]!;
        // }

        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(KSizes.defaultSpace),
                children: [
                  Text(
                    KTexts.userReviewDescription,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: KSizes.spaceBtwItems),
                  // Text('Feature under development...', style: Theme.of(context).textTheme.bodyLarge),
                  Text(currentQuestion.questionText, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: KSizes.defaultSpace),
                  ...List.generate(3, (index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.textControllers[controller.pageIndex.value][index],
                            onChanged: (value) => controller.setAnswer(controller.pageIndex.value, index, value),
                            decoration: InputDecoration(
                              icon: Text('${index + 1}'),
                              hintText: KTexts.answerHintText,
                            ),
                          ),
                        ),

                        //if image is null pickImage else show image
                        if (controller.pageIndex.value == 0 && controller.pickedImages[index] == null)
                          IconButton(
                            icon: const Icon(CupertinoIcons.photo_on_rectangle),
                            onPressed: () => controller.pickImage(index),
                          ),
                        if (controller.pageIndex.value == 0 && controller.pickedImages[index] != null)
                          GestureDetector(
                            onTap: () => controller.removeImage(index),
                            child: Image.file(
                              File(controller.pickedImages[index]!.path),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),

                      ],
                    );
                  }).map((e) => Padding(padding: const EdgeInsets.only(bottom: KSizes.defaultSpace), child: e)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(KSizes.defaultSpace),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!controller.isFirstQuestion)
                    FilledButton(onPressed: controller.previousQuestion, child: const Text(KTexts.previous)),
                  if (!controller.isLastQuestion)
                    FilledButton(onPressed: controller.nextQuestion, child: const Text(KTexts.next)),
                  if (controller.isLastQuestion)
                    FilledButton(onPressed: controller.submitAnswers, child: const Text(KTexts.submit)),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

