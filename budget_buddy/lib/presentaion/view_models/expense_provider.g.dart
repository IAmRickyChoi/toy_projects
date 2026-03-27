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

String _$expenseListHash() => r'bd25e88ef0bb5c639e4b83e3c5a6529f15f7c192';

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
