import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expenses.dart';
import 'package:expense_tracker/Widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses,required this.removeExpense});
  final List<Expenses> expenses;
  final void Function(Expenses expenses) removeExpense;

  @override
  Widget build(BuildContext context) {
    // to create the items of the list on runtime we use ListView.builder method
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction){
            removeExpense(expenses[index]);
          },
            key: ValueKey(expenses[index]),
            child: ExpenseItem(
              expenses: expenses[index],
            )));
  }
}
