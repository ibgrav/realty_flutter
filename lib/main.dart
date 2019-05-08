import 'dart:convert';
import 'package:flutter/material.dart';

import './glob.dart' as glob;
import './auth.dart' as auth;

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Expense Tracker',
      home: MyHomePage(title: 'My Expense Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: glob.height(context, 1),
      width: glob.width(context, 1),
      color: Color(0xFF5C748A),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                child: Material(
                  color: Color(0x00),
                  child: Text('My Expense Tracker',
                      style: glob.headStyle(0xFFefefef)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 40),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Color(0x88888888),
                      offset: new Offset(1, 1),
                      blurRadius: 5,
                    )
                  ],
                  color: Color(0xFFEFEFEF),
                ),
                height: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
