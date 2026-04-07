import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          children: [
            Text(expense.title),
            Row(
              children: [
                Text(expense.amount.toStringAsFixed(2)),
                Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    SizedBox(width: 5),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
