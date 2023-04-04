import 'package:flutter/foundation.dart';
import '../todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final List<TODOModel> _todoList = [];

  List<TODOModel> get allToDoList => _todoList;

  void addToDoList(TODOModel todoModel) {
    _todoList.add(todoModel);
    notifyListeners();
  }

  void removeToDOList(TODOModel todoModel) {
    final index = _todoList.indexOf(todoModel);
    _todoList.removeAt(index);
    notifyListeners();
  }

  void todoStatusChange(TODOModel todoModel) {
    final index = _todoList.indexOf(todoModel);
    _todoList[index].toggleCompleted();
    notifyListeners();
  }
}
