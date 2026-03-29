// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(isar)
final isarProvider = IsarProvider._();

final class IsarProvider extends $FunctionalProvider<Isar, Isar, Isar>
    with $Provider<Isar> {
  IsarProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isarProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isarHash();

  @$internal
  @override
  $ProviderElement<Isar> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Isar create(Ref ref) {
    return isar(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Isar value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Isar>(value),
    );
  }
}

String _$isarHash() => r'961e5937a656dcb00d4c0ea99d2d30aaf61192d2';

@ProviderFor(expenseRepo)
final expenseRepoProvider = ExpenseRepoProvider._();

final class ExpenseRepoProvider
    extends $FunctionalProvider<ExpenseRepo, ExpenseRepo, ExpenseRepo>
    with $Provider<ExpenseRepo> {
  ExpenseRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expenseRepoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expenseRepoHash();

  @$internal
  @override
  $ProviderElement<ExpenseRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ExpenseRepo create(Ref ref) {
    return expenseRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExpenseRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExpenseRepo>(value),
    );
  }
}

String _$expenseRepoHash() => r'ec19f28f4664d2f26124ff9538bb965e775cafc5';

@ProviderFor(ExpenseList)
final expenseListProvider = ExpenseListProvider._();

final class ExpenseListProvider
    extends $StreamNotifierProvider<ExpenseList, List<ExpenseModel>> {
  ExpenseListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expenseListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expenseListHash();

  @$internal
  @override
  ExpenseList create() => ExpenseList();
}

String _$expenseListHash() => r'd60191e31dab8a0422dafbede221b6470df201ef';

abstract class _$ExpenseList extends $StreamNotifier<List<ExpenseModel>> {
  Stream<List<ExpenseModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ExpenseModel>>, List<ExpenseModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ExpenseModel>>, List<ExpenseModel>>,
              AsyncValue<List<ExpenseModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SelectedDate)
final selectedDateProvider = SelectedDateProvider._();

final class SelectedDateProvider
    extends $NotifierProvider<SelectedDate, DateTime> {
  SelectedDateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedDateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedDateHash();

  @$internal
  @override
  SelectedDate create() => SelectedDate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$selectedDateHash() => r'b0b5536023b5bf5af4790d11f307c9faa7fc586d';

abstract class _$SelectedDate extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(WeekOffset)
final weekOffsetProvider = WeekOffsetProvider._();

final class WeekOffsetProvider extends $NotifierProvider<WeekOffset, int> {
  WeekOffsetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weekOffsetProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weekOffsetHash();

  @$internal
  @override
  WeekOffset create() => WeekOffset();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$weekOffsetHash() => r'1a38313231b81084422ca6197c37b151589d78a6';

abstract class _$WeekOffset extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(weeklyExpenseList)
final weeklyExpenseListProvider = WeeklyExpenseListFamily._();

final class WeeklyExpenseListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ExpenseModel>>,
          List<ExpenseModel>,
          Stream<List<ExpenseModel>>
        >
    with
        $FutureModifier<List<ExpenseModel>>,
        $StreamProvider<List<ExpenseModel>> {
  WeeklyExpenseListProvider._({
    required WeeklyExpenseListFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'weeklyExpenseListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$weeklyExpenseListHash();

  @override
  String toString() {
    return r'weeklyExpenseListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<ExpenseModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<ExpenseModel>> create(Ref ref) {
    final argument = this.argument as int;
    return weeklyExpenseList(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WeeklyExpenseListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$weeklyExpenseListHash() => r'9ebef37c1cb5579a930ff46bd626e258eceb3ff3';

final class WeeklyExpenseListFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<ExpenseModel>>, int> {
  WeeklyExpenseListFamily._()
    : super(
        retry: null,
        name: r'weeklyExpenseListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  WeeklyExpenseListProvider call(int offset) =>
      WeeklyExpenseListProvider._(argument: offset, from: this);

  @override
  String toString() => r'weeklyExpenseListProvider';
}
