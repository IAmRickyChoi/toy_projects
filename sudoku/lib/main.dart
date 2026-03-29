import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/sudoku/view/screens/sudoku_screen.dart';

void main() {
  runApp(ProviderScope(child: MaterialApp(home: SudokuScreen())));
}
