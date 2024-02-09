import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, travel, leisure, work, study }

final _categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.photo_camera,
  Category.work: Icons.work,
  Category.study: Icons.school,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }

  IconData? get categoryIconData {
    return _categoryIcons[category];
  }

  @override
  String toString() {
    return 'Expense{id: $id, title: $title, amount: $amount, date: $date, category: $category}';
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  // constructor function, a helper to construct objects
  // : means that some fields will be initialized after :
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses.where((expense) => expense.category == category).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    // sum = expenses.map((expense) => expense.amount).reduce((value, element) => value + element);
    // using for in
    for (var expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
