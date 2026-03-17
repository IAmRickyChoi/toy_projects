import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/timer_viewmodel.dart';

class CountdownClock extends ConsumerWidget {
  const CountdownClock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch를 사용해 상태를 실시간으로 구독합니다.
    final timerState = ref.watch(timerViewModelProvider);

    final minutes = (timerState.seconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (timerState.seconds % 60).toString().padLeft(2, '0');

    return Text(
      '$minutes:$seconds',
      style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
    );
  }
}
