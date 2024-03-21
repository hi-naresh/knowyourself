import 'package:flutter/material.dart';
import 'package:animated_emoji/animated_emoji.dart';
import 'package:knowyourself/features/mySpace/mood/screens/add_mood/widgets/progress_bar.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../../../controller/add_mood_controller.dart';
import 'full_circle_slider.dart';
import 'package:get/get.dart';

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
    final controller = Get.put(AddMoodController());
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
            const ProgressBar(percent:0.3,steps: "1/3"),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "How Are You Feeling?",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(
                  height: KSizes.defaultSpace,
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
                  height: KSizes.defaultSpace,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    FullCircleSlider(
                      value: _sliderValue,
                      onChanged: (newValue) {
                        setState(() {
                          _sliderValue = newValue;
                          //print string of the emoji
                        });
                      },
                      emojis: _emojis,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.5),
                            blurRadius: 20,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: AnimatedEmoji(
                        AnimatedEmojis.values[(_sliderValue * 10).round()],
                        size: 216,
                        repeat: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: ()=> controller.pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              ),
                child: Text("Next")
            ),
          ],
        ),
      ),
    );
  }
}
