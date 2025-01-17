import 'package:cash_track/widgets/expenses_list/expenses_list.dart';
import 'package:cash_track/models/expense.dart';
import 'package:cash_track/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Flutter Course",
        amount: 200,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "Groceries",
        amount: 150,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "Travel",
        amount: 500,
        date: DateTime.now(),
        category: Category.travel),
  ];



  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text("Flutter ExpenseTracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon:const  Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Text("The Chart"),
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses),
          ),
        ],
      ),
    );
  }
}
