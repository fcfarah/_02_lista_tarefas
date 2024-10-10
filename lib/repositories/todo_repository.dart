import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:_02_lista_tarefas/models/todo.dart';

const todoListKey = 'todo_list';

class TodoRepository {
  TodoRepository() {
    SharedPreferences.getInstance().then((value) {
      sharedPreferences = value;
    });
  }

  late SharedPreferences sharedPreferences;

  Future<void> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(todoListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    jsonDecoded.map((e) => Todo.fromJson(e)).toList();
  }

  void saveTodoList(List<Todo> todos) {
    final String jsonString = json.encode(todos);
    sharedPreferences.setString('todo_list', jsonString);
  }
}
