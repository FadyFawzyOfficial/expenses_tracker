import 'package:flutter/material.dart';

import '../models/expense.dart';
import '../utils/date_formatter.dart';

class NewExpense extends StatefulWidget {
  final void Function({required Expense expense}) onSubmitExpense;

  const NewExpense({super.key, required this.onSubmitExpense});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _pickedDate;
  Category _pickedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
                bottom: 16 + keyboardSpace,
              ),
              child: Column(
                children: [
                  if (width < 600)
                    TitleTextField(titleController: _titleController)
                  else
                    TitleAmountRow(
                      titleController: _titleController,
                      amountController: _amountController,
                    ),
                  if (width < 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AmountTextField(amountController: _amountController),
                        DatePicker(
                          pickedDate: _pickedDate,
                          onPickerPressed: _showDatePicker,
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        CategoryDropDown(
                          pickedCategory: _pickedCategory,
                          onPicked: (category) {
                            if (category == null) return;
                            setState(() => _pickedCategory = category);
                          },
                        ),
                        DatePicker(
                          pickedDate: _pickedDate,
                          onPickerPressed: _showDatePicker,
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (width < 600)
                    Row(
                      children: [
                        CategoryDropDown(
                          pickedCategory: _pickedCategory,
                          onPicked: (category) {
                            if (category == null) return;
                            setState(() => _pickedCategory = category);
                          },
                        ),
                        Expanded(
                          child: DecisionSection(onSubmit: _submitExpense),
                        ),
                      ],
                    )
                  else
                    DecisionSection(onSubmit: _submitExpense),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDatePicker() {
    final now = DateTime.now();
    final firstDate = now.subtract(const Duration(days: 365));

    showDatePicker(context: context, firstDate: firstDate, lastDate: now)
        .then((date) => setState(() => _pickedDate = date));
  }

  void _submitExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    final isAmountInvalid = enteredAmount == null || enteredAmount <= 0;
    final isExpenseInValid = isAmountInvalid ||
        _titleController.text.trim().isEmpty ||
        _pickedDate == null;

    if (isExpenseInValid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog.adaptive(
          title: const Text('Invalid input'),
          content: const Text(
            'Please, make sure a valid title, amount, date and category was entered',
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Okay'),
            ),
          ],
        ),
      );

      return;
    }

    widget.onSubmitExpense(
      expense: Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _pickedDate!,
        category: _pickedCategory,
      ),
    );
    Navigator.pop(context);
  }
}

class DecisionSection extends StatelessWidget {
  final VoidCallback onSubmit;

  const DecisionSection({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onSubmit,
          child: const Text('Save Expense'),
        ),
      ],
    );
  }
}

class CategoryDropDown extends StatelessWidget {
  final Category? pickedCategory;
  final void Function(Category?) onPicked;

  const CategoryDropDown({
    super.key,
    required this.pickedCategory,
    required this.onPicked,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: pickedCategory,
      items: Category.values
          .map((category) => DropdownMenuItem(
                value: category,
                child: Text(category.name.toUpperCase()),
              ))
          .toList(),
      onChanged: onPicked,
    );
  }
}

class DatePicker extends StatelessWidget {
  final DateTime? pickedDate;
  final VoidCallback onPickerPressed;

  const DatePicker({
    super.key,
    required this.pickedDate,
    required this.onPickerPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            pickedDate != null
                ? formateDate(date: pickedDate!)
                : 'No date selected',
          ),
          IconButton(
            onPressed: onPickerPressed,
            icon: const Icon(Icons.calendar_month_rounded),
          ),
        ],
      ),
    );
  }
}

class TitleAmountRow extends StatelessWidget {
  const TitleAmountRow({
    super.key,
    required TextEditingController titleController,
    required TextEditingController amountController,
  })  : _titleController = titleController,
        _amountController = amountController;

  final TextEditingController _titleController;
  final TextEditingController _amountController;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TitleTextField(
            titleController: _titleController,
          ),
        ),
        const SizedBox(width: 16),
        AmountTextField(amountController: _amountController),
      ],
    );
  }
}

class AmountTextField extends StatelessWidget {
  const AmountTextField({
    super.key,
    required TextEditingController amountController,
  }) : _amountController = amountController;

  final TextEditingController _amountController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: _amountController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(label: Text('Amount')),
      ),
    );
  }
}

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    super.key,
    required TextEditingController titleController,
  }) : _titleController = titleController;

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _titleController,
      maxLength: 50,
      decoration: const InputDecoration(label: Text('Title')),
    );
  }
}
