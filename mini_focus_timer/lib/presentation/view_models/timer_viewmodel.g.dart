// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TimerViewModel)
final timerViewModelProvider = TimerViewModelProvider._();

final class TimerViewModelProvider
    extends $NotifierProvider<TimerViewModel, TimerState> {
  TimerViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'timerViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$timerViewModelHash();

  @$internal
  @override
  TimerViewModel create() => TimerViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TimerState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimerState>(value),
    );
  }
}

String _$timerViewModelHash() => r'ef2b180d34cdab6e4786c9d430199f58d8ba2f1d';

abstract class _$TimerViewModel extends $Notifier<TimerState> {
  TimerState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TimerState, TimerState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<TimerState, TimerState>, TimerState, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
