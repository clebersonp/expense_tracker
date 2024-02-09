import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/expense.dart';
import 'package:flutter_expense_tracker/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.onRemovedExpense,
    required this.expenses,
  });

  final void Function(Expense expense) onRemovedExpense;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.4),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal / 2,
          ),
        ),
        key: ValueKey(expenses[index]),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => onRemovedExpense(expenses[index]),
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
