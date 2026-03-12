import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/repositories/todo_repository.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([TodoSchema], directory: dir.path);

  runApp(
    MaterialApp(
      home: HomeScreen(isar: TodoRepository(isar: isar)),
    ),
  );
}
