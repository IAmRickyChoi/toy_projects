import 'package:budget_buddy/data/models/expense_model.dart';
import 'package:budget_buddy/data/repositories/expense_repo.dart';
import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_provider.g.dart';

@Riverpod(keepAlive: true)
Isar isar(Ref ref) => throw UnimplementedError();

@riverpod
ExpenseRepo expenseRepo(Ref ref) {
  final isarInstance = ref.watch(isarProvider);
  return ExpenseRepo(isarInstance);
}

@riverpod
class ExpenseList extends _$ExpenseList {
  @override
  Stream<List<ExpenseModel>> build() {
    final service = ref.watch(expenseRepoProvider);
    return service.watchTodayExpense();
  }

  Future<void> addExpense(ExpenseModel item) {
    final service = ref.read(expenseRepoProvider);
    return service.addExpense(item);
  }

  Future<void> deleteExpense(int id) {
    final servie = ref.read(expenseRepoProvider);
    return servie.deleteExpense(id);
  }

  Future<double> getTodayExpenses() async {
    final service = ref.read(expenseRepoProvider);
    return await service.getTodayExpenses();
  }
}
