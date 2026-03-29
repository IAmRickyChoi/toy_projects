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
    final targetDate = ref.watch(selectedDateProvider);

    return service.watchTodayExpense(targetDate);
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

@riverpod
class SelectedDate extends _$SelectedDate {
  @override
  DateTime build() {
    return DateTime.now();
  }

  void updateDate(DateTime newDate) {
    state = newDate;
  }
}

@riverpod
class WeekOffset extends _$WeekOffset {
  @override
  int build() {
    return 0; // 0: 이번 주, -1: 저번 주, 1: 다음 주
  }

  void previousWeek() => state--; // 저번 주로 이동
  void nextWeek() => state++; // 다음 주로 이동
  void resetToThisWeek() => state = 0; // 이번 주로 초기화
}

// lib/presentaion/view_models/expense_provider.dart

// ... 기존 코드 유지 ...

// ✅ 1. 파라미터(offset)를 받도록 수정된 Provider
@riverpod
Stream<List<ExpenseModel>> weeklyExpenseList(Ref ref, int offset) {
  final repo = ref.watch(expenseRepoProvider);

  // (참고: 기존에 있던 ref.watch(weekOffsetProvider)는 제거합니다.
  // 이제 외부에서 직접 offset 값을 주입받기 때문입니다.)

  final now = DateTime.now();
  // dart의 weekday는 월요일(1) ~ 일요일(7)을 반환합니다.
  final int daysSinceMonday = now.weekday - 1;
  final DateTime startOfThisWeek = DateTime(
    now.year,
    now.month,
    now.day,
  ).subtract(Duration(days: daysSinceMonday));

  // offset을 적용하여 타겟 주의 월요일과 일요일 계산
  final DateTime targetWeekStart = startOfThisWeek.add(
    Duration(days: offset * 7),
  );
  // 일요일까지 포함
  final DateTime targetWeekEnd = targetWeekStart.add(const Duration(days: 6));

  // 계산된 월요일 ~ 일요일 사이의 데이터를 스트림(ストリーム)으로 반환
  return repo.watchExpenseByDateRange(targetWeekStart, targetWeekEnd);
}
