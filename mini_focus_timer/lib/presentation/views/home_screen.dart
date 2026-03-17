import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_todo_app/presentation/view_models/timer_viewmodel.dart';
import 'package:isar_todo_app/presentation/widgets/countdown_clock.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerViewModelProvider);
    final timerViewModel = ref.read(timerViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mini Focus Timer"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: timerViewModel.resetTimer,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(
              flex: 2,
              child: Center(child: CountdownClock()),
            ),
            Expanded(
              flex: 3,
              child: ListView.builder(
                itemCount: timerState.sessions.length,
                itemBuilder: (context, index) {
                  final session = timerState.sessions[index];
                  return ListTile(
                    title: Text(
                      "Focus: ${session.duration ~/ 60} minutes",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${session.recordTime}",
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => timerViewModel.deleteSession(session.id),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: timerState.isRunning
                        ? timerViewModel.pauseTimer
                        : timerViewModel.startTimer,
                    child: Text(
                      timerState.isRunning ? "Pause" : "Start",
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
