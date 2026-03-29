// lib/main.dart

import 'package:budget_buddy/data/models/expense_model.dart';
import 'package:budget_buddy/presentaion/view_models/expense_provider.dart';
import 'package:budget_buddy/presentaion/views/daily_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([ExpenseModelSchema], directory: dir.path);

  runApp(
    // ✅ ProviderScope가 MaterialApp 전체를 감싸도록 최상위로 올립니다.
    ProviderScope(
      overrides: [isarProvider.overrideWithValue(isar)],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // DailyListPage는 이제 MaterialApp 안의 home에만 위치합니다.
        home: DailyListPage(),
      ),
    ),
  );
}
