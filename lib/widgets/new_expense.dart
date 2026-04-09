import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.work;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _onPressSaveExpense() {
    final double? amountEntered = double.tryParse(_amountController.text);
    final bool isInvalidAmount = amountEntered == null || amountEntered <= 0;

    if (_titleController.text.trim().isEmpty ||
        isInvalidAmount ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid Expense Data!'),
          content: Text(
            'Please make sure a valid title, amount, date & category is entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
  }

  void _onPressCancel(BuildContext ctx) {
    Navigator.pop(ctx);
  }

  void _pickDate() async {
    final now = DateTime.now();
    final datePicked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: now,
    );

    setState(() {
      _selectedDate = datePicked;
    });
  }

  void _onChangeCategory(Category? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _selectedCategory = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('Amount'),
                    prefixText: '\$ ',
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No Date Selected'
                          : dateFormatter.format(_selectedDate!),
                    ),
                    SizedBox(width: 5),
                    IconButton(
                      icon: Icon(Icons.calendar_month),
                      onPressed: _pickDate,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: _onChangeCategory,
              ),
              Spacer(),
              TextButton(
                onPressed: () => _onPressCancel(context),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _onPressSaveExpense,
                child: Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
