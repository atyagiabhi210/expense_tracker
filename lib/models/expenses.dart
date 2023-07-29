import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

enum Categories { food, travel, leisure, work }

final formatter = DateFormat.yMd();
const categoryIcons = {
  Categories.food: Icons.lunch_dining,
  Categories.travel: Icons.travel_explore,
  Categories.leisure: Icons.tv,
  Categories.work: Icons.work
};

class Expenses {
  Expenses(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categories category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.categories, required this.expenses});
  ExpenseBucket.forCategory(List<Expenses> allExpenses, this.categories)
      : expenses = allExpenses
            .where((expenses) => expenses.category == categories)
            .toList();
  final Categories categories;
  final List<Expenses> expenses;
  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
