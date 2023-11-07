import 'package:flutter/material.dart';
import 'package:knowyourself/models/To%20Do/to_do_model.dart';
import 'package:knowyourself/utils/pref.dart';

class TodoProvider extends ChangeNotifier {
  final List<ToDoModel> _toDoList =
      SharedPreferencesHelper.getTodoList(dateTime: DateTime.now());
  bool _isAdding = false;
  final TextEditingController _todoTextEditingController =
      TextEditingController();

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
