import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/expense.dart';
import 'package:flutter_expense_tracker/widgets/expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Flutter Course",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Cinema",
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    // first context is a generic context with metadata information for this
    // state widget like other widgets position etc....
    // second context(ctx) is the context of the own modal bottom sheet
    // so, the two context are different
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const Text('Modal Bottom Sheet'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          const Text('Chart is here!'),
          // expanded to fix the problem of a list(listview) inside another
          // list(column)
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses),
          ),
        ],
      ),
    );
  }
}
