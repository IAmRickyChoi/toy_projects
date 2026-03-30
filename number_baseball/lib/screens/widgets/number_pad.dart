import 'package:flutter/material.dart';

class NumberPad extends StatelessWidget {
  const NumberPad({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [OutlinedButton(onPressed: () {}, child: Text("test"))],
          ),
          Row(children: []),
        ],
      ),
    );
  }
}
