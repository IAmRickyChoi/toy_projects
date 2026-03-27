import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {
  final String item;
  final double price;
  final DateTime datetime;
  final VoidCallback onDelete;
  const ExpenseCard({
    super.key,
    required this.item,
    required this.price,
    required this.datetime,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateFormat("HH:mm").format(datetime);
    return Card(
      elevation: 1,
      margin: EdgeInsets.only(left: 10, right: 10, top: 13),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                date,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          title: Text(
            '${price.toStringAsFixed(0)} ¥',
            textAlign: TextAlign.right,
          ),
          trailing: IconButton(
            onPressed: onDelete,
            icon: Icon(Icons.delete, color: Colors.red[400]),
          ),
        ),
      ),
    );
  }
}
