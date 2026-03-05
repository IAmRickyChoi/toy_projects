import 'package:flutter/material.dart';
import 'package:vid_player/screens/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          surface: Colors.white,
        ),
      ),
      home: HomeScreen(),
    ),
  );
}
