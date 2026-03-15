import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final bool isDone;
  final Function() onTap;
  final Function() delete;
  const TodoTile({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.isDone,
    required this.onTap,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              key: ValueKey(index),
              onPressed: (context) {
                delete();
              },
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(18.0),
            ),
          ],
        ),
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(18.0),
          ),
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
