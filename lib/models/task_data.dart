import 'package:tasks_to_do/database.dart';

import 'task_model.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  int get taskCount => _tasks.length;
  TodoDatabase _database = TodoDatabase();

  readToDoList() async {
    List allItems = await _database.getAllItem();
    allItems.forEach((item) {
      _tasks.add(Task.fromObj(item));
    });
    notifyListeners();
  }

  Future<int> getNewId() async {
    //use the existing alarms to find the lowest empty id
    final List<int> alarmIds =
        _tasks.map((Task item) => item.id).toList(growable: false);
    int id = 0;
    while (alarmIds.contains(id)) {
      id++;
    }
    return id;
  }

  void addTask(Task task) {
    _tasks.add(task);
    _database.saveItem(task);
    notifyListeners();
  }

  void updateTask(Task task, int index) {
    _tasks.removeAt(index);
    task.toggleDone();
    _tasks.insert(index, task);
    _database.updateItem(task.id, task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    _database.deleteItem(task.id);
    notifyListeners();
  }
}
