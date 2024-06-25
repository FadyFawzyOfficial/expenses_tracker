import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  var _title = '';

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Title')),
            onChanged: (value) => _title = value,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => print(_title),
                child: const Text('Save Expense'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
