import 'package:isar_community/isar.dart';
import 'package:todo_app/models/todo.dart';

class TodoRepository {
  final Isar isar;
  TodoRepository({required this.isar});

  Future<void> addTodo(String title, String content) async {
    final newTodo = Todo()
      ..title = title
      ..content = content;
    await isar.writeTxn(() {
      return isar.todos.put(newTodo);
    });
  }

  Future<void> deleteTodo(int id) async {
    await isar.writeTxn(() {
      return isar.todos.delete(id);
    });
  }

  Future<void> updateTodo(Todo todo, String? title, String? content) async {
    todo
      ..title = title ?? todo.title
      ..content = content ?? todo.content;
    await isar.writeTxn(() {
      return isar.todos.put(todo);
    });
  }

  Future<List<Todo>> fetchTodo() async {
    final dbTodos = await isar.todos.where().findAll();
    return dbTodos;
  }
}
