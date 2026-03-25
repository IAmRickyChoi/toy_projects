import 'package:budget_buddy/data/models/expense_model.dart';
import 'package:budget_buddy/presentaion/view_models/expense_provider.dart';
import 'package:budget_buddy/presentaion/views/daily_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([ExpenseModelSchema], directory: dir.path);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProviderScope(
        overrides: [isarProvider.overrideWithValue(isar)],
        child: DailyListPage(),
      ),
    ),
  );
}
