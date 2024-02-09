import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/expense.dart';
import 'package:flutter_expense_tracker/widgets/chart/chart_bar.dart';
import 'package:flutter_expense_tracker/widgets/chart/chart_icon.dart';
import 'package:flutter_expense_tracker/widgets/chart/chart_total.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return Category.values.map((category) => ExpenseBucket.forCategory(expenses, category)).toList();
  }

  double get greaterExpense {
    double greaterExpense = 0;
    // bucket with greater totalExpense
    for (final bucket in buckets) {
      if (bucket.totalExpenses > greaterExpense) {
        greaterExpense = bucket.totalExpenses;
      }
    }
    return greaterExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: buckets.map((bucket) => ChartTotal(totalExpenses: bucket.totalExpenses)).toList(),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    // to calculate the factor and fill the space with a value between 0 and 1
                    fill: bucket.totalExpenses == 0 ? 0 : bucket.totalExpenses / greaterExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: buckets.map((bucket) => ChartIcon(bucket: bucket)).toList(),
          )
        ],
      ),
    );
  }
}
