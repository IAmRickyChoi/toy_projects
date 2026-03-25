import 'package:budget_buddy/data/models/expense_model.dart';
import 'package:isar_community/isar.dart';

class ExpenseRepo {
  final Isar _isar;
  ExpenseRepo(this._isar);

  Stream<List<ExpenseModel>> watchExpense() {
    return _isar.expenseModels.where().watch(fireImmediately: true);
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
}
