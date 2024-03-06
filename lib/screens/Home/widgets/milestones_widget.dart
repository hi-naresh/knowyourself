import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:knowyourself/screens/Space/space_screen.dart';
import 'package:knowyourself/screens/widgets/CustomContaincer.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/provider/ToDo/to_do_provider.dart';
import 'package:knowyourself/screens/Home/widgets/circular_painter.dart';
import '../../widgets/CustomTitles.dart';

class TodoRadialWidget extends StatelessWidget {
  const TodoRadialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: double.infinity,
      color: kNewP2_1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            children: [
              Opacity(
                opacity: 0.7,
                child: SvgPicture.asset(
                  "assets/illustrations/milestones.svg",
                  width: 120.h,
                  height: 120.h,
                  fit: BoxFit.contain,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Daily milestones",
                    style: customTitleBold(kPalette5, 20.sp, FontWeight.w700),),
                  Consumer<TodoProvider>(
                    builder: (BuildContext context, value, Widget? child) {
                      return Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: (value.toDolist.length -
                                    value.getUncompletedTasksCount())
                                    .toString(),
                                style: h4(kDarkText)),
                            TextSpan(
                              text: '/${value.toDolist.length} task completed',
                              style: h4(kLightText),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer<TodoProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return CustomPaint(
                    painter: ToDoPainter(
                      completedTasks: (value.toDolist.length -
                          value.getUncompletedTasksCount()),
                      totalTasks: value.toDolist.length,
                      radius: 32.h,
                      strokeWidth: 12.h,
                    ),
                    child: SizedBox(
                      height: 80.h,
                      width: 80.h,
                      child: Center(
                        child: Text(
                          "${value.toDolist.isNotEmpty ? ((value.toDolist.length - value.getUncompletedTasksCount()) * 100 / value.toDolist.length).toStringAsFixed(1) : 0} %",
                          style: h3Bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return MySpaceScreen(); }));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: decorationGrad,
                  child: Text("Start",style: customTitleBold(kWhite, 13,FontWeight.w700),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
