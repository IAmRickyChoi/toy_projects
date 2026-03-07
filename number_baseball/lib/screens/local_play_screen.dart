import 'dart:math' as math;

import 'package:flutter/material.dart';

class LocalPlayScreen extends StatelessWidget {
  const LocalPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Transform.rotate(
                angle: math.pi, // 180도(π) 회전
                child: Text("test", style: TextStyle(fontSize: 20)),
              ),
            ),
            Expanded(child: Container(color: Colors.yellow)),
            Container(child: Text("test", style: TextStyle(fontSize: 20))),
          ],
        ),
      ),
    );
  }
}
