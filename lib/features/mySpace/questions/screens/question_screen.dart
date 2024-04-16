import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../controller/question_controller.dart';
import '../../../../utils/constants/enums.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuestionController());

    return Column(
      children: [
        _buildAddQuestionSection(context, controller),
        Expanded(child: _buildQuestionList(controller)),
      ],
    );
  }

  Widget _buildAddQuestionSection(context, QuestionController controller) {
    return Padding(
      padding: const EdgeInsets.all(KSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: '${KTexts.my} ',
                    style: Theme.of(context).textTheme.headlineMedium),
                TextSpan(
                  text: KTexts.questions,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: kApp4,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: KSizes.spaceBtwItems),
          TextFormField(
            controller: controller.questionController,
            decoration: InputDecoration(
              labelText: KTexts.addLifeChallengingQuestion,
              labelStyle: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          const SizedBox(height: KSizes.defaultSpace),
          Text( KTexts.setReminderPeriod,
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: KSizes.sm),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(() => Wrap(
                  spacing: 8,
                  children: Period.values
                      .map((period) => ChoiceChip(
                            backgroundColor: KHelper.isDark()
                                ? kEmptyProgressDark
                                : kEmptyProgress,
                            selectedColor: kApp4,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: kApp4,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(10),
                            disabledColor: kEmptyProgress,
                            label: Text(period.name.capitalizeFirst!),
                            selected: controller.reminderPeriod.value == period,
                            onSelected: (selected) {
                              if (selected) {
                                controller.reminderPeriod.value = period;
                              }
                            },
                          ))
                      .toList(),
                )),
          ),
          const SizedBox(height: KSizes.md),
          TextButton(
              style: const ButtonStyle().copyWith(
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50)),
                  backgroundColor: MaterialStateProperty.all(kApp4),
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: controller.addQuestion,
              child: Text(
                '${KTexts.add} ${KTexts.questions2}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }

  Widget _buildQuestionList(QuestionController controller) {
    return Obx(() => ListView.builder(
          padding: const EdgeInsets.all(KSizes.md),
          itemCount: controller.questions.length,
          itemBuilder: (context, index) {
            final question = controller.questions[index];
            return ListTile(
              splashColor: Colors.transparent,
              title: Text(question.title),
              subtitle: Text('${KTexts.answer}: ${question.answer.capitalizeFirst}'),
              trailing: question.isAnswered
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(CupertinoIcons.checkmark_alt_circle_fill,
                            color: kApp3),
                        IconButton(
                          icon: const Icon(CupertinoIcons.minus_circle_fill,
                              color: kApp4),
                          onPressed: () =>
                              controller.deleteQuestion(question.id),
                        ),
                      ],
                    )
                  : IconButton(
                      icon: const Icon(CupertinoIcons.question_circle_fill,
                          color: kApp4),
                      onPressed: () => _displayAnswerDialog(
                          context, controller, question.id),
                    ),
              onTap: () {},
            );
          },
        ));
  }

  void _displayAnswerDialog(
      BuildContext context, QuestionController controller, String questionId) {
    final answerController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text( KTexts.answerTheQuestion ),
            content: TextFormField(
              controller: answerController,
              decoration: const InputDecoration(hintText: '${KTexts.your} ${KTexts.answer}'),
            ),
            actions: [
              TextButton(
                  style: const ButtonStyle().copyWith(
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 50)),
                      backgroundColor: MaterialStateProperty.all(kApp4),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    controller.addAnswer(questionId, answerController.text);
                  },
                  child: Text(
                    '${KTexts.add} ${KTexts.answer}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ))
            ],
          );
        });
  }
}
