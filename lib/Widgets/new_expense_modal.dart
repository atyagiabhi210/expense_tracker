import 'package:flutter/foundation.dart';
import 'package:expense_tracker/Widgets/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expenses.dart';

final formatter = DateFormat.yMd();

class NewExpenseModal extends StatefulWidget {
  const NewExpenseModal({super.key, required this.onAddExpense});
  final void Function(Expenses expenses) onAddExpense;

  @override
  State<NewExpenseModal> createState() {
    return _NewExpenseModalState();
  }
}

class _NewExpenseModalState extends State<NewExpenseModal> {
  var _selectedCategory = Categories.leisure;
  final _titleChangeController = TextEditingController();
  final _expenseAmountController = TextEditingController();
  DateTime? _selectedDate;
  void datePicker() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, initialDate: now, firstDate: first, lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _onSubmitPressed() {
    // try parse converts the string into double if possible else returns null
    final enteredAmount = double.tryParse(_expenseAmountController.text);
    final amountIsValid = enteredAmount == null || enteredAmount <= 0;
    if (_titleChangeController.text.trim().isEmpty ||
        amountIsValid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text('Kindly check all the input values...'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('OKAY'))
                ],
              ));

      return;
    }
    widget.onAddExpense(Expenses(
        title: _titleChangeController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleChangeController.dispose();
    _expenseAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Padding(
      padding: const EdgeInsets.fromLTRB(16,48,16,16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            controller: _titleChangeController,
            decoration:
                const InputDecoration(label: Text('ENTER YOUR EXPENSE')),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _expenseAmountController,
                  maxLength: 20,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      prefixText: 'Rs. ',
                      label: Text('ENTER THE AMOUNT SPENT')),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_selectedDate == null
                      ? 'No Date is Selected'
                      : formatter.format(_selectedDate!)),
                  IconButton(
                      onPressed: datePicker,
                      icon: const Icon(Icons.calendar_month)),
                ],
              ))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Categories.values
                      .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase())))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              ElevatedButton(
                  onPressed: _onSubmitPressed,
                  child: const Text('Save Expense')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'))
            ],
          )
        ],
      ),
    );
  }
}
