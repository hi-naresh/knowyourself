import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/mySpace/questions/controller/question_controller.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';
class QuestionSpace extends StatelessWidget {
  const QuestionSpace({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuestionController());
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: 'My ',
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w600)),
                  TextSpan(
                    text: 'Questions',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: kApp4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: KSizes.defaultSpace),
            TextField(
              controller: controller.questionController,
              decoration: const InputDecoration(labelText: 'Enter your question'),
            ),
            const SizedBox(height: KSizes.defaultSpace),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  controller.selectedDate != null
                      ? 'No Date Chosen!'
                      : 'Picked Date: ${controller.selectedDate.toLocal()}',
                )
              ],
            ),
            const SizedBox(height: KSizes.defaultSpace),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => controller.pickDate(),
                  child: const Text('Choose Date'),
                ),
                ElevatedButton(
                  onPressed: () => controller.pickReminder(),
                  child: const Text('Reminder'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChoiceChip(
                  label: const Text('Short-term'),
                  selected: controller.selectedCategory == 'short',
                  side: const BorderSide(
                    color: kApp4,
                    width: 1.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  selectedColor: kApp4,
                  onSelected: (selected) => controller.selectedCategory = 'short',
                ),
                ChoiceChip(
                  label: const Text('Long-term'),
                  selected: controller.selectedCategory == 'long',
                  // labelStyle: TextStyle(
                  //   color: kDarkText,
                  // ),
                  side: const BorderSide(
                    color: kApp4,
                    width: 1.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  onSelected: (selected) => controller.selectedCategory = 'long',
                ),
              ],
            ),
            const SizedBox(height: KSizes.defaultSpace),
            ElevatedButton(
              onPressed: () => controller.addQuestion(),
              child: const Text('Add Question'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child:ListView.builder(
                itemCount: controller.questions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.questions[index].text),
                    subtitle: Text(controller.questions[index].category),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => controller.deleteQuestion(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
