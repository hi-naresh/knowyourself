import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/widgets/Placeholder.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/models/journals/journal_model.dart';
import 'package:knowyourself/provider/journal/journal_editor_provider.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/widgets/button_container.dart';
import 'package:knowyourself/utils/linear_percent_indicator.dart';
import 'package:knowyourself/utils/ui_colors.dart';

class ExpressFeelingsWidget extends StatelessWidget {
  const ExpressFeelingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    JournalEditorProvider journalEditorProvider =
    Provider.of<JournalEditorProvider>(context, listen: false);
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Consumer<JournalEditorProvider>(
                          builder: (context, value, child) {
                            return LinearPercentIndicator(
                              alignment: MainAxisAlignment.spaceBetween,
                              leading: GestureDetector(
                                onTap: () {
                                  Provider.of<JournalEditorProvider>(context,
                                      listen: false)
                                      .updateIndex(1);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 30.r,
                                ),
                              ),
                              barRadius: const Radius.circular(20),
                              lineHeight: 10.h,
                              width: 200.w,
                              percent: 1,
                              backgroundColor: const Color(0xFFD9D9D9),
                              progressColor: const Color(0xFF5349DB),
                              trailing: Text(
                                "3/3",
                                style: TextStyle(
                                    fontSize: 14.sp, fontWeight: FontWeight.w600),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Write down reasons for your',
                                style: TextStyle(
                                    fontSize: 30.sp, fontWeight: FontWeight.w600)),
                            TextSpan(
                              text: ' Feelings ',
                              style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor),
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
                          CustomPlaceHolder("Social", 30, 90),
                          CustomPlaceHolder("Work", 30, 90),
                          CustomPlaceHolder("Home", 30, 90),
                          CustomPlaceHolder("Personal", 30, 120),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 350.h,
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Semantics(
                        label: 'Enter journal desciption',
                        hint: 'Press to enter journal description',
                        child: TextField(
                          controller: journalEditorProvider.notesEditingController,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          textAlignVertical: TextAlignVertical.top,
                          expands: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            fillColor: Theme.of(context).chipTheme.backgroundColor,
                            filled: true,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
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
                InkWell(
                  onTap: () {
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
                  },
                  child: const ButtonContainer(label: "Save"),
                ),
              ],
            ),
          ),
        ));
  }
}
