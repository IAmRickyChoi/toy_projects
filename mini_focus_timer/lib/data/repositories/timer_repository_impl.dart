import 'package:isar_community/isar.dart';
import 'package:mini_focus_timer/data/models/focus_session_model.dart';
import 'package:path_provider/path_provider.dart';

class TimerRepositoryImpl {
  late Isar _isar;

  void initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    final _isar = await Isar.open([
      FocusSessionModelSchema,
    ], directory: dir.path);
  }

  Future<void> saveTime(DateTime date) async {
    final savedTime = FocusSessionModel(recordTime: date);
    await _isar.writeTxn(() async {
      await _isar.focusSessionModels.put(savedTime);
    });
  }

  Future<void> deleteTime(int id) async {
    await _isar.focusSessionModels.delete(id);
  }
}
