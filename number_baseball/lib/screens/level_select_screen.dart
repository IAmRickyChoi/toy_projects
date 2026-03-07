import 'package:flutter/material.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Easy"),
              ),
            ),
            SizedBox(height: 20.0),
            OutlinedButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Normal"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
