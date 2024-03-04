import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/widgets/progress_bar.dart';
import 'package:knowyourself/screens/widgets/CustomTitles.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/provider/journal/journal_editor_provider.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/widgets/button_container.dart';
import 'package:knowyourself/utils/linear_percent_indicator.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import 'package:knowyourself/utils/utils_functions.dart';
import 'package:animated_emoji/animated_emoji.dart';

import 'full_circle_slider.dart';

class MoodSelectWidget extends StatefulWidget {
  const MoodSelectWidget({super.key});

  @override
  State<MoodSelectWidget> createState() => _MoodSelectWidgetState();
}

class _MoodSelectWidgetState extends State<MoodSelectWidget> {
  double _sliderValue = 0;
  final List<AnimatedEmoji> _emojis = List.generate(10, (index) =>
      AnimatedEmoji(
        AnimatedEmojis.values[index],
        size: 40,
        repeat: true,
      )
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
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
            ProgressBar(progress: "1/3"),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'How Are You ',
                          style: customTitleBold(kDarkText, 28.sp, FontWeight.w700)),
                      TextSpan(
                        text: 'Feeling?',

                        style: customTitleBold(kApp1, 28.sp, FontWeight.w700),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Emotion: ${(_sliderValue * 10).round()}",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    FullCircleSlider(
                      value: _sliderValue,
                      onChanged: (newValue) {
                        setState(() {
                          _sliderValue = newValue;
                        });
                      },
                      emojis: _emojis,
                    ),
                    AnimatedEmoji(
                      AnimatedEmojis.values[(_sliderValue * 10).round()],
                      size: 256,
                      repeat: true,
                    ),
                  ],
                ),
              ],
            ),
            ButtonContainer(
                label: "Next",
                onTap: (){
                  Provider.of<JournalEditorProvider>(context, listen: false)
                      .updateIndex(1);
                }
            ),
          ],
        ),
      ),
    );
  }
}
