import 'dart:convert';
import 'package:flutter/material.dart';

import './glob.dart' as glob;
import './auth.dart' as auth;

void main() async {
  await auth.asignUser();

  runApp(MyApp());
}

mainLayout(var context, String title, bool back,
    FloatingActionButton actionButton, Widget bodyPage) {
  Padding backArrow = back
      ? Padding(
          padding: EdgeInsets.only(left: 20),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
        )
      : null;

  return MaterialApp(
    title: 'My Expense Tracker',
    home: Scaffold(
      backgroundColor: Color(0xFF5C748A),
      appBar: AppBar(
        leading: backArrow,
        elevation: 0.0,
        title: Text(
          title,
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
      body: bodyPage,
      floatingActionButton: actionButton,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return mainLayout(context, 'My Expense Tracker', false, null, MyHomePage());
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
              glob.pushMember(context, IncomePage());
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
              glob.pushMember(context, ExpensePage());
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
              glob.pushMember(context, ReportsPage());
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

class IncomePage extends StatefulWidget {
  IncomePage({Key key}) : super(key: key);

  @override
  _IncomePagePageState createState() => _IncomePagePageState();
}

class _IncomePagePageState extends State<IncomePage> {
  String monthDropValue = 'May';
  String yearDropValue = '2019';

  @override
  Widget build(BuildContext context) {
    FloatingActionButton actionButton = FloatingActionButton(
      onPressed: () {
        // Add your onPressed code here!
      },
      child: Icon(Icons.add_circle_outline),
      backgroundColor: Colors.pink,
    );

    return mainLayout(
      context,
      'Income',
      true,
      actionButton,
      Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 40),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DecoratedBox(
                    decoration: glob.boxDec(0xFFEFEFEF),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          elevation: 0,
                          iconSize: 40,
                          style: glob.subHeadStyle('dark'),
                          value: monthDropValue,
                          onChanged: (String newValue) {
                            setState(() {
                              monthDropValue = newValue;
                            });
                          },
                          items: <String>[
                            "Jan",
                            "Feb",
                            "Mar",
                            "Apr",
                            "May",
                            "Jun",
                            "Jul",
                            "Aug",
                            "Sep",
                            "Oct",
                            "Nov",
                            "Dec"
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: DecoratedBox(
                    decoration: glob.boxDec(0xFFEFEFEF),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          elevation: 5,
                          iconSize: 40,
                          style: glob.subHeadStyle('dark'),
                          value: yearDropValue,
                          onChanged: (String newValue) {
                            setState(() {
                              yearDropValue = newValue;
                            });
                          },
                          items: <String>["2018", "2019"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                  padding: const EdgeInsets.all(4.0),
                  mainAxisSpacing: 40.0,
                  crossAxisSpacing: 20.0,
                  scrollDirection: Axis.vertical,
                  children: List.generate(100, (index) {
                    return DecoratedBox(
                      decoration: glob.boxDec(0xFFBDD9C0),
                      child: Text('BOX'),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    return mainLayout(context, 'Expenses', true, actionButton, Text('hey'));
  }
}

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
    return mainLayout(context, 'Reports', true, actionButton, Text('hey'));
  }
}
