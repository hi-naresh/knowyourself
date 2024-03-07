import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../provider/journal/journal_editor_provider.dart';
import '../../../../utils/linear_percent_indicator.dart';
import '../../../../utils/ui_colors.dart';
import '../../../widgets/CustomTitles.dart';

class ProgressBar extends StatefulWidget {
  final String steps;
  final double percent;

  const ProgressBar({
    super.key,
    required this.steps, required this.percent});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {

  @override
  Widget build(BuildContext context) {
    int currentIndex() => Provider.of<JournalEditorProvider>(context, listen: false).index;
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: LinearPercentIndicator(
        alignment: MainAxisAlignment.spaceBetween,
        leading: GestureDetector(
          onTap: () {
            if (currentIndex() == 0) {
              Navigator.pop(context);
            }else{
              Provider.of<JournalEditorProvider>(context, listen: false)
                  .updateIndex(currentIndex() - 1);
            }
            // Provider.of<JournalEditorProvider>(context, listen: false)
            //     .updateIndex(currentIndex() - 1);
            // Provider.of<JournalEditorProvider>(context, listen: false)
            //     .updateIndex(0);
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 25.r,
          ),
        ),
        barRadius: const Radius.circular(20),
        lineHeight: 10.h,
        width: 200.w,
        percent: widget.percent,
        backgroundColor: kBoxLight,
        progressColor: kApp1,
        trailing: Text(
          widget.steps,
          style: customTitleBold(kDarkText, 14.sp, FontWeight.w700),
        ),
      ),
    );
  }
}
