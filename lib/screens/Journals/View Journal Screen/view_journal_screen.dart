import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/widgets/button_container.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/widgets/mood_shift.dart';
import 'package:knowyourself/screens/widgets/CustomTitles.dart';
import 'package:knowyourself/screens/widgets/custom_header.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   color: Theme.of(context).scaffoldBackgroundColor,
            //   padding: const EdgeInsets.only(
            //       left: 20, right: 20, top: 10, bottom: 10),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       if (widget.readOnly)
            //         Align(
            //           alignment: Alignment.centerRight,
            //           child: IconButton(
            //             padding: EdgeInsets.zero,
            //             iconSize: 45.h,
            //             icon: const Icon(Icons.close),
            //             onPressed: () {
            //               Navigator.pop(context);
            //             },
            //           ),
            //         ),
            //       if (!widget.readOnly)
            //         Align(
            //           alignment: Alignment.centerLeft,
            //           child: IconButton(
            //             padding: EdgeInsets.zero,
            //             iconSize: 45.h,
            //             icon: const Icon(Icons.arrow_back),
            //             onPressed: () {
            //               Provider.of<JournalEditorProvider>(context,
            //                       listen: false)
            //                   .updateIndex(2);
            //             },
            //           ),
            //         ),
            //       Text.rich(
            //         TextSpan(
            //           children: [
            //             TextSpan(
            //                 text: 'Emotion ',
            //                 style: TextStyle(
            //                     fontSize: 28.sp,
            //                     fontWeight: FontWeight.w600)),
            //             TextSpan(
            //               text: 'Summary',
            //               style: TextStyle(
            //                   fontSize: 28.sp,
            //                   fontWeight: FontWeight.w600,
            //                   color: kPrimaryColor),
            //             ),
            //           ],
            //         ),
            //       ),
            //       // Text(
            //       //   DateFormat('EEEE').format(journalModel.createdOn),
            //       //   style: TextStyle(
            //       //       fontWeight: FontWeight.w600,
            //       //       fontSize: 28.sp,
            //       //       color: kPrimaryColor),
            //       // ),
            //       if (widget.readOnly)
            //         Text(
            //           DateFormat(
            //             'MMMM d, HH:mm',
            //           ).format(journalModel.createdOn),
            //           style: TextStyle(
            //               fontWeight: FontWeight.w400,
            //               fontSize: 14.sp,
            //               color: const Color(0xFFB2B2B7)),
            //         ),
            //       if (!widget.readOnly)
            //         Text(
            //           DateFormat(
            //             'EEEE, MMMM d',
            //           ).format(journalModel.createdOn),
            //           style: TextStyle(
            //               fontWeight: FontWeight.w400,
            //               fontSize: 14.sp,
            //               color: const Color(0xFFB2B2B7)),
            //         ),
            //     ],
            //   ),
            // ),
            CustomHeader(title: "Emotion"),
            if (!widget.readOnly)
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 0),
                child: Text(
                  "Mood",
                  style: customTitleBold(null, 16.sp, FontWeight.w700),
                ),
              ),
            GestureDetector(
              onTap: () {
                if (widget.readOnly == false) {
                  Provider.of<JournalEditorProvider>(context, listen: false)
                      .updateIndex(0);
                }
              },
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
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/emojis/${journalModel.mood}.svg",
                      height: 50.h,
                      width: 50.h,
                    ),
                  ),
                  SizedBox(
                    width: 0.w,
                  ),
                  Text(
                    journalModel.mood.toTitleCase(),
                    style: customTitleBold(null, 14.sp, FontWeight.w600),
                  ),
                ],
              ),
            ),
            if (!widget.readOnly)
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 0),
                child: Text(
                  "Aspect",
                  style: customTitleBold(null, 16.sp, FontWeight.w700),

                ),
              ),
            GestureDetector(
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
                  "Reasons",
                    style: customTitleBold(null, 16.sp, FontWeight.w700),

                ),
              ),
            Expanded(
              flex: 1,
              child: GestureDetector(
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
              ButtonContainer(
                  label: "Save",
                  onTap: () {
                    _saveJournal();
                  }),

            ButtonContainer(
                label: "Shift Mood",
                onTap: () {
                  _shiftMood();
                }),
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
