import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/expense.dart';

class ChartIcon extends StatelessWidget {
  const ChartIcon({super.key, required this.bucket});

  final ExpenseBucket bucket;

  @override
  Widget build(BuildContext context) {
    var isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
      child: Icon(
        bucket.categoryIconData,
        color: isDarkMode
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.primary.withOpacity(0.7),
      ),
    );
  }
}
