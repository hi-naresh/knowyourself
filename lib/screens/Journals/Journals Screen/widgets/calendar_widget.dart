import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/provider/journal/journal_provider.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../widgets/global_styles.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  // Helper function to calculate the start of the week for a given date
  DateTime _startOfWeek(DateTime date) {
    // Adjust this if the start of the week is not Monday
    return date.subtract(Duration(days: date.weekday - 1));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JournalProvider>(
      builder: (context, value, child) {
        // Find the start of the week for the first day of the year 2024
        final DateTime startOfYearWeek = _startOfWeek(DateTime(2024, 1, 1));
        // Find the start of the current week based on the focused day
        final DateTime startOfFocusedWeek = _startOfWeek(value.getDate);
        // Calculate the difference in weeks between the start of the year and the focused week
        final int weeksSinceStartOfYear = startOfFocusedWeek.difference(startOfYearWeek).inDays ~/ 7;
        // Calculate the start date for the ListView to display based on the current week
        final DateTime startOfListView = startOfYearWeek.add(Duration(days: weeksSinceStartOfYear * 7));

        // Make sure the provider has today's date as the initial date
        final int totalDays = DateTime(2030, 12, 31).difference(DateTime(2024, 1, 1)).inDays;

        return SizedBox(
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: totalDays,
            itemBuilder: (context, index) {
               DateTime focusDay = DateTime.now();
              focusDay = startOfListView.add(Duration(days: index));

              final DateTime day = DateTime(2024, 1, 1).add(Duration(days: index));
              // final focusDay = value.getDate;

              final bool isSelected = isSameDay(value.getDate, focusDay);
              final bool isToday = isSameDay(DateTime.now(), day);
              final bool isDisabled = day.isAfter(DateTime.now());

              return buildDateContainer(
                context,
                day,
                isSelected: isSelected,
                isToday: isToday,
                isDisabled: isDisabled,
                onDaySelected: (selectedDay) {
                  value.updateDate(selectedDay);
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget buildDateContainer1(BuildContext context, DateTime day, {bool isSelected = false, bool isDisabled = false, bool isToday = false}) {
    Color backgroundColor;
    TextStyle dateStyle, dayStyle;
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 5);
    EdgeInsets padding = const EdgeInsets.symmetric( horizontal: 12);
    double borderRadius = 30;
    Color borderColor = Colors.transparent;
    double borderWidth = 0;
    dateStyle = TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: kPalette5);
    dayStyle = dateStyle.copyWith(fontSize: 10.sp);

    if (isDisabled) {
      backgroundColor = kPalette6_1;
      // dateStyle = dateStyle;
      // dayStyle = dayStyle;
    } else if (isSelected) {
      backgroundColor = kPalette5;
      dateStyle = dateStyle.copyWith(color: kPalette6);
      dayStyle = dateStyle.copyWith(fontSize: 10.sp);
      borderColor = kPalette6_1.withOpacity(0.7);
      borderWidth=2;
    } else if (isToday) {
      backgroundColor = kPalette6_2 ;
      dateStyle = dateStyle.copyWith(color: kPalette6);
      dayStyle = dateStyle.copyWith(fontSize: 10.sp);
    } else {
      backgroundColor = kPalette6_1;
      dateStyle = dateStyle.copyWith(color: kPalette5);
      dayStyle = dateStyle.copyWith(fontSize: 10.sp);
    }

    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        color: backgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(DateFormat.E().format(day), style: dayStyle),
          SizedBox(height: 5.h),
          Text(DateFormat.d().format(day), style: dateStyle),
        ],
      ),
    );
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
    dateStyle = TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: kPalette5);
    dayStyle = dateStyle.copyWith(fontSize: 10.sp);

    if (isDisabled) {
      backgroundColor = kPalette6_1;
      // dateStyle = dateStyle;
      // dayStyle = dayStyle;
    } else if (isSelected) {
      backgroundColor = kSelectedDate;
      dateStyle = dateStyle.copyWith(color: kPalette6);
      dayStyle = dateStyle.copyWith(fontSize: 10.sp);
      borderColor = kPalette6_1.withOpacity(0.7);
      borderWidth=2;
    } else if (isToday) {
      backgroundColor = kPalette5 ;
      dateStyle = dateStyle.copyWith(color: kPalette6);
      dayStyle = dateStyle.copyWith(fontSize: 10.sp);
    } else {
      backgroundColor = kPalette6_1;
      dateStyle = dateStyle.copyWith(color: kPalette5);
      dayStyle = dateStyle.copyWith(fontSize: 10.sp);
    }

    return InkWell(
      onTap: isDisabled
          ? null // If the day is disabled, do nothing.
          : () => onDaySelected(day), // If it's not disabled, call the onDaySelected function.
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 10.h),
        padding: padding,
        width: 64.w,
        decoration: Styles.containerDecoration(backgroundColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateFormat.E().format(day), style: dayStyle),
            SizedBox(height: 5.h),
            Text(DateFormat.d().format(day), style: dateStyle),
          ],
        ),
      ),
    );
  }

}