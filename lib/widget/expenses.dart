import 'package:expense/models/expense.dart';
import 'package:expense/widget/chart/chart.dart';
import 'new_expense.dart';
import 'package:flutter/material.dart';
import 'expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredexpenses = [];

  void _openaddexpenseoverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        builder: (ctx) => Newexpense(onaddexpense: _addexpense));
  }

  void _addexpense(Expense expense) {
    setState(() {
      _registeredexpenses.add(expense);
    });
  }

  void _removeexpnse(Expense expnese) {
    final expenseindex = _registeredexpenses.indexOf(expnese);
    setState(() {
      _registeredexpenses.remove(expnese);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense deleted"),
        action: SnackBarAction(
            label: 'undo',
            onPressed: () {
              setState(() {
                _registeredexpenses.insert(expenseindex, expnese);
              });
            })));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //  MediaQuery.of(context).size.height;
    Widget maincontent = const Center(child: Text("No entries found"));

    if (_registeredexpenses.isNotEmpty) {
      maincontent = Expenseslist(
        expenses: _registeredexpenses,
        onremoveexpense: _removeexpnse,
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expense tracker App'),
          actions: [
            IconButton(
                onPressed: _openaddexpenseoverlay, icon: const Icon(Icons.add))
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredexpenses),
                  Expanded(child: maincontent)
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredexpenses)),
                  Expanded(child: maincontent)
                ],
              ));
  }
}
