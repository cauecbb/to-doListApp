import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:todo/shared/models/todo_model.dart';
import 'package:todo/shared/repositories/todo_repository.dart';

class TodoController extends ChangeNotifier {
  final ITodoRepository todoRepository;
  TodoController(this.todoRepository);
  var newTaskController = TextEditingController();
  FocusNode newTaskFocusNode = FocusNode();
  final List<TodoModel> items = [];

  void addItem() {
    if (newTaskController.text.isEmpty) return;
    TodoModel item = TodoModel(title: newTaskController.text, done: false);
    items.add(item);
    _save();
    notifyListeners();
    newTaskController.text = "";
  }

  void removeItem(int index) {
    items.removeAt(index);
    _save();
    notifyListeners();
  }

  setItemDone(int index, bool done) {
    items[index].done = done;
    _save();
    notifyListeners();
  }

  _save() async {
    todoRepository.save(items);
  }

  Future load() async {
    List<TodoModel> result = await todoRepository.load();
    items.clear();
    items.addAll(result);
    notifyListeners();
  }
}
