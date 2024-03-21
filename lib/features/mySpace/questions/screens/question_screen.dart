import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/mySpace/questions/controller/question_controller.dart';

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
            Text.rich(
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
            TextField(
              controller: controller.questionController,
              decoration: InputDecoration(labelText: 'Enter your question'),
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilledButton(
                  onPressed: (){},
                  child: Text(
                    'Choose Date',
                  ),
                ),
                FilledButton(
                  onPressed: (){},
                  child: Text(
                    'Reminder',
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text('Short-term'),
                  selected: controller.selectedCategory == 'short',
                  // labelPadding: EdgeInsets.all(5.0),
                  // labelStyle: TextStyle(
                  //   color: kDarkText,
                  // ),
                  side: BorderSide(
                    color: kApp4,
                    width: 1.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  selectedColor: kApp4,
                  onSelected: (selected) => controller.selectedCategory = 'short',
                ),
                SizedBox(width: 20),
                ChoiceChip(
                  label: Text('Long-term'),
                  selected: controller.selectedCategory == 'long',
                  // labelStyle: TextStyle(
                  //   color: kDarkText,
                  // ),
                  side: BorderSide(
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
            SizedBox(height: 20),
            FilledButton(
              child: Text('Add Question'),
              onPressed: () => controller.addQuestion(),
            ),
            SizedBox(height: 20),
            Expanded(
              child:ListView.builder(
                itemCount: controller.questions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.questions[index].text),
                    subtitle: Text(controller.questions[index].category),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
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
