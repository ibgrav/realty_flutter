import 'dart:convert';
import 'package:flutter/material.dart';

import './glob.dart' as glob;
import './auth.dart' as auth;

void main() async {
  var user = await auth.auth.currentUser();

  if (user != null) {
    print(user.uid);
    glob.uid = user.uid;
    await glob.readCredentials();
  } else {
    print('not logged in');
    glob.uid = '';
    await glob.readCredentials();
  }
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Realty'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.supervised_user_circle),
              onPressed: () async {
                if(glob.uid == '') glob.pushMember(context, auth.SignInPage());
                else await auth.logout();
              },
            ),
          ],
      ),
      body: Center(
        child: Text("Welcome " + glob.uid),
      ),
    );
  }
}