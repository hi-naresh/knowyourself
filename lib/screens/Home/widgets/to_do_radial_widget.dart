import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/provider/ToDo/to_do_provider.dart';
import 'package:knowyourself/screens/Home/widgets/circular_painter.dart';

class TodoRadialWidget extends StatelessWidget {
  const TodoRadialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFFFCDA9),
        borderRadius: BorderRadius.all(Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(0.0, 4), //(x,y)
            blurRadius: 38.0,
          ),
        ],
      ),
      // margin: const EdgeInsets.all(20),
      padding: EdgeInsets.all(10.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset(
                  "assets/icons/checklist.png",
                  height: 60.h,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your daily tasks",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  Consumer<TodoProvider>(
                    builder: (BuildContext context, value, Widget? child) {
                      return Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: (value.toDolist.length -
                                        value.getUncompletedTasksCount())
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF323945))),
                            TextSpan(
                              text: '/${value.toDolist.length} task completed',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFC7AA95)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          Consumer<TodoProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return CustomPaint(
                painter: ToDoPainter(
                  completedTasks: (value.toDolist.length -
                      value.getUncompletedTasksCount()),
                  totalTasks: value.toDolist.length,
                  radius: 40.h,
                  strokeWidth: 10,
                ),
                child: SizedBox(
                  height: 80.h,
                  width: 80.h,
                  child: Center(
                    child: Text(
                      "${value.toDolist.isNotEmpty ? ((value.toDolist.length - value.getUncompletedTasksCount()) * 100 / value.toDolist.length).toStringAsFixed(1) : 0} %",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFFFF852D),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
