import 'package:isar_community/isar.dart';

part 'focus_session_model.g.dart';

@collection
class FocusSessionModel {
  Id id = Isar.autoIncrement;
  late String title;
  final DateTime recordTime;

  FocusSessionModel({required this.recordTime});
}
