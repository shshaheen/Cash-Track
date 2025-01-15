import 'package:flutter/material.dart';
import 'package:cash_track/models/expense.dart';
class ExpensesItem extends StatelessWidget {
  const ExpensesItem({
    super.key, 
  required this.expense
  });

  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(expense.title),
    );
  }
}
