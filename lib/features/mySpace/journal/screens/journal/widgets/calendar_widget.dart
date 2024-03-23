import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../common/styles/styles.dart';
import '../../../controller/journal_controller.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime startOfWeek(DateTime date) {
      return date.subtract(Duration(days: date.weekday - 1));
    }
    final controller = Get.put(JournalController());
    return Obx(() {
      final DateTime startOfYearWeek = startOfWeek(DateTime(2024, 1, 1));
      final DateTime startOfFocusedWeek = startOfWeek(controller.getDate);
      final int weeksSinceStartOfYear = startOfFocusedWeek.difference(startOfYearWeek).inDays ~/ 7;
      final DateTime startOfListView = startOfYearWeek.add(Duration(days: weeksSinceStartOfYear * 7));
      final int totalDays = DateTime(2030, 12, 31).difference(DateTime(2024, 1, 1)).inDays;

      return SizedBox(
        height: 100,
        child: ListView.builder(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          itemCount: totalDays,
          itemBuilder: (context, index) {
            DateTime focusDay = startOfListView.add(Duration(days: index));
            final DateTime day = DateTime(2024, 1, 1).add(Duration(days: index));
            final bool isSelected = isSameDay(controller.getDate, focusDay);
            final bool isToday = isSameDay(DateTime.now(), day);
            final bool isDisabled = day.isAfter(DateTime.now());
            return buildDateContainer(
              context,
              day,
              isSelected: isSelected,
              isToday: isToday,
              isDisabled: isDisabled,
              onDaySelected: (selectedDay) {
                controller.updateDate(selectedDay);
              },
            );
          },
        ),
      );
    });
  }

  Widget buildDateContainer(BuildContext context, DateTime day,
      {bool isSelected = false, bool isDisabled = false, bool isToday = false, required Function(DateTime) onDaySelected}) {
    Color backgroundColor;
    TextStyle dateStyle, dayStyle;
    dateStyle = Theme.of(context).textTheme.headlineSmall!;
    dayStyle = dateStyle.copyWith(fontSize: 10);

    if (isDisabled) {
      backgroundColor = kEmptyProgress;
      // dateStyle = dateStyle;
      // dayStyle = dayStyle;
    } else if (isSelected) {
      backgroundColor = kApp4;
      dateStyle = dateStyle.copyWith(color: kSelectedText);
      dayStyle = dateStyle.copyWith(fontSize: 10);
    } else if (isToday) {
      backgroundColor = kApp4 ;
      dateStyle = dateStyle.copyWith(color: kSelectedText);
      dayStyle = dateStyle.copyWith(fontSize: 10);
    } else {
      backgroundColor = kEmptyProgress;
      dateStyle = dateStyle.copyWith(color: kDisText);
      dayStyle = dateStyle.copyWith(fontSize: 10);
    }

    return InkWell(
      splashColor: Colors.transparent,
      onTap: isDisabled
          ? null // If the day is disabled, do nothing.
          : () => onDaySelected(day), // If it's not disabled, call the onDaySelected function.
      child: Container(
        clipBehavior: Clip.none,
        margin: const EdgeInsets.symmetric(horizontal: KSizes.sm,vertical: KSizes.xs),
        width: 68,
        decoration: KStyles.containerDecoration(backgroundColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateFormat.E().format(day), style: dayStyle),
            const SizedBox(height: 5),
            Text(DateFormat.d().format(day), style: dateStyle),
          ],
        ),
      ),
    );
  }

}