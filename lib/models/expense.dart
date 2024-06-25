import 'package:flutter/material.dart' show Icons, IconData;
import 'package:uuid/uuid.dart';

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

  String get formattedDate => '${date.day}/${date.month}/${date.year}';
  IconData get categoryIcon => categoryIcons[category]!;
}
