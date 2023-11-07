import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/provider/journal/journal_provider.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JournalProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return TableCalendar(
          rowHeight: 90.h,
          headerVisible: false,
          calendarFormat: CalendarFormat.week,
          focusedDay: value.getDate,
          shouldFillViewport: false,
          firstDay: DateTime(2019, 06, 13),
          lastDay: DateTime(2025, 12, 31),
          selectedDayPredicate: (day) {
            return isSameDay(value.getDate, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            value.updateDate(selectedDay);
          },
          enabledDayPredicate: (day) {
            if (day.isAfter(DateTime.now())) {
              return false;
            }
            return true;
          },
          calendarBuilders: CalendarBuilders(
            outsideBuilder: (context, day, focusedDay) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kJournalWidgetCardLightColor,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat.d().format(day),
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          // SizedBox(
                          //   height: 5.h,
                          // ),
                          Text(
                            DateFormat.E().format(day),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              );
            },
            disabledBuilder: (context, day, focusedDay) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFE6E6EA),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat.d().format(day),
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFAEBACD),
                            ),
                          ),
                          // SizedBox(
                          //   height: 5.h,
                          // ),
                          Text(
                            DateFormat.E().format(day),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFFAEBACD),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              );
            },
            todayBuilder: (context, dateTimeNow, datetime) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF323945),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat.d().format(dateTimeNow),
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          // SizedBox(
                          //   height: 5.h,
                          // ),
                          Text(
                            DateFormat.E().format(dateTimeNow),
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              );
            },
            defaultBuilder: (context, dateTime, date) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(5),
                    // height: 70.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).chipTheme.backgroundColor,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat.d().format(dateTime),
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          // SizedBox(
                          //   height: 5.h,
                          // ),
                          Text(
                            DateFormat.E().format(dateTime),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              );
            },
            selectedBuilder: (context, day, focusedDay) {
              return Container(
                margin: const EdgeInsets.all(3),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kCalendarPrimaryColor,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat.d().format(day),
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      // SizedBox(
                      //   height: 5.h,
                      // ),
                      Text(
                        DateFormat.E().format(day),
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      const Expanded(child: SizedBox()),
                      Center(
                        child: Container(
                          height: 10.h,
                          width: 10.h,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              shape: BoxShape.circle),
                          child: Center(
                              child: Container(
                            height: 6.h,
                            width: 6.h,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),
              );
            },
            dowBuilder: (context, day) {
              return const Center(
                child: Text(
                  "",
                  style: TextStyle(fontSize: 0, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
