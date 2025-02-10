import 'package:expense/models/expense.dart';
import 'package:flutter/material.dart';

class Expensesitem extends StatelessWidget {
  const Expensesitem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
        child: Column(
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryicons[expense.category]),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(expense.formatteddate)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
