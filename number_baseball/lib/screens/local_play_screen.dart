import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:number_baseball/model/make_num.dart';
import 'package:number_baseball/screens/widgets/number_pad.dart';

class LocalPlayScreen extends StatefulWidget {
  const LocalPlayScreen({super.key});

  @override
  State<LocalPlayScreen> createState() => _LocalPlayScreenState();
}

class _LocalPlayScreenState extends State<LocalPlayScreen> {
  MakeNum gameNumbers = MakeNum();

  @override
  void initState() {
    super.initState();
    gameNumbers.generateNumbers();
  }

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
            Expanded(child: Container(color: Colors.red)),
            Center(
              child: Container(
                child: Text(
                  "${gameNumbers.gameNumbers}",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.blue,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 5 / 1,
                  ),
                  children: List.generate(
                    20,
                    (index) => Container(child: Text("$index")),
                  ),
                ),
              ),
            ),
            NumberPad(),

            Container(child: Text("test", style: TextStyle(fontSize: 30))),
          ],
        ),
      ),
    );
  }
}
