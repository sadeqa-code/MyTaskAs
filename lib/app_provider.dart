import 'package:flutter/cupertino.dart';

import 'Models/Task.dart';
import 'Utils/database_helper.dart';

class AppProvider extends ChangeNotifier {
  List<Task> _tesks = new List();
  List<Task> _getTasks = new List();

  getTasksFromDB(Future<List<Map>> tasks, Function fun) {
    tasks.then((value) {
      value.forEach((element) {
        this._getTasks.add(Task(element[DatabaseHelper.colTitle],
            element[DatabaseHelper.colType] == 1 ? true : false));
      });
      fun();
    });
    return this._getTasks;
  }

  setValue(List<Task> tasks) {
    this._tesks = tasks;
    notifyListeners();
  }

  List<Task> getValue() {
    return this._tesks;
  }

  insertTask(Task task) {
    this._tesks.add(task);
    notifyListeners();
  }

  deleteTask(Task task) {
    this._tesks.remove(task);
    notifyListeners();
  }

  updateTask(Task task) {
    this._tesks.forEach((element) {
      if (element.title == task.title) {
        element.type = task.type;
      }
    });
    notifyListeners();
  }
}
