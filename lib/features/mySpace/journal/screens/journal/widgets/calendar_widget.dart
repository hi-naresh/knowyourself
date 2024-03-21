import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../common/styles/styles.dart';
import '../../../controller/journal_controller.dart';


class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  // Helper function to calculate the start of the week for a given date
  DateTime _startOfWeek(DateTime date) {
    // Adjust this if the start of the week is not Monday
    return date.subtract(Duration(days: date.weekday - 1));
  }

  @override
  Widget build(BuildContext context) {
    // Assuming JournalController is already initialized somewhere in your app
    final controller = Get.put(JournalController());
    // Directly use GetX's Obx widget to reactively rebuild parts of your widget tree
    return Obx(() {
      final DateTime startOfYearWeek = _startOfWeek(DateTime(2024, 1, 1));
      final DateTime startOfFocusedWeek = _startOfWeek(controller.getDate);
      final int weeksSinceStartOfYear = startOfFocusedWeek.difference(startOfYearWeek).inDays ~/ 7;
      final DateTime startOfListView = startOfYearWeek.add(Duration(days: weeksSinceStartOfYear * 7));
      final int totalDays = DateTime(2030, 12, 31).difference(DateTime(2024, 1, 1)).inDays;

      return SizedBox(
        height: 100,
        child: ListView.builder(
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
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 0);
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 12);
    double borderRadius = 30;
    Color borderColor = Colors.transparent;
    double borderWidth = 0;
    dateStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: kEmptyProgress);
    dayStyle = dateStyle.copyWith(fontSize: 10);

    if (isDisabled) {
      backgroundColor = kCalDisabled;
      // dateStyle = dateStyle;
      // dayStyle = dayStyle;
    } else if (isSelected) {
      backgroundColor = kSelectedDate;
      dateStyle = dateStyle.copyWith(color: kSelectedText);
      dayStyle = dateStyle.copyWith(fontSize: 10);
      borderColor = kCalDisabled.withOpacity(0.7);
      borderWidth=2;
    } else if (isToday) {
      backgroundColor = kSelectedDate ;
      dateStyle = dateStyle.copyWith(color: kSelectedText);
      dayStyle = dateStyle.copyWith(fontSize: 10);
    } else {
      backgroundColor = kCalDisabled;
      dateStyle = dateStyle.copyWith(color: kCalSelected);
      dayStyle = dateStyle.copyWith(fontSize: 10);
    }

    return InkWell(
      onTap: isDisabled
          ? null // If the day is disabled, do nothing.
          : () => onDaySelected(day), // If it's not disabled, call the onDaySelected function.
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
        padding: padding,
        width: 64,
        decoration: KStyles.containerDecoration(backgroundColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateFormat.E().format(day), style: dayStyle),
            SizedBox(height: 5),
            Text(DateFormat.d().format(day), style: dateStyle),
          ],
        ),
      ),
    );
  }

}