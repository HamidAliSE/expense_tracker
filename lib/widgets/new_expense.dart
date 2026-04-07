import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _onPressSaveExpense() {
    print(_titleController.text);
    print(_amountController.text);
  }

  void _onPressCancel(BuildContext ctx) {
    Navigator.pop(ctx);
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
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: Text('Amount'),
              prefixText: '\$ ',
            ),
          ),
          Row(
            children: [
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
