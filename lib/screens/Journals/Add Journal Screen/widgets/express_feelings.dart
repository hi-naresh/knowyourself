import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/widgets/progress_bar.dart';
import 'package:knowyourself/screens/widgets/CustomTitles.dart';
import 'package:knowyourself/screens/widgets/Placeholder.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/models/journals/journal_model.dart';
import 'package:knowyourself/provider/journal/journal_editor_provider.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/widgets/button_container.dart';
import 'package:knowyourself/utils/linear_percent_indicator.dart';
import 'package:knowyourself/utils/ui_colors.dart';

class ExpressFeelingsWidget extends StatefulWidget {
  const ExpressFeelingsWidget({super.key});

  @override
  State<ExpressFeelingsWidget> createState() => _ExpressFeelingsWidgetState();
}

class _ExpressFeelingsWidgetState extends State<ExpressFeelingsWidget> {
  int _selectedOptionIndex = 0; // Index of the selected option

  List<String> options = ['Social', 'Work', 'Home', 'Personal'];

  @override
  Widget build(BuildContext context) {
    JournalEditorProvider journalEditorProvider =
    Provider.of<JournalEditorProvider>(context, listen: false);
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.93,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const ProgressBar(steps: "3/3", percent: 1,),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Write down reasons for your',
                                style: customTitleBold(kDarkText, 26.sp, FontWeight.w700)),
                            TextSpan(
                              text: ' Feelings ',
                              style: customTitleBold(kApp1, 26.sp, FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          optionsPlace(context, options)
                          // CustomPlaceHolder("Social", 30, 90),
                          // CustomPlaceHolder("Work", 30, 90),
                          // CustomPlaceHolder("Home", 30, 90),
                          // CustomPlaceHolder("Personal", 30, 120),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 300.h,
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Semantics(
                        label: 'Enter journal desciption',
                        hint: 'Press to enter journal description',
                        child: TextField(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          controller: journalEditorProvider.notesEditingController,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          textAlignVertical: TextAlignVertical.top,
                          expands: true,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            // fillColor: Theme.of(context).chipTheme.backgroundColor,
                            fillColor: kBoxLight,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Express Your Feelings",
                          ),
                          maxLines: null,
                        ),
                      ),
                    ),
                  ],
                ),
                ButtonContainer(
                  label: "Save",
                onTap: (){
                  if (journalEditorProvider.notesEditingController.text == "") {
                    return;
                  }
                  JournalModel journalModel = JournalModel(
                      journalId: (Random.secure().nextInt(90000) + 10000),
                      createdOn: DateTime.now(),
                      mood: Provider.of<JournalEditorProvider>(context,
                          listen: false)
                          .mood,
                      title: journalEditorProvider.titleEditingController.text,
                      color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0),
                      description:
                      journalEditorProvider.notesEditingController.text,
                      id: '');
                  journalEditorProvider.updateJournal(journalModel);
                  journalEditorProvider.updateIndex(3);
                  FocusScope.of(context).unfocus();
                },),
              ],
            ),
          ),
        ));
  }

  Widget optionsPlace(BuildContext context, List<String> options) {
    return Row(
      children: List.generate(options.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedOptionIndex = index;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: _selectedOptionIndex == index ? kApp1 : Colors.grey[200],
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                color: _selectedOptionIndex == index ? kApp1: Colors.transparent,
                width: 2,
              ),
              boxShadow: [
                if (_selectedOptionIndex == index)
                  BoxShadow(
                    color: kApp1.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  options[index],
                  style: TextStyle(
                    color: _selectedOptionIndex == index ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
                if (_selectedOptionIndex == index)
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }

}
