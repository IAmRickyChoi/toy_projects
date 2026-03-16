import 'package:flutter/material.dart';
import 'package:mini_focus_timer/presentation/views/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple,
        ),
      ),
      home: HomeScreen(),
    ),
  );
}
