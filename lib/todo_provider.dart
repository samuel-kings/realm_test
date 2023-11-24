import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_test/init_realm_local.dart';
import 'package:realm_test/todo.dart';

class TodoProvider extends ChangeNotifier {
  String _error = "";
  bool _isInitialLoading = true;
  List<Todo> _todos = [];

  String get error => _error;
  List<Todo> get todos => _todos;
  bool get isInitialLoading => _isInitialLoading;

  TodoProvider() {
    getAllTodos();
  }

  Future<bool> createTodo(Todo todo) async {
    try {
      await realmLocal.writeAsync(() => realmLocal.add(todo));
      _todos = realmLocal.all<Todo>().toList();
      notifyListeners();
      return true;
    } on RealmException catch (e) {
      _error = e.message;
      debugPrint(_error);
      return false;
    }
  }

  Future<bool> markUnmarkdone(Todo todo, bool isDone) async {
    try {
      await realmLocal.writeAsync(() {
        todo.isDone = isDone;
      });
      _todos = realmLocal.all<Todo>().toList();
      notifyListeners();
      return true;
    } on RealmException catch (e) {
      _error = e.message;
      debugPrint(_error);
      return false;
    }
  }

  Future<void> getAllTodos() async {
    try {
      _isInitialLoading = true;
      notifyListeners();

      _todos = realmLocal.all<Todo>().toList();

      _isInitialLoading = false;
      notifyListeners();
    } on RealmException catch (e) {
      _error = e.message;
      debugPrint(_error);
      _isInitialLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteTodo(Todo todo) async {
    try {
      await realmLocal.writeAsync(() => realmLocal.delete(todo));
      await Future.delayed(const Duration(milliseconds: 500));
      _todos = realmLocal.all<Todo>().toList();
      notifyListeners();
      return false;
    } on RealmException catch (e) {
      _error = e.message;
      debugPrint(_error);
      return false;
    }
  }
}
