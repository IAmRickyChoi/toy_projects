// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sudoku_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Sudoku)
final sudokuProvider = SudokuProvider._();

final class SudokuProvider extends $NotifierProvider<Sudoku, SudokuState> {
  SudokuProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sudokuProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sudokuHash();

  @$internal
  @override
  Sudoku create() => Sudoku();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SudokuState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SudokuState>(value),
    );
  }
}

String _$sudokuHash() => r'6bcfe1afff67ce022a672a0a6fad69d6419e8868';

abstract class _$Sudoku extends $Notifier<SudokuState> {
  SudokuState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SudokuState, SudokuState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SudokuState, SudokuState>,
              SudokuState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
