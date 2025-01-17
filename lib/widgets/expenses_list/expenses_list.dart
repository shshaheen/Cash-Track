import 'package:cash_track/models/expense.dart'; 
import 'package:cash_track/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onDismiss, //Function to dismiss the item
  });
  final List<Expense> expenses;
  final Function(Expense) onDismiss; //Function to dismiss the item
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
          //To Dismiss on swap
          key: ValueKey(expenses[index]),
          background: Container(
            color: Theme.of(context).colorScheme.error.withValues(),
            margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),
            ),
          onDismissed: (direction) {
            onDismiss(expenses[index]);
          }, //Function called
          child: ExpensesItem(expense: expenses[index])),
    );
  }
}
