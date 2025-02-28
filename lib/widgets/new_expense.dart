// import 'package:cash_track/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:cash_track/models/expense.dart';


class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;
  Category _categoryController = Category.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      //Show Error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
              "Please make sure a valid Title,Amount,Date and Category was entered."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text("Okay"),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _categoryController));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    final titleWidget = TextField(
      controller: _titleController,
      maxLength: 50,
      decoration: const InputDecoration(
        label: Text('Title'),
      ),
    );
    final amountWidget = TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        prefixText: '\$',
        label: Text('Amount'),
      ),
    );
    final categoryWidget = DropdownButton(
      value: _categoryController,
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(
                category.name.toUpperCase(),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) {
          return;
        }
        setState(() {
          _categoryController = value;
        });
      },
    );
    final dateWidget = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _selectedDate == null
              ? "No Date Selected"
              : formatter.format(_selectedDate!),
        ),
        IconButton(
          onPressed: _presentDatePicker,
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );
    final saveWidget = ElevatedButton(
        onPressed: _submitExpenseData, child: Text("Save Expense"));
    final cancelWidget = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("Cancel"),
    );
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            // padding: const EdgeInsets.all(16.0),
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: titleWidget,
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: amountWidget,
                      ),
                    ],
                  )
                else
                  titleWidget,
                if (width >= 600)
                  Row(
                    children: [
                      Expanded(
                        child:categoryWidget,
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: dateWidget,
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: amountWidget
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: dateWidget,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      cancelWidget,
                      saveWidget
                    ],
                  )
                else
                  Row(
                    children: [
                      categoryWidget,
                      const Spacer(),
                      cancelWidget,
                      saveWidget,
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
