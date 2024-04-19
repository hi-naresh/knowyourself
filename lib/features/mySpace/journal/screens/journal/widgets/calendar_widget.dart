import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../common/styles/styles.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../controller/journal_controller.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = JournalController.instance;
    return Obx(
      ()=>Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: ()=> controller.updateDate(DateTime(controller.currentDate.value.year, controller.currentDate.value.month - 1)),
              ),
              Text(
                DateFormat.yMMM().format(controller.currentDate.value),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: ()=> controller.updateDate(DateTime(controller.currentDate.value.year, controller.currentDate.value.month + 1)),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              controller: ScrollController(initialScrollOffset:(controller.currentDate.value.day +3) * 70.0 ),
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemCount: DateTime(controller.currentDate.value.year, controller.currentDate.value.month + 1, 0).day,
              itemBuilder: (context, index) {
                DateTime day = DateTime(controller.currentDate.value.year, controller.currentDate.value.month, index + 1);
                final bool isSelected = isSameDay(controller.currentDate.value, day);
                final bool isToday = isSameDay(controller.currentDate.value, day);
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
          ),
        ],
      ),
    );
  }

  Widget buildDateContainer(BuildContext context, DateTime day,
      {bool isSelected = false, bool isDisabled = false, bool isToday = false, required Function(DateTime) onDaySelected}) {
    TextStyle dateStyle = Theme.of(context).textTheme.headlineSmall!;
    TextStyle dayStyle = dateStyle.copyWith(fontSize: 10);

    // Use GetX's Obx widget to listen for changes
    return Obx(() {
      final controller = JournalController.instance;
      bool isSelected = isSameDay(controller.currentDate.value, day);
      bool isToday = isSameDay(DateTime.now(), day);
      dateStyle = dateStyle.copyWith(color: isSelected || isToday ? Colors.white : Colors.black);
      dayStyle = dayStyle.copyWith(color: isSelected || isToday ? Colors.white : Colors.black);


      Color backgroundColor;
      if (isSelected) {
        backgroundColor = KColors.kApp4;
      } else if (isToday) {
        backgroundColor = KColors.kApp1;
      } else {
        backgroundColor = KHelper.isDarkMode(context) ? KColors.kEmptyProgressDark : KColors.kEmptyProgress;
        dayStyle = KHelper.isDarkMode(context) ? dayStyle.copyWith(color: Colors.grey) : dayStyle.copyWith(color: KColors.dark);
        dateStyle = KHelper.isDarkMode(context) ? dateStyle.copyWith(color: Colors.grey) : dateStyle.copyWith(color: KColors.dark);
      }

      return GestureDetector(
        onTap: () => onDaySelected(day),
        child: Container(
          clipBehavior: Clip.none,
          margin: const EdgeInsets.symmetric(horizontal: KSizes.sm,vertical: KSizes.xs),
          width: 70,
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
    });
  }

}