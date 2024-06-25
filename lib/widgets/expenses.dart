import 'package:expenses_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';
import 'expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _showExpenseBottomSheet,
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('The chart'),
            Expanded(child: ExpensesList(expenses: _expenses)),
          ],
        ),
      ),
    );
  }

  void _showExpenseBottomSheet() => showModalBottomSheet(
        context: context,
        builder: (context) => const NewExpense(),
      );
}
