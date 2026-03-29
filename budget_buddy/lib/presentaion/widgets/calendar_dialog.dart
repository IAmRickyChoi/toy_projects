import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDialog extends ConsumerStatefulWidget {
  final DateTime initialDate;

  const CalendarDialog({super.key, required this.initialDate});

  @override
  ConsumerState<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends ConsumerState<CalendarDialog> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialDate;
    _selectedDay = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("날짜 선택"),
      content: SizedBox(
        width: 350, // 다이얼로그 너비 고정
        height: 450,
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          // 스타일 커스텀 (OutlinedButton 느낌과 맞추기)
          calendarStyle: const CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
      actions: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.grey,
            side: const BorderSide(color: Colors.grey),
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text("exit"),
        ),
        ElevatedButton(
          onPressed: () {
            // 결과값을 들고 팝업 닫기
            Navigator.pop(context, _selectedDay);
          },
          child: const Text("Confirm"),
        ),
      ],
    );
  }
}
