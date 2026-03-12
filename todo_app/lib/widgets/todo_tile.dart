import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isDone;
  const TodoTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.blue.shade100,
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
          trailing: isDone
              ? Icon(Icons.check_box)
              : Icon(Icons.check_box_outline_blank),
        ),
      ),
    );
  }
}
