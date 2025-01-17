import 'package:flutter/material.dart';

import '../../models/expense.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  final void Function({required Expense expense}) onRemoveExpense;

  const ExpenseItem({
    super.key,
    required this.expense,
    required this.onRemoveExpense,
  });

  @override
  Widget build(context) {
    return Dismissible(
      key: ValueKey(expense.id),
      onDismissed: (_) => onRemoveExpense(expense: expense),
      background: ColoredBox(
        color: Theme.of(context).colorScheme.error.withOpacity(0.75),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$${expense.amount.toStringAsFixed(2)}'),
                  Row(
                    children: [
                      Icon(expense.categoryIcon),
                      const SizedBox(width: 4),
                      Text(expense.formattedDate),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
