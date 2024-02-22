import 'package:flutter/material.dart';
import 'package:knowyourself/models/To%20Do/to_do_model.dart';
import 'package:knowyourself/utils/pref.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TodoProvider extends ChangeNotifier {
  final List<ToDoModel> _toDoList =
  SharedPreferencesHelper.getTodoList(dateTime: DateTime.now());
  bool _isAdding = false;
  final TextEditingController _todoTextEditingController =
  TextEditingController();

  // Initialize FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  TodoProvider() {
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
    const InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  List<ToDoModel> get toDolist => _toDoList;
  bool get isAdding => _isAdding;
  TextEditingController get todoTextEditingController =>
      _todoTextEditingController;

  void updateIsAdding(bool isAdding) {
    _isAdding = isAdding;
    notifyListeners();
  }

  void addToDo(ToDoModel todo) {
    _toDoList.add(todo);
    SharedPreferencesHelper.saveToDoList(todos: _toDoList);
    notifyListeners();
    _todoTextEditingController.clear();
  }

  void updateTodo({required int index, required ToDoModel toDoModel}) {
    _toDoList.removeAt(index);
    _toDoList.insert(index, toDoModel);
    SharedPreferencesHelper.saveToDoList(todos: _toDoList);
    notifyListeners();

    // Check if the task is completed
    if (toDoModel.isDone) {
      _sendAppreciationNotification();
    }
  }

  Future<void> _sendAppreciationNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'appreciation_channel',
      'Channel for sending motivational appreciation notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Task Completed!',
      'Great job! You completed a task from your to-do list.',
      platformChannelSpecifics,
      payload: 'appreciation',
    );
  }

  int getUncompletedTasksCount() {
    int tasks = 0;
    for (ToDoModel toDoModel in _toDoList) {
      if (!toDoModel.isDone) {
        tasks += 1;
      }
    }
    return tasks;
  }
}
