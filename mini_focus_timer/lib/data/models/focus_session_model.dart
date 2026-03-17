import 'package:isar_community/isar.dart';

part 'focus_session_model.g.dart';

@collection
class FocusSessionModel {
  Id id = Isar.autoIncrement;
  final int duration;
  final DateTime recordTime;

  FocusSessionModel({
    required this.duration,
    required this.recordTime,
  });
}
