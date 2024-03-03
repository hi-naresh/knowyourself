import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/widgets/AppButtons.dart';
import 'package:provider/provider.dart';

import '../../../models/Questions.dart';
import '../../../provider/MySpace/question_provider.dart';
import '../../../utils/ui_colors.dart';
import '../../widgets/CustomTitles.dart';

class QuestionSpace extends StatefulWidget {
  const QuestionSpace({super.key});

  @override
  State<QuestionSpace> createState() => _QuestionSpaceState();
}

class _QuestionSpaceState extends State<QuestionSpace> {
  final _questionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'short';

  void _addQuestion() {
    if (_questionController.text.isEmpty || _selectedDate == null) return;

    Provider.of<QuestionsProvider>(context, listen: false).addQuestion(
      Question(
        text: _questionController.text,
        deadline: _selectedDate,
        category: _selectedCategory,
      ),
    );
    _questionController.clear(); // Clear the text field after question is added
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void onPressed() {
    //modalSheet menu with daily, weekly, monthly, yearly

  }

  @override
  Widget build(BuildContext context) {
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
                          fontSize: 24.sp, fontWeight: FontWeight.w600)),
                  TextSpan(
                    text: 'Questions',
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: kApp4),
                  ),
                ],
              ),
            ),
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Enter your question'),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  _selectedDate != null
                      ? 'No Date Chosen!'
                      : 'Picked Date: ${_selectedDate.toLocal()}',
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilledButton(
                  onPressed: _presentDatePicker,
                  style: appButtonStyle(context),
                  child: Text(
                    'Choose Date',
                    style: customTitle(kWhite, 14.sp),
                  ),
                ),
                FilledButton(onPressed: onPressed,
                  style: appButtonStyle(context),
                  child: Text(
                    'Reminder',
                    style: customTitle(kWhite, 14.sp),
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
                  selected: _selectedCategory == 'short',
                  // labelPadding: EdgeInsets.all(5.0),
                  labelStyle: TextStyle(
                    color: kDarkText,
                  ),
                  side: BorderSide(
                    color: kApp4,
                    width: 1.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  // selectedColor: kApp4,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedCategory = 'short';
                      });
                    }
                  },
                ),
                SizedBox(width: 20),
                ChoiceChip(
                  label: Text('Long-term'),
                  selected: _selectedCategory == 'long',
                  labelStyle: TextStyle(
                    color: kDarkText,
                  ),
                  side: BorderSide(
                    color: kApp4,
                    width: 1.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedCategory = 'long';
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            FilledButton(
              style: appButtonStyle(context),
              child: Text('Add Question'),
              onPressed: _addQuestion,
            ),
            SizedBox(height: 20),
            Expanded(
              child: Consumer<QuestionsProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.questions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(value.questions[index].text),
                        subtitle: Text(
                          'Deadline: ${value.questions[index].deadline.toLocal()}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // value.deleteQuestion(value.questions[index]);
                          },
                        ),
                      );
                    },
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
