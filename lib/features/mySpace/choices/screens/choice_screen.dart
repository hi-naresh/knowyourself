import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/common/widgets/appbar/appbar.dart';
import 'package:knowyourself/features/mySpace/choices/controller/choice_controller.dart';
import '../../../../utils/constants/sizes.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChoiceController());
    return Scaffold(
      appBar: const KAppBar(title: 'User Review', back: true),
      body: Obx(() {
        final currentQuestion = controller.questionnaire[controller.pageIndex.value];
        final answers = List<String>.filled(3, ''); // Create a list that can be modified
        for (int i = 0; i < currentQuestion.answers.length && i < 3; i++) {
          answers[i] = currentQuestion.answers[i]!;
        }
        return ListView(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          children: [
            Text(currentQuestion.questionText, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: KSizes.defaultSpace),
            ...List.generate(3, (index) {
              return TextFormField(
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: answers[index],
                    selection: TextSelection.collapsed(offset: answers[index].length),
                  ),
                ),
                onChanged: (value) => controller.setAnswer(controller.pageIndex.value, index, value),
                decoration: InputDecoration(
                  labelText: 'Choice ${index + 1}',
                  hintText: 'Type your answer',
                ),
              );
            }).map((e) => Padding(padding: const EdgeInsets.only(bottom: KSizes.defaultSpace), child: e)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!controller.isFirstQuestion)
                  FilledButton(onPressed: controller.previousQuestion, child: const Text('Previous')),
                if (!controller.isLastQuestion)
                  FilledButton(onPressed: controller.nextQuestion, child: const Text('Next')),
                if (controller.isLastQuestion)
                  FilledButton(onPressed: controller.submitAnswers, child: const Text('Submit')),
              ],
            ),
          ],
        );
      }),
    );
  }
}

