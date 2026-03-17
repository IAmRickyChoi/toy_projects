import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:isar_todo_app/data/models/focus_session_model.dart';

final timerRepositoryProvider = Provider<TimerRepositoryImpl>((ref) {
  return TimerRepositoryImpl(ref.watch(isarProvider));
});

final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError();
});

class TimerRepositoryImpl {
  final Isar _isar;

  TimerRepositoryImpl(this._isar);

  Future<List<FocusSessionModel>> getSessions() async {
    return await _isar.focusSessionModels.where().findAll();
  }

  Future<void> saveSession(FocusSessionModel model) async {
    await _isar.writeTxn(() async {
      await _isar.focusSessionModels.put(model);
    });
  }

  Future<void> deleteSession(int id) async {
    await _isar.writeTxn(() async {
      await _isar.focusSessionModels.delete(id);
    });
  }
}
