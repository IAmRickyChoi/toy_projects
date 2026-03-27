import 'package:budget_buddy/data/models/expense_model.dart';
import 'package:isar_community/isar.dart';

class ExpenseRepo {
  final Isar _isar;
  ExpenseRepo(this._isar);

  Stream<List<ExpenseModel>> watchExpense() {
    return _isar.expenseModels.where().watch(fireImmediately: true);
  }

  Stream<List<ExpenseModel>> watchTodayExpense() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

    return _isar.expenseModels
        .filter()
        .datetimeBetween(startOfDay, endOfDay)
        .watch(fireImmediately: true);
  }

  Future<void> addExpense(ExpenseModel item) async {
    await _isar.writeTxn(() async {
      await _isar.expenseModels.put(item);
    });
  }

  Future<void> deleteExpense(int id) async {
    await _isar.writeTxn(() async {
      await _isar.expenseModels.delete(id);
    });
  }

  Future<double> getTodayExpenses() async {
    final now = DateTime.now();
    // 오늘의 시작 시점: 2026-03-27 00:00:00.000
    final startOfDay = DateTime(now.year, now.month, now.day);
    // 오늘의 끝 시점: 2026-03-27 23:59:59.999
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
    return await _isar.expenseModels
        .filter()
        .datetimeBetween(startOfDay, endOfDay)
        .priceProperty()
        .sum();
  }
}
