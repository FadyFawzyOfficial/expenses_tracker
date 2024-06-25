import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { leisure, food, work, travel }

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
}
