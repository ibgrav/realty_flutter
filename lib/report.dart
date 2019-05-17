import 'package:flutter/material.dart';
import './glob.dart' as glob;
import './main.dart' as main;

class ReportsPage extends StatefulWidget {
  ReportsPage({Key key}) : super(key: key);

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  FloatingActionButton actionButton = FloatingActionButton(
    onPressed: () {
      // Add your onPressed code here!
    },
    child: Icon(Icons.add_circle_outline),
    backgroundColor: Colors.pink,
  );

  @override
  Widget build(BuildContext context) {
    return main.mainLayout(context, 'Reports', 'back', actionButton, Text('hey'));
  }
}
