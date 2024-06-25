import 'package:flutter/material.dart';

import 'widgets/expenses.dart';

void main() => runApp(const ExpensesTracker());

class ExpensesTracker extends StatelessWidget {
  const ExpensesTracker({super.key});

  @override
  Widget build(context) {
    return const MaterialApp(
      home: Expenses(),
    );
  }
}
