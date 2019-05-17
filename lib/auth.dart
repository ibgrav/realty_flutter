import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './glob.dart' as glob;

final FirebaseAuth auth = FirebaseAuth.instance;

bool authenticated;

logout() async {
  await FirebaseAuth.instance.signOut();
  print('logout - authenticated: ' + authenticated.toString());
}

class LoginPopUp extends StatefulWidget {
  LoginPopUp({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPopUpState();
}

class LoginPopUpState extends State<LoginPopUp>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: glob.loginEmail);
  final TextEditingController _passwordController =
      TextEditingController(text: glob.loginPass);

  bool _isLoading = false;
  bool _login = false;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 0));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.linear);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: _emailController,
      obscureText: false,
      style: glob.subHeadStyle('dark'),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0))),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
    );

    final passwordField = TextFormField(
      controller: _passwordController,
      obscureText: true,
      style: glob.subHeadStyle('dark'),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0))),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
    );

    final loginButton = Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(6.0),
      color: Color(0xFF5C748A),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            setState(() {
              _isLoading = true;
            });

            await _signInWithEmailAndPassword();

            print("_login");
            print(_login);
          }
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: glob.subHeadStyle('light'),
        ),
      ),
    );

    final createAccountButton = Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(6.0),
      color: Color(0xFF844D4D),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            setState(() {
              _isLoading = true;
            });

            await _register();

            print("_login");
            print(_login);
          }
        },
        child: Text(
          "Create Account",
          textAlign: TextAlign.center,
          style: glob.subHeadStyle('light'),
        ),
      ),
    );

    final credentialsForm = Form(
      key: _formKey,
      child: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              emailField,
              passwordField,
              loginButton,
              createAccountButton,
            ],
          ),
        ),
      ),
    );

    return _isLoading
        ? Center()//Center(child: CircularProgressIndicator())
        : Center(
            child: Material(
              color: Colors.transparent,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: Container(
                  height: glob.height(context, 0.5),
                  width: glob.width(context, 0.85),
                  decoration: ShapeDecoration(
                      color: Color(0xFFEFEFEF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: credentialsForm),
                ),
              ),
            ),
          );
  }

  Future _signInWithEmailAndPassword() async {
    final FirebaseUser user = await auth
        .signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )
        .catchError((error) {
      print(error);
    });

    if (user != null) {
      print(user);
      if (!user.isEmailVerified) user.sendEmailVerification();

      await glob.saveCredentials(
          _emailController.text, _passwordController.text);

      await glob.userDataFileCheck(user.uid);

      setState(() {
        Navigator.pop(context);
        _login = true;
        _isLoading = false;
      });
    } else {
      setState(() {
        _login = false;
        _isLoading = false;
      });
    }
  }

  Future _register() async {
    final FirebaseUser user = await auth
        .createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )
        .catchError((error) {
      print(error);
    });

    if (user != null) {
      print(user);

      await glob.saveCredentials(
          _emailController.text, _passwordController.text);

      await glob.save(user.uid, glob.createNewData());
      await glob.userDataCloudSave(user.uid);

      setState(() {
        Navigator.pop(context);
        _login = true;
        _isLoading = false;
      });
    } else {
      setState(() {
        _login = false;
        _isLoading = false;
      });
    }
  }
}

class SettingsPopUp extends StatefulWidget {
  SettingsPopUp({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingsPopUpState();
}

class SettingsPopUpState extends State<SettingsPopUp>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 0));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.linear);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final logoutButton = Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(6.0),
      color: Color(0xFF5C748A),
      child: MaterialButton(
        height: 40,
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });

          await logout();

          setState(() {
            Navigator.pop(context);
            _isLoading = false;
          });
        },
        child: Text(
          "Logout",
          textAlign: TextAlign.center,
          style: glob.subHeadStyle('light'),
        ),
      ),
    );

    return _isLoading
        ? Center()//Center(child: CircularProgressIndicator())
        : Center(
            child: Material(
              color: Colors.transparent,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: Container(
                  height: glob.height(context, 0.5),
                  width: glob.width(context, 0.85),
                  decoration: ShapeDecoration(
                      color: Color(0xFFEFEFEF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: logoutButton),
                ),
              ),
            ),
          );
  }
}
