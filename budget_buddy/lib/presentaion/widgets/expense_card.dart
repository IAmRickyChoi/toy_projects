import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                "purchased item",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                "date",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete, color: Colors.red[400]),
          ),
        ),
      ),
    );
  }
}
