import 'package:flutter/material.dart';
import './glob.dart' as glob;
import './main.dart' as main;

class ExpensePage extends StatefulWidget {
  ExpensePage({Key key}) : super(key: key);

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  FloatingActionButton actionButton = FloatingActionButton(
    onPressed: () {
      // Add your onPressed code here!
    },
    child: Icon(Icons.add_circle_outline),
    backgroundColor: Colors.pink,
  );

  @override
  Widget build(BuildContext context) {
    return main.mainLayout(context, 'Expenses', 'back', actionButton, Text('hey'));
  }
}
