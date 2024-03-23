
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:knowyourself/common/widgets/appbar/appbar.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../controller/add_mood_controller.dart';
import '../../../model/mood_model_old.dart';
import 'package:get/get.dart';

import 'mood_shift.dart';
class MoodSummary extends StatefulWidget {
  final bool readOnly;
  final MoodModel? moodModel;
  const MoodSummary(
      {super.key, required this.readOnly, this.moodModel});

  @override
  State<MoodSummary> createState() => _MoodSummaryState();
}

class _MoodSummaryState extends State<MoodSummary> {
  // late MoodModel moodModel;

  @override
  void initState() {
    super.initState();
    // if (widget.moodModel == null) {
    //   moodModel =
    //       Provider.of<JournalEditorProvider>(context, listen: false).journal!;
    // } else {
    //   moodModel = widget.moodModel!;
    // }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddMoodController());
    return Scaffold(
      appBar: const KAppBar(back: true,),
      body: Padding(
        padding: const EdgeInsets.all(KSizes.defaultSpace),
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
            //       //   DateFormat('EEEE').format(moodModel.createdOn),
            //       //   style: TextStyle(
            //       //       fontWeight: FontWeight.w600,
            //       //       fontSize: 28.sp,
            //       //       color: kPrimaryColor),
            //       // ),
            //       if (widget.readOnly)
            //         Text(
            //           DateFormat(
            //             'MMMM d, HH:mm',
            //           ).format(moodModel.createdOn),
            //           style: TextStyle(
            //               fontWeight: FontWeight.w400,
            //               fontSize: 14.sp,
            //               color: const Color(0xFFB2B2B7)),
            //         ),
            //       if (!widget.readOnly)
            //         Text(
            //           DateFormat(
            //             'EEEE, MMMM d',
            //           ).format(moodModel.createdOn),
            //           style: TextStyle(
            //               fontWeight: FontWeight.w400,
            //               fontSize: 14.sp,
            //               color: const Color(0xFFB2B2B7)),
            //         ),
            //     ],
            //   ),
            // ),
            if (!widget.readOnly)
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 0),
                child: Text(
                  "Mood",
                  style:Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            const SizedBox(
              height: KSizes.defaultSpace,
            ),
            GestureDetector(
              onTap: () {
                // if (widget.readOnly == false) {
                //   Provider.of<JournalEditorProvider>(context, listen: false)
                //       .updateIndex(0);
                // }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/emojis/happy.svg",
                      height: 50,
                      width: 50,
                    ),
                  ),
                  Text(
                    controller.mood.value,
                    style: Theme.of(context).textTheme.titleSmall,
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
                  style: Theme.of(context).textTheme.headlineMedium,

                ),
              ),
            const SizedBox(
              height: KSizes.sm,
            ),
            GestureDetector(
              onTap: () {
                // if (widget.readOnly == false) {
                //   Provider.of<JournalEditorProvider>(context, listen: false)
                //       .updateIndex(1);
                // }
              },
              child: Container(
                width: double.infinity,
                height: 60,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: kEmptyProgress,
                ),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      controller.aspect.value,
                    )),
              ),
            ),
            const SizedBox(
              height: KSizes.defaultSpace,
            ),
            if (!widget.readOnly)
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 0),
                child: Text(
                  "Reasons",
                    style: Theme.of(context).textTheme.headlineMedium,

                ),
              ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  // if (widget.readOnly == false) {
                  //   Provider.of<JournalEditorProvider>(context, listen: false)
                  //       .updateIndex(2);
                  // }
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20)),
                      color: kEmptyProgress),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        controller.aspect.value,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (!widget.readOnly)
              ElevatedButton(
                  onPressed: () {
                    _saveJournal();
                  },
                  child: Text("Save")
              ),
            ElevatedButton(
                onPressed: () {
                  _shiftMood();
                },
                child: Text("Shift Mood")
            ),
          ],
        ),
      ),
    );
  }

  void _saveJournal() {
    // Provider.of<JournalEditorProvider>(context, listen: false).updateIndex(0);
    // Provider.of<JournalProvider>(context, listen: false)
    //     .updateJournalList(moodModel);
    // Provider.of<PointsProvider>(context, listen: false)
    //     .setScore(point: kAddJournalPoint);
    // Provider.of<JournalEditorProvider>(context, listen: false)
    //     .clearJournalData();
    // Navigator.pop(context);
  }

  void _shiftMood(){
    // Navigator.push(context,
    // MaterialPageRoute(builder: (context) => MoodShift()));
    Get.to(()=>MoodShift()  );
  }
}
