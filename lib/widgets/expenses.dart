import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "flutter course",
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "akullore",
        amount: 9.99,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "Hotel Bonita",
        amount: 50.99,
        date: DateTime.now(),
        category: Category.travel),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(
            addExpense: _addExpense,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Expenses Tracker"),
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Column(
          children: [
            Text("The Chart"),
            Expanded(
                child: ExpensesList(
              expenses: _registeredExpenses,
              removeExpense: _removeExpense,
            )),
          ],
        ));
  }
}
