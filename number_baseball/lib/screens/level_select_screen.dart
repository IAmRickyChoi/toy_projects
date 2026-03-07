import 'package:flutter/material.dart';
import 'package:number_baseball/screens/local_play_screen.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Level")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return LocalPlayScreen();
                    },
                  ),
                );
              },
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
