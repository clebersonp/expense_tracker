import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/expense.dart';
import 'package:flutter_expense_tracker/widgets/chart/chart.dart';
import 'package:flutter_expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter_expense_tracker/widgets/new_expense.dart';

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
  final List<Expense> _registeredExpenses = [];

  void _addExpense(Expense expense) {
    setState(() => _registeredExpenses.add(expense));
  }

  void _removeExpense(Expense expense) {
    var index = _registeredExpenses.indexOf(expense);
    print('Removing expense: $expense');
    setState(() => _registeredExpenses.remove(expense));
    // clear all snackbars before show up the new one
    ScaffoldMessenger.of(context).clearSnackBars();
    // show new snackbar with undo action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.all(12),
        duration: const Duration(seconds: 3),
        content: const Text('Removed Expense!'),
        action: SnackBarAction(
          label: 'Undo',
          // insert the expense into the same list position before
          onPressed: () => setState(() {
            print('Undo removed expense: $expense');
            _registeredExpenses.insert(index, expense);
          }),
        ),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    // first context is a generic context with metadata information for this
    // state widget like other widgets position etc....
    // second context(ctx) is the context of the own modal bottom sheet
    // so, the two context are different
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget chartContent = const Text('');
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        onRemovedExpense: _removeExpense,
        expenses: _registeredExpenses,
      );
      chartContent = Chart(expenses: _registeredExpenses);
    }

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
          chartContent,
          // expanded to fix the problem of a list(listview) inside another
          // list(column)
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
