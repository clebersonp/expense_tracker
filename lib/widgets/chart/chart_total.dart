import 'package:flutter/material.dart';

class ChartTotal extends StatelessWidget {
  const ChartTotal({
    super.key,
    required this.totalExpenses,
  });

  final double totalExpenses;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Center(
          child: Text(
            '\$${totalExpenses.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                ),
          ),
        ),
      ),
    );
  }
}
