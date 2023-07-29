import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expenses.dart';
var formatter=DateFormat.yMd();
class ExpenseItem extends StatelessWidget{
  const ExpenseItem({required this.expenses,super.key});
  final Expenses expenses;
  @override
  Widget build(BuildContext context) {
    return

       Card(

         child: Padding(padding: const EdgeInsets.symmetric(
           horizontal: 20,
           vertical: 10
         ),
         child: Column(
           children: [
             Text(expenses.title,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
             Row(
               children: [
                 Text('Rs. ${expenses.amount.toStringAsFixed(2)}',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                 const Spacer(),
                 Row(
                   children: [
                     Icon(categoryIcons[expenses.category]),
                     const SizedBox(
                       width: 20,
                     ),
                     Text(formatter.format(expenses.date),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,))
                   ],
                 )
               ],
             )
           ],
         ),
         ) ,)
        ;

  }
}