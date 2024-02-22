import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/Space/widgets/to_do_detail_widget.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/models/To%20Do/status_model.dart';
import 'package:knowyourself/models/To%20Do/to_do_model.dart';
import 'package:knowyourself/provider/ToDo/status_provider.dart';
import 'package:knowyourself/provider/ToDo/to_do_provider.dart';
import 'package:knowyourself/utils/linear_percent_indicator.dart';
import 'package:knowyourself/utils/ui_colors.dart';

class ToDoContainerWidget extends StatelessWidget {
  const ToDoContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: 'My Daily ',
                    style: TextStyle(
                        fontSize: 24.sp, fontWeight: FontWeight.w600)),
                TextSpan(
                  text: 'Task',
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: kApp4),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 18.h,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  offset: Offset(0.0, 4), //(x,y)
                  blurRadius: 38.0,
                ),
              ],
            ),
            child: Consumer<TodoProvider>(
              builder: (BuildContext context, value, Widget? child) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'I will accomplish ',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600)),
                            TextSpan(
                              text: value.getUncompletedTasksCount().toString(),
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: kApp4),
                            ),
                            TextSpan(
                                text: ' task(s) today.',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      LinearPercentIndicator(
                        padding: EdgeInsets.zero,
                        lineHeight: 5.h,
                        percent: value.toDolist.isNotEmpty
                            ? ((value.toDolist.length -
                                    value.getUncompletedTasksCount()) /
                                value.toDolist.length)
                            : 0,
                        progressColor: kTodoPrimaryColor,
                        backgroundColor: const Color(0xFFD9D9D9),
                        barRadius: const Radius.circular(20),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      // Divider(thickness: 5.h, color: kTodoPrimaryColor),
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: value.toDolist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              if (value.toDolist[index].isDone == true) {
                                return;
                              }
                              value.updateTodo(
                                  index: index,
                                  toDoModel: value.toDolist[index]
                                      .copyWith(isDone: true));
                              String title = value.toDolist[index].title;
                              int imageIndex = Random().nextInt(9);
                              StatusModel statusModel = StatusModel(
                                  title: title,
                                  image: "bg$imageIndex.jpg",
                                  dateTime: DateTime.now(),
                                  hasSeen: false,
                                  statustype: Statustype.todo);
                              Provider.of<StatusProvider>(context,
                                      listen: false)
                                  .addStatus(statusModel: statusModel);
                            },
                            child: TodoDetailsWidget(
                                toDoModel: value.toDolist[index]),
                          );
                        },
                      ),
                      if (value.isAdding == true)
                        TextField(
                          controller: value.todoTextEditingController,
                          autofocus: value.isAdding,
                          key: UniqueKey(),
                        ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            if (value.isAdding == true &&
                                value.todoTextEditingController.text == "") {
                              value.updateIsAdding(false);
                            } else if (value.isAdding == true) {
                              ToDoModel toDoModel = ToDoModel(
                                  title: value.todoTextEditingController.text,
                                  isDone: false);
                              value.addToDo(toDoModel);
                              value.updateIsAdding(false);
                            } else {
                              value.updateIsAdding(true);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            width: 240.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: kApp4,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Center(
                              child: Text(
                                !value.isAdding ? "Add Task" : "Save Task",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
