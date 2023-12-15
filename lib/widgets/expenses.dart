import 'package:expense_tracker/widgets/chart/chart.dart';
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
    // Expense(
    //     title: "flutter course",
    //     amount: 19.99,
    //     date: DateTime.now(),
    //     category: Category.work),
    // Expense(
    //     title: "akullore",
    //     amount: 9.99,
    //     date: DateTime.now(),
    //     category: Category.food),
    // Expense(
    //     title: "Hotel Bonita",
    //     amount: 50.99,
    //     date: DateTime.now(),
    //     category: Category.travel),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final index = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 2000),
        content: Text("Expense Deleted"),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(index, expense);
              });
            }),
      ),
    );
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
    Widget mainContent = Container(
      margin: EdgeInsets.only(top: 50),
      // color: Colors.pink[50],
      child: const Center(
        child: Text("No expenses found!"),
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = Expanded(
        child: ExpensesList(
          expenses: _registeredExpenses,
          removeExpense: _removeExpense,
        ),
      );
    }

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
        body: Container(
          child: Column(
            children: [
              Chart(expenses: _registeredExpenses),
              mainContent,
            ],
          ),
        ));
  }
}
