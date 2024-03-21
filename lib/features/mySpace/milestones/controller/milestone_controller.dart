import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import '../model/milestone_model.dart';

class MilestoneController extends GetxController {
  static MilestoneController get instance => Get.find();

  final RxList<MilestoneModel> toDoList = <MilestoneModel>[].obs;
  final RxBool isAdding = false.obs;
  final TextEditingController todoTextEditingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
    _loadToDoList();
  }

  Future<void> _initializeNotifications() async {
    await AwesomeNotifications().initialize(
      // Set the icon to null if you want to use the default app icon
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
      ],
    );
  }

  void _loadToDoList() {
    final storedToDoList = GetStorage().read<List>('todoList');
    if (storedToDoList != null) {
      toDoList.assignAll(
          storedToDoList.map((e)
          => MilestoneModel.fromJson(
            e as String
          )).toList());
    }
  }

  void updateIsAdding(bool adding) => isAdding.value = adding;

  void addToDo(MilestoneModel toDo) {
    toDoList.add(toDo);
    _saveToDoList();
    todoTextEditingController.clear();
  }

  void updateTodo(int index, MilestoneModel toDo) {
    if (index.isValidIndex(toDoList)) {
      toDoList[index] = toDo;
      _saveToDoList();
      if (toDo.isDone) _sendAppreciationNotification();
    }
  }

  void _saveToDoList() => GetStorage().write('todoList', toDoList.toList());

  Future<void> _sendAppreciationNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Task Completed!',
        body: 'Great job! You completed a task from your to-do list.',
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }

  int getUncompletedTasksCount() => toDoList.where((todo) => !todo.isDone).length;
}

extension on int {
  bool isValidIndex(List list) => this >= 0 && this < list.length;
}

