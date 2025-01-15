import 'package:cash_track/widgets/expenses_list/expenses_list.dart';
import 'package:cash_track/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(title: "Flutter Course", amount: "200", date: DateTime.now(), category: Category.work),
    Expense(title: "Groceries", amount: "150", date: DateTime.now().subtract(Duration(days: 1)), category: Category.food),
    Expense(title: "Travel", amount: "500", date: DateTime.now().subtract(Duration(days: 3)), category: Category.travel),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("The Chart"),
          Expanded(
            child: 
            ExpensesList(expenses: _registeredExpenses),
            ),
        ],
      ),
    );
  }
}
