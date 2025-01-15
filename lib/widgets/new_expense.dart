import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            // keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              label: Text('Title'),
            ),
          ),
        ],
      ),);
  }
}
