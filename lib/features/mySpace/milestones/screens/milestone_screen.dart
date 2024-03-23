import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/mySpace/milestones/screens/widget/milestone_detail.dart';
import '../../../../common/widgets/linear_percent_indicator.dart';
import '../../../../utils/constants/colors.dart';
import '../controller/milestone_controller.dart';
import '../model/milestone_model.dart';

class MilestoneAdd extends StatelessWidget {
  const MilestoneAdd({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MilestoneController());
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: 'My ',
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w600)),
                TextSpan(
                  text: 'Milestones',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: kApp4),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kBoxLight,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                            text: 'I will accomplish ',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                        TextSpan(
                          text: controller.getUncompletedTasksCount().toString(),
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: kApp4),
                        ),
                        const TextSpan(
                            text: ' task(s) today.',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  )),
                  const SizedBox(height: 12),
                  Obx(() => LinearPercentIndicator(
                    padding: EdgeInsets.zero,
                    lineHeight: 5,
                    percent: controller.toDoList.isNotEmpty
                        ? ((controller.toDoList.length - controller.getUncompletedTasksCount()) / controller.toDoList.length)
                        : 0,
                    progressColor: kPrimaryColor,
                    backgroundColor: const Color(0xFFD9D9D9),
                    barRadius: const Radius.circular(20),
                  )),
                  const SizedBox(height: 12),
                  Obx(() => ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: controller.toDoList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          if (controller.toDoList[index].isDone == true) {
                            return;
                          }
                          controller.updateTodo(
                              index,
                              controller.toDoList[index].copyWith(isDone: true));
                          // You may handle additional logic here as needed
                        },
                        child: MilestoneDetails(milestoneModel: controller.toDoList[index]), // Ensure this widget is defined or adapt accordingly
                      );
                    },
                  )),
                  Obx(() => controller.isAdding.isTrue
                      ? TextField(
                    controller: controller.todoTextEditingController,
                    autofocus: controller.isAdding.isTrue,
                    key: UniqueKey(),
                  )
                      : Container()),
                  Center(
                    child: InkWell(
                      onTap: () {
                        if (controller.isAdding.isTrue && controller.todoTextEditingController.text.isEmpty) {
                          controller.updateIsAdding(false);
                        } else if (controller.isAdding.isTrue) {
                          MilestoneModel milestoneModel = MilestoneModel(
                              title: controller.todoTextEditingController.text,
                              isDone: false);
                          controller.addToDo(milestoneModel);
                          controller.updateIsAdding(false);
                        } else {
                          controller.updateIsAdding(true);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        width: 240,
                        height: 40,
                        decoration: BoxDecoration(
                          color: kApp4, // Ensure this color is defined or replace with your color
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: Obx(() => Text(
                            !controller.isAdding.isTrue ? "Add Task" : "Save Task",
                            style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
