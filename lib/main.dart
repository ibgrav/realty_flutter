import 'dart:convert';
import 'package:flutter/material.dart';

import './glob.dart' as glob;
import './auth.dart' as auth;

void main() async {
  await auth.asignUser();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Expense Tracker',
      home: Scaffold(
        backgroundColor: Color(0xFF5C748A),
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            'My Expense Tracker',
            style: glob.headStyle(0xFFEFEFEF),
          ),
          backgroundColor: Color(0xFF5C748A),
          bottom: PreferredSize(
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Container(
                  decoration: glob.boxDec(0xFFEFEFEF),
                  height: 3.0,
                ),
              ),
              preferredSize: Size.fromHeight(3.0)),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool incomeSelected = false;
  bool expenseSelected = false;
  bool reportSelected = false;

  bool authenticated = auth.authenticated ? true : false;

  Widget incomeContent = homeBox('Income', 0xFFBDD9C0, incomeBox());
  Widget expenseContent = homeBox('Expenses', 0xFFE7D0D0, expenseBox());
  Widget reportContent = homeBox('Reports', 0xFFBCDEF1, reportBoxClosed());

  @override
  Widget build(BuildContext context) {
    Widget loginCheck = authenticated
        ? GestureDetector(
            onTap: () async {
              await auth.logout();

              print('loginCheck - authenticated: ' + authenticated.toString());

              setState(() {
                authenticated = auth.authenticated ? true : false;
              });
            },
            child: Container(
              width: glob.width(context, 0.75),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: glob.boxDec(0xFFEFEFEF),
              child: Center(
                child: Material(
                  color: Color(0x00),
                  child: Text('Log Out', style: glob.subHeadStyle('dark')),
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () async {
              await showDialog(
                context: context,
                builder: (_) => auth.LoginPopUp(),
              ).then((val) => setState(() {
                authenticated = auth.authenticated ? true : false;
              }));
            },
            child: Container(
              width: glob.width(context, 0.75),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: glob.boxDec(0xFFEFEFEF),
              child: Center(
                child: Material(
                  color: Color(0x00),
                  child: Text('Log In / Sign Up',
                      style: glob.subHeadStyle('dark')),
                ),
              ),
            ),
          );

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 40),
          loginCheck,
          SizedBox(height: 40),
          GestureDetector(
            onTap: () {
              setState(() {
                incomeSelected = !incomeSelected;
              });

              showDialog(
                context: context,
                builder: (_) => OpenBox(),
              );
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              width: glob.width(context, 0.75),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: glob.boxDec(0xFFBDD9C0),
              child: incomeContent,
            ),
          ),
          SizedBox(height: 40),
          GestureDetector(
            onTap: () {
              setState(() {
                expenseSelected = !expenseSelected;
              });

              showDialog(
                context: context,
                builder: (_) => OpenBox(),
              );
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              width: glob.width(context, 0.75),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: glob.boxDec(0xFFE7D0D0),
              child: expenseContent,
            ),
          ),
          SizedBox(height: 40),
          GestureDetector(
            onTap: () {
              setState(() {
                reportSelected = !reportSelected;
              });

              showDialog(
                context: context,
                builder: (_) => OpenBox(),
              );
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              width: glob.width(context, 0.75),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: glob.boxDec(0xFFBCDEF1),
              child: reportContent,
            ),
          ),
          Container(height: 540),
        ],
      ),
    );
  }
}

List<Widget> incomeBox() {
  List<Widget> columnChildren = [];

  columnChildren.add(Row(
    children: [
      Expanded(
        child: Text(
          'YDT',
          style: glob.subHeadStyle('dark'),
          textAlign: TextAlign.left,
        ),
      ),
      Text(
        '\$ 18,000',
        style: glob.subHeadStyle('dark'),
        textAlign: TextAlign.right,
      ),
    ],
  ));

  columnChildren.add(Container(height: 40));

  return columnChildren;
}

List<Widget> expenseBox() {
  List<Widget> columnChildren = [];

  columnChildren.add(Row(
    children: [
      Expanded(
        child: Text(
          'YDT',
          style: glob.subHeadStyle('dark'),
          textAlign: TextAlign.left,
        ),
      ),
      Text(
        '- \$ 18,000',
        style: glob.subHeadStyle('dark'),
        textAlign: TextAlign.right,
      ),
    ],
  ));

  columnChildren.add(Container(height: 40));

  return columnChildren;
}

List<Widget> reportBoxClosed() {
  List<Widget> columnChildren = [];

  columnChildren.add(Row(
    children: [
      Expanded(
        child: Text(
          'YDT',
          style: glob.subHeadStyle('dark'),
          textAlign: TextAlign.left,
        ),
      ),
      Text(
        '- \$ 18,000',
        style: glob.subHeadStyle('dark'),
        textAlign: TextAlign.right,
      ),
    ],
  ));

  columnChildren.add(Container(height: 40));

  return columnChildren;
}

List<Widget> reportBoxOpen() {
  List<Widget> columnChildren = [];

  columnChildren.add(Row(
    children: [
      Expanded(
        child: Text(
          'YDT',
          style: glob.subHeadStyle('dark'),
          textAlign: TextAlign.left,
        ),
      ),
      Text(
        '- \$ 18,000',
        style: glob.subHeadStyle('dark'),
        textAlign: TextAlign.right,
      ),
    ],
  ));

  columnChildren.add(Container(height: 10));

  columnChildren.add(Row(
    children: [
      Expanded(
        child: Text(
          'YDT',
          style: glob.subHeadStyle('dark'),
          textAlign: TextAlign.left,
        ),
      ),
      Text(
        '- \$ 18,000',
        style: glob.subHeadStyle('dark'),
        textAlign: TextAlign.right,
      ),
    ],
  ));

  columnChildren.add(Container(height: 10));

  columnChildren.add(Row(
    children: [
      Expanded(
        child: Text(
          'YDT',
          style: glob.subHeadStyle('dark'),
          textAlign: TextAlign.left,
        ),
      ),
      Text(
        '- \$ 18,000',
        style: glob.subHeadStyle('dark'),
        textAlign: TextAlign.right,
      ),
    ],
  ));

  columnChildren.add(Container(height: 40));

  return columnChildren;
}

Widget homeBox(title, color, content) {
  return Column(
    children: [
      Text(
        title,
        style: glob.subHeadStyle('dark'),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Color(0xFF425464),
          ),
          height: 3,
        ),
      ),
      Container(height: 20),
      Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: content,
        ),
      ),
    ],
  );
}

class OpenBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OpenBoxState();
}

class OpenBoxState extends State<OpenBox> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0))),
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text("Well hello there!"),
            ),
          ),
        ),
      ),
    );
  }
}
