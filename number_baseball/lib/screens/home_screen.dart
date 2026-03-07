import 'package:flutter/material.dart';
import 'package:number_baseball/screens/level_select_screen.dart';
import 'package:number_baseball/screens/local_play_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("number_baseball_game")),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LevelSelectScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Local Play"),
                ),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Online Play"),
                ),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Setting"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
