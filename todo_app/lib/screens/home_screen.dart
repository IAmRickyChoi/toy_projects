import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/repositories/todo_repository.dart';
import 'package:todo_app/widgets/todo_tile.dart';

class HomeScreen extends StatefulWidget {
  final TodoRepository isar;
  const HomeScreen({super.key, required this.isar});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  List<Todo> todoList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodos();
  }

  void getTodos() async {
    todoList = await widget.isar.fetchTodo();
    setState(() {});
  }

  void addTodo(String title, String subTitle) async {
    await widget.isar.addTodo(title, subTitle);
    getTodos();
  }

  void deleteTodo(int id) async {
    await widget.isar.deleteTodo(id);
    getTodos();
  }

  void onPressed() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(controller: _titleController),
              TextFormField(controller: _contentController),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                addTodo(_titleController.text, _contentController.text);

                _titleController.clear();
                _contentController.clear();
                Navigator.pop(context);
              },
              child: Text("Add", style: TextStyle(fontSize: 17.0)),
            ),
          ],
        );
      },
    );
  }

  void _changeChecked(Todo todo, bool checked) async {
    checked = !checked;
    await widget.isar.updateTodo(todo, isDone: checked);
    print("changed");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: Colors.blue.shade100,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Text(
          "Todo",
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            index: index,
            title: todoList[index].title,
            subtitle: todoList[index].content,
            isDone: todoList[index].isDone,
            onTap: () =>
                _changeChecked(todoList[index], todoList[index].isDone),
            delete: () => deleteTodo(todoList[index].id),
          );
        },
      ),
    );
  }
}
