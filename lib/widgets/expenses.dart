import 'package:expenses_tracker/widgets/chart/chart.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';
import 'expenses_list/expenses_list.dart';
import 'new_expense.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
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
        child: screenWidth < 600
            ? Column(
                children: [
                  Chart(expenses: _expenses),
                  Expanded(
                    child: _expenses.isEmpty
                        ? const ExpensesEmptyState()
                        : ExpensesList(
                            expenses: _expenses,
                            onRemoveExpense: _removeExpense,
                          ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _expenses)),
                  Expanded(
                    child: _expenses.isEmpty
                        ? const ExpensesEmptyState()
                        : ExpensesList(
                            expenses: _expenses,
                            onRemoveExpense: _removeExpense,
                          ),
                  ),
                ],
              ),
      ),
    );
  }

  void _showExpenseBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => NewExpense(
        onSubmitExpense: _addNewExpense,
      ),
    );
  }

  void _addNewExpense({required Expense expense}) =>
      setState(() => _expenses.add(expense));

  void _removeExpense({required Expense expense}) {
    final expenseIndex = _expenses.indexOf(expense);
    setState(() => _expenses.remove(expense));
    _showReaddExpenseSnackBar(
      onReaddExpense: () => _readdExpense(
        expense: expense,
        expenseIndex: expenseIndex,
      ),
    );
  }

  void _readdExpense({required int expenseIndex, required Expense expense}) {
    setState(() => _expenses.insert(expenseIndex, expense));
  }

  void _showReaddExpenseSnackBar({required VoidCallback onReaddExpense}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense is deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: onReaddExpense,
        ),
      ),
    );
  }
}
