import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // another approach to manage the user input
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime? _selectedDate;

  // default value
  var _selectedCategory = Category.food;

  // when using textEditingController, need to dispose it to clear the value
  // when the widget will be dispose or not showed
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    var now = DateTime.now();
    var initialDate = DateTime(now.year - 1);
    var lastDate = DateTime(now.year + 1);
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: initialDate,
      lastDate: lastDate,
    );

    // this code will executed when pickedDate has any value after await
    // function and update the widget to show up the selected date
    setState(() => _selectedDate = pickedDate);
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final titleIsInvalid = _titleController.text.trim().isEmpty;
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    final dateIsInvalid = _selectedDate == null;
    print('titleIsInvalid: $titleIsInvalid, amountIsInvalid: $amountIsInvalid, dateIsInvalid: $dateIsInvalid');
    if (titleIsInvalid || amountIsInvalid || dateIsInvalid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    // form is valid
    widget.onAddExpense(
      Expense(
        title: _titleController.text.trim(),
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    // after created, close the modal(form)
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 80, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(width: 80),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          _selectedDate == null ? 'No date selected' : formatter.format(_selectedDate!),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month_rounded),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                onChanged: (value) => setState(() => _selectedCategory = value!),
                items: Category.values
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ))
                    .toList(),
              ),
              const Spacer(),
              ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () => _submitExpenseData(),
                child: const Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
