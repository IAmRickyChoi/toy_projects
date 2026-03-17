import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/focus_session_model.dart';
import '../../data/repositories/timer_repository_impl.dart';

part 'timer_viewmodel.g.dart';

// 1. 상태 관리를 위한 TimerState 클래스 정의
class TimerState {
  final int seconds;
  final bool isRunning;
  final List<FocusSessionModel> sessions; // 화면에 보여줄 세션 리스트

  TimerState({
    required this.seconds,
    required this.isRunning,
    this.sessions = const [],
  });

  TimerState copyWith({
    int? seconds,
    bool? isRunning,
    List<FocusSessionModel>? sessions,
  }) {
    return TimerState(
      seconds: seconds ?? this.seconds,
      isRunning: isRunning ?? this.isRunning,
      sessions: sessions ?? this.sessions,
    );
  }
}

// 2. ViewModel 정의
@riverpod
class TimerViewModel extends _$TimerViewModel {
  Timer? _timer;

  @override
  TimerState build() {
    // 앱이 처음 켜져서 ViewModel이 생성될 때 Isar DB에서 데이터를 불러옵니다.
    _loadSessions();

    // 초기 상태 반환 (데이터를 불러오기 전 빈 리스트)
    return TimerState(seconds: 0, isRunning: false, sessions: []);
  }

  // Isar에서 데이터를 읽어와 상태의 sessions 리스트를 업데이트하는 함수
  Future<void> _loadSessions() async {
    final repository = ref.read(timerRepositoryProvider);
    final savedSessions = await repository.getSessions();

    state = state.copyWith(sessions: savedSessions);
  }

  void startTimer() {
    if (state.isRunning) return; // 이미 실행중이면 무시

    state = state.copyWith(isRunning: true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(seconds: state.seconds + 1);
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false);
  }

  // 초기화 (동시에 Isar에 기록 저장)
  void resetTimer() async {
    _timer?.cancel();

    // 타이머가 1초 이상 돌아갔을 때만 저장하도록 예외 처리
    if (state.seconds > 0) {
      final repository = ref.read(timerRepositoryProvider);

      // Isar에 저장할 모델 생성
      final newSession = FocusSessionModel(
        duration: state.seconds,
        recordTime: DateTime.now(),
      );

      await repository.saveSession(newSession); // DB 저장
      await _loadSessions(); // 저장 후 목록 새로고침 (UI 업데이트)
    }

    // 시간과 상태를 초기화
    state = state.copyWith(seconds: 0, isRunning: false);
  }

  // 리스트에서 항목 삭제
  Future<void> deleteSession(int id) async {
    final repository = ref.read(timerRepositoryProvider);
    await repository.deleteSession(id); // DB에서 삭제
    await _loadSessions(); // 삭제 후 목록 새로고침 (UI 업데이트)
  }
}
