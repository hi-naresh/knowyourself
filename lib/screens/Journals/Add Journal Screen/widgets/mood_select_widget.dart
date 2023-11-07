import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/provider/journal/journal_editor_provider.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/widgets/button_container.dart';
import 'package:knowyourself/utils/linear_percent_indicator.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import 'package:knowyourself/utils/utils_functions.dart';

class MoodSelectWidget extends StatelessWidget {
  const MoodSelectWidget({super.key});

  Widget _buildEmojiWidget({required String emoji}) {
    return Consumer<JournalEditorProvider>(
      builder: (context, mood, child) {
        return Expanded(
          child: GestureDetector(
            onTap: () {
              mood.changeMood(emoji);
            },
            child: AnimatedContainer(
              curve: Curves.linearToEaseOut,
              padding: EdgeInsets.zero,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: mood.mood == emoji
                    ? kPrimaryColor
                    : Theme.of(context).chipTheme.backgroundColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              duration: const Duration(milliseconds: 300),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/emojis/$emoji.svg",
                    height: 40.h,
                    width: 40.w,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    emoji.toTitleCase(),
                    style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w500,
                        color: mood.mood == emoji
                            ? Colors.white
                            : Theme.of(context).textTheme.bodySmall?.color),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        // padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Column(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(top: 10),
            //       child: Consumer<JournalEditorProvider>(
            //         builder: (BuildContext context, value, Widget? child) {
            //           return Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               GestureDetector(
            //                 onTap: () {
            //                   value.clearJournalData();
            //                   Navigator.pop(context);
            //                 },
            //                 child: Icon(
            //                   Icons.close,
            //                   size: 30.r,
            //                 ),
            //               ),
            //               JournalProgressIndicator(
            //                 value: 3,
            //                 width: 200.w,
            //                 height: 10.h,
            //                 currentVal: value.index + 1,
            //               ),
            //               Text(
            //                 "${value.index + 1}/3",
            //                 style: TextStyle(
            //                     fontSize: 14.sp, fontWeight: FontWeight.w600),
            //               ),
            //             ],
            //           );
            //         },
            //       ),
            //     ),
            //   ],
            // ),
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
                              .clearJournalData();
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          size: 30.r,
                        ),
                      ),
                      barRadius: const Radius.circular(20),
                      lineHeight: 10.h,
                      width: 200.w,
                      percent: 0.3,
                      backgroundColor: const Color(0xFFD9D9D9),
                      progressColor: const Color(0xFF5349DB),
                      trailing: Text(
                        "1/3",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w600),
                      ),
                    );
                  },
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'How Are You ',
                          style: TextStyle(
                              fontSize: 30.sp, fontWeight: FontWeight.w600)),
                      TextSpan(
                        text: 'Feeling ',
                        style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor),
                      ),
                      TextSpan(
                        text: 'Right Now?',
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 90.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildEmojiWidget(emoji: 'amazed'),
                      _buildEmojiWidget(emoji: 'angry'),
                      _buildEmojiWidget(emoji: 'confused'),
                      _buildEmojiWidget(emoji: 'crying'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 90.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildEmojiWidget(emoji: 'happy'),
                      _buildEmojiWidget(emoji: 'party'),
                      _buildEmojiWidget(emoji: 'rich'),
                      _buildEmojiWidget(emoji: 'joyfull'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 90.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildEmojiWidget(emoji: 'loving'),
                      _buildEmojiWidget(emoji: 'impassive'),
                      _buildEmojiWidget(emoji: 'fear'),
                      _buildEmojiWidget(emoji: 'relieved'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 90.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildEmojiWidget(emoji: 'blessed'),
                      _buildEmojiWidget(emoji: 'sad'),
                      _buildEmojiWidget(emoji: 'sick'),
                      _buildEmojiWidget(emoji: 'blush'),
                    ],
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Provider.of<JournalEditorProvider>(context, listen: false)
                    .updateIndex(1);
              },
              child: const ButtonContainer(label: "Next"),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }
}
