import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/widgets/mood_shift.dart';
import 'package:provider/provider.dart';

import 'package:knowyourself/models/journals/journal_model.dart';
import 'package:knowyourself/provider/User/points_provider.dart';
import 'package:knowyourself/provider/journal/journal_editor_provider.dart';
import 'package:knowyourself/provider/journal/journal_provider.dart';
import 'package:knowyourself/utils/constants.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import 'package:knowyourself/utils/utils_functions.dart';

class ViewJournalScreen extends StatefulWidget {
  final bool readOnly;
  final JournalModel? journalModel;
  const ViewJournalScreen(
      {super.key, required this.readOnly, this.journalModel});

  @override
  State<ViewJournalScreen> createState() => _ViewJournalScreenState();
}

class _ViewJournalScreenState extends State<ViewJournalScreen> {
  late JournalModel journalModel;

  @override
  void initState() {
    super.initState();
    if (widget.journalModel == null) {
      journalModel =
          Provider.of<JournalEditorProvider>(context, listen: false).journal!;
    } else {
      journalModel = widget.journalModel!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.readOnly)
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 45.h,
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  if (!widget.readOnly)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 45.h,
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Provider.of<JournalEditorProvider>(context,
                                  listen: false)
                              .updateIndex(2);
                        },
                      ),
                    ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Emotion ',
                            style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w600)),
                        TextSpan(
                          text: 'Summary',
                          style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor),
                        ),
                      ],
                    ),
                  ),
                  // Text(
                  //   DateFormat('EEEE').format(journalModel.createdOn),
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.w600,
                  //       fontSize: 28.sp,
                  //       color: kPrimaryColor),
                  // ),
                  if (widget.readOnly)
                    Text(
                      DateFormat(
                        'MMMM d, HH:mm',
                      ).format(journalModel.createdOn),
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: const Color(0xFFB2B2B7)),
                    ),
                  if (!widget.readOnly)
                    Text(
                      DateFormat(
                        'EEEE, MMMM d',
                      ).format(journalModel.createdOn),
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: const Color(0xFFB2B2B7)),
                    ),
                ],
              ),
            ),
            if (!widget.readOnly)
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 0),
                child: Text(
                  "Mood",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
              ),
            InkWell(
              onTap: () {
                if (widget.readOnly == false) {
                  Provider.of<JournalEditorProvider>(context, listen: false)
                      .updateIndex(0);
                }
              },
              child: Container(
                height: 70.h,
                width: 200.w,
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).chipTheme.backgroundColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: SvgPicture.asset(
                        "assets/emojis/${journalModel.mood}.svg",
                        height: 50.h,
                        width: 50.h,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      journalModel.mood.toTitleCase(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (!widget.readOnly)
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 0),
                child: Text(
                  "Aspect",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
              ),
            InkWell(
              onTap: () {
                if (widget.readOnly == false) {
                  Provider.of<JournalEditorProvider>(context, listen: false)
                      .updateIndex(1);
                }
              },
              child: Container(
                width: double.infinity,
                height: 60.h,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).chipTheme.backgroundColor,
                ),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      journalModel.title,
                    )),
              ),
            ),
            if (!widget.readOnly)
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 0),
                child: Text(
                  "Reasons for your feelings",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
              ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  if (widget.readOnly == false) {
                    Provider.of<JournalEditorProvider>(context, listen: false)
                        .updateIndex(2);
                  }
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).chipTheme.backgroundColor),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        journalModel.description,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (!widget.readOnly)
              GestureDetector(
                onTap: () {
                  _saveJournal();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7E5FD),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            GestureDetector(
              onTap: () {
                _shiftMood();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE7E5FD),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Text(
                    "Shift Mood",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveJournal() {
    Provider.of<JournalEditorProvider>(context, listen: false).updateIndex(0);
    Provider.of<JournalProvider>(context, listen: false)
        .updateJournalList(journalModel);
    Provider.of<PointsProvider>(context, listen: false)
        .setScore(point: kAddJournalPoint);
    Provider.of<JournalEditorProvider>(context, listen: false)
        .clearJournalData();
    Navigator.pop(context);
  }

  void _shiftMood(){
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => MoodShift()));
  }
}
