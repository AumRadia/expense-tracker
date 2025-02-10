import 'dart:io';

import 'package:expense/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'expenses.dart';

class Newexpense extends StatefulWidget {
  const Newexpense({super.key, required this.onaddexpense});

  final void Function(Expense expense) onaddexpense;

  @override
  State<Newexpense> createState() => _NewexpenseState();
}

class _NewexpenseState extends State<Newexpense> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime? _selecteddate;

  Category _selectedcatory = Category.food;

  void _presentdatepicker() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);
    final lastdate = now;
    final pickeddate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstdate,
        lastDate: lastdate);
    setState(() {
      _selecteddate = pickeddate;
    });
  }

  void _showdialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text("Invald input"),
                content:
                    const Text("Pleasemake sure to enter a valid parameter"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("Okay"))
                ],
              ));
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invald input"),
                content:
                    const Text("Pleasemake sure to enter a valid parameter"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("Okay"))
                ],
              ));
    }
  }

  void submitexpensedata() {
    final enetredamout = double.tryParse(_amountcontroller.text);
    final amountisinvalid = enetredamout == null || enetredamout <= 0;

    if (_titlecontroller.text.trim().isEmpty ||
        amountisinvalid ||
        _selecteddate == null) {
      _showdialog();
      return;
    }

    widget.onaddexpense(Expense(
        title: _titlecontroller.text,
        date: _selecteddate!,
        amount: enetredamout,
        category: _selectedcatory));
    Navigator.pop(context);
  }

  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardspace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardspace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titlecontroller,
                          maxLength: 50,
                          decoration:
                              const InputDecoration(label: Text('title')),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: TextField(
                          controller: _amountcontroller,
                          keyboardType: TextInputType.number,
                          maxLength: 50,
                          decoration:
                              const InputDecoration(label: Text('Amount')),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  )
                else
                  TextField(
                    controller: _titlecontroller,
                    maxLength: 50,
                    decoration: const InputDecoration(label: Text('title')),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedcatory,
                          items: Category.values
                              .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase())))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedcatory = value;
                            });
                          }),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('cancel')),
                      ElevatedButton(
                          onPressed: submitexpensedata,
                          child: const Text("Save")),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(_selecteddate == null
                                ? 'No date selected'
                                : formatter.format(_selecteddate!)),
                            IconButton(
                                onPressed: _presentdatepicker,
                                icon: const Icon(Icons.date_range))
                          ],
                        ),
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountcontroller,
                          keyboardType: TextInputType.number,
                          maxLength: 50,
                          decoration:
                              const InputDecoration(label: Text('Amount')),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(_selecteddate == null
                                ? 'No date selected'
                                : formatter.format(_selecteddate!)),
                            IconButton(
                                onPressed: _presentdatepicker,
                                icon: const Icon(Icons.date_range))
                          ],
                        ),
                      )
                    ],
                  ),
                const SizedBox(height: 20),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('cancel')),
                      ElevatedButton(
                          onPressed: submitexpensedata,
                          child: const Text("Save"))
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedcatory,
                          items: Category.values
                              .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase())))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedcatory = value;
                            });
                          }),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('cancel')),
                      ElevatedButton(
                          onPressed: submitexpensedata,
                          child: const Text("Save"))
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountcontroller,
                        keyboardType: TextInputType.number,
                        maxLength: 50,
                        decoration:
                            const InputDecoration(label: Text('Amount')),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(_selecteddate == null
                              ? 'No date selected'
                              : formatter.format(_selecteddate!)),
                          IconButton(
                              onPressed: _presentdatepicker,
                              icon: const Icon(Icons.date_range))
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    DropdownButton(
                        value: _selectedcatory,
                        items: Category.values
                            .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase())))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedcatory = value;
                          });
                        }),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('cancel')),
                    ElevatedButton(
                        onPressed: submitexpensedata, child: const Text("Save"))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
