import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      color: kNewP2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Daily milestones",
                style: h2,),
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
              SizedBox(
                height: 5.h,
              ),
              Image.asset(
                "assets/illustrations/miles.png",
                height: 80.h,
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
                      radius: 34.h,
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
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: decorationGrad,
                  child: Text("Start",style: customTitle(kDarkText, 13),),
                ),
              ),
              // ElevatedButton(
              //   decoration: ,
              //     onPressed: (){},
              //     child: Text("Start"),
              // )
            ],
          ),
        ],
      ),
    );
  }
}
