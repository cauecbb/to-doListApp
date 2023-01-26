import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo_model.dart';

abstract class ITodoRepository {
  Future<void> save(List<TodoModel> items);

  Future<List<TodoModel>> load();
}

class TodoRepositorySharedPrefs extends ITodoRepository {
  @override
  Future<void> save(List<TodoModel> items) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(items));
  }

  @override
  Future<List<TodoModel>> load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data') ?? '';

    Iterable decoded = jsonDecode(data);
    List<TodoModel> result = decoded.map((x) => TodoModel.fromJson(x)).toList();
    return result;
  }
}

class TodoRepositoryAPI extends ITodoRepository {
  @override
  Future<void> save(List<TodoModel> items) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(items));
  }

  @override
  Future<List<TodoModel>> load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data') ?? '';

    Iterable decoded = jsonDecode(data);
    List<TodoModel> result = decoded.map((x) => TodoModel.fromJson(x)).toList();
    return result;
  }
}
