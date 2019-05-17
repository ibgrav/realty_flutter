import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './glob.dart' as glob;
import './auth.dart' as auth;
import './home_box.dart' as hBox;
import './income.dart' as income;
import './expense.dart' as expense;
import './report.dart' as report;

void main() async {
  await glob.readCredentials();
  runApp(MyApp());
}

mainLayout(var context, String title, String iconType,
    FloatingActionButton actionButton, Widget bodyPage) {
  Padding topIcon;
  if (iconType == 'back')
    topIcon = Padding(
      padding: EdgeInsets.only(left: 20),
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context, false),
      ),
    );

  return MaterialApp(
    title: 'My Expense Tracker',
    home: Scaffold(
      backgroundColor: Color(0xFF5C748A),
      // drawer: mainDrawer(context),
      appBar: AppBar(
        leading: topIcon,
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return mainLayout(
        context, 'My Expense Tracker', 'settings', null, MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var user;

  @override
  void initState() {
    super.initState();
    _showLoginBox();
  }

  _setUser() async {
    var checkUser = await auth.auth.currentUser();
    if (checkUser != null && glob.userData == '') {
      await glob.userDataFileCheck(checkUser.uid);
    }
    setState(() {
      user = checkUser;
      print(user);
    });
  }

  _showLoginBox() async {
    await _setUser();
    if (user == null) {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => auth.LoginPopUp(),
      );
      await _setUser();
    }
  }

  _showSettingsBox() async {
    await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) => auth.SettingsPopUp(),
    );
    await _showLoginBox();
  }

  @override
  Widget build(BuildContext context) {
    return (user != null)
        ? SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                GestureDetector(
                    child: Icon(Icons.settings, color: Color(0xFFEFEFEF)),
                    onTap: () async {
                      await _showSettingsBox();
                    }),
                Text(
                  'Welcome \n' + user.email.toString(),
                  style: glob.subHeadStyle('light'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    glob.pushMember(context, income.IncomePage());
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    width: glob.width(context, 0.75),
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: glob.boxDec(0xFFBDD9C0),
                    child: hBox.homeBox('Income', 0xFFBDD9C0, hBox.incomeBox()),
                  ),
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    glob.pushMember(context, expense.ExpensePage());
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    width: glob.width(context, 0.75),
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: glob.boxDec(0xFFE7D0D0),
                    child:
                        hBox.homeBox('Expenses', 0xFFE7D0D0, hBox.expenseBox()),
                  ),
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    glob.pushMember(context, report.ReportsPage());
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    width: glob.width(context, 0.75),
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: glob.boxDec(0xFFBCDEF1),
                    child: hBox.homeBox(
                        'Reports', 0xFFBCDEF1, hBox.reportBoxClosed()),
                  ),
                ),
                Container(height: 540),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(
            backgroundColor: Color(0xFFEFEFEF),
          ));
  }
}

// Drawer mainDrawer(context) {
//   return new Drawer(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         GestureDetector(
//             child: Container(
//               padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
//               decoration: glob.boxDec(0xFF878987),
//               child: Text(
//                 'Logout',
//                 style: glob.subHeadStyle('light'),
//               ),
//             ),
//             onTap: () async {
//               await auth.logout();
//             }),
//       ],
//     ),
//   );
// }
