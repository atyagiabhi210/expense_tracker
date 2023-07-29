

import 'package:expense_tracker/Widgets/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expenses.dart';
import 'package:expense_tracker/Widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/Widgets/new_expense_modal.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expense> {
  //creating some dummy data
  final List<Expenses> _registeredExpenses = [

  ];
  //this add expense would be executed from newExpenseModel so now we will pass this function as a new property in
  //new expense model class
  void _addExpense(Expenses expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expenses expense) {
    final expenseIndex=_registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      duration:const Duration(seconds: 3),
      content: const Text('You sure you want to delete..?',style: TextStyle(color: Colors.white),),
      action: SnackBarAction(label: 'Undo', onPressed:(){
        setState(() {
          _registeredExpenses.insert(expenseIndex, expense);
        });

      } ),
    ));
  }

  void _openExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpenseModal(
            onAddExpense: _addExpense,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Text('No expenses to show, Kindly add some',style: TextStyle(color: Colors.white),);
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        removeExpense: _removeExpense,
      );
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(1, 8, 9, 10),
      appBar: AppBar(
        title: const Text('EXPENSE TRACKER'),
        actions: [
          IconButton(
              onPressed: _openExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
          children: 
          [Chart(expenses: _registeredExpenses)
            , Expanded(child: mainContent)]),
    );
  }
}
