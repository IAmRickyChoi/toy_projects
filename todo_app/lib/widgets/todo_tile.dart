import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isDone;
  final Function() onTap;
  const TodoTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isDone,
    required this.onTap,
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
          trailing: _Icon(checked: isDone, onTap: onTap),
        ),
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  bool checked;
  final Function() onTap;
  _Icon({super.key, required this.checked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: checked
          ? Icon(Icons.check_box)
          : Icon(Icons.check_box_outline_blank),
    );
  }
}
