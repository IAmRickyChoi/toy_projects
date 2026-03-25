import 'package:isar_community/isar.dart';

part 'expense_model.g.dart';

@collection
class ExpenseModel {
  Id id = Isar.autoIncrement;
  @Index()
  late String title;
  late double price;
  DateTime datetime = DateTime.now();
}
