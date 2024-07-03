import 'package:flutter/material.dart' show Icons, IconData;
import 'package:uuid/uuid.dart';

import 'package:expenses_tracker/utils/date_formatter.dart';

const uuid = Uuid();

enum Category { leisure, food, work, travel }

const categoryIcons = {
  Category.leisure: Icons.movie_rounded,
  Category.food: Icons.lunch_dining_rounded,
  Category.work: Icons.work_rounded,
  Category.travel: Icons.flight_takeoff_rounded,
};

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

  String get formattedDate => formateDate(date: date);
  IconData get categoryIcon => categoryIcons[category]!;
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory({
    required List<Expense> expenses,
    required this.category,
  }) : expenses =
            expenses.where((expense) => expense.category == category).toList();

  double get totalExpenses {
    var sum = 0.0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
