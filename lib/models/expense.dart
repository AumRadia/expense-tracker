import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryicons = {
  Category.food: Icons.local_pizza_sharp,
  Category.travel: Icons.airplane_ticket_sharp,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  Expense(
      {required this.title,
      required this.date,
      required this.amount,
      required this.category})
      : id = uuid.v4();

  final String title;
  final String id;
  final DateTime date;
  final double amount;
  final Category category;

  String get formatteddate {
    return formatter.format(date);
  }
}

class Expensebucket {
  const Expensebucket({required this.category, required this.expenses});

  Expensebucket.forcategory(List<Expense> allexpense, this.category)
      : expenses = allexpense
            .where((expense) => expense.category == category)
            .toList();
  final Category category;
  final List<Expense> expenses;

  double get totalexpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum; // Moved the return statement outside the loop
  }
}
