import 'package:isar_community/isar.dart';

part 'todo.g.dart';

@collection
class Todo {
  Id id = Isar.autoIncrement;
  late String title;
  late String content;
  bool isDone = false;
  DateTime createdAt = DateTime.now();
}
