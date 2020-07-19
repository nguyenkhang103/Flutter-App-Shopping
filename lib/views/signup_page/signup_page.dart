import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app_flutter/notifications/snack_bar.dart';
import 'package:shopping_app_flutter/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/resource/colors.dart';
import 'package:shopping_app_flutter/views/content_page/content_page.dart';
import 'package:shopping_app_flutter/views/login_page/login_page.dart';
import 'package:shopping_app_flutter/views/widget/loading.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  FlutterToast flutterToast;
  bool hidePass = true;

  @override
  void initState() {
    super.initState();
    flutterToast = FlutterToast(context);
  }

  Widget formWidget(UserProvider user) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          _usernameWidget(user),
          _emailWidget(user),
          _passwordWidget(user),
          _buttonSignUp(user),
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  "Sign in",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: secondColor,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 18.0),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(
                      color: Colors.white,
                      height: 36,
                    )),
              ),
              Text(
                "OR",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Divider(
                      color: Colors.white,
                      height: 36,
                    )),
              ),
            ]),
          ),
          _signInWithGoogleWidget(user),
        ],
      ),
    );
  }

  Widget _usernameWidget(UserProvider user) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, top: 8.0, right: 15.0, bottom: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white.withOpacity(0.4),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: TextField(
            controller: user.name,
            decoration: InputDecoration(
              hintText: "Username",
              icon: Icon(
                Icons.person_outline,
              ),
              border: InputBorder.none,
            ),
            // ignore: missing_return
          ),
        ),
      ),
    );
  }

  Widget _emailWidget(UserProvider user) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, top: 8.0, right: 15.0, bottom: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white.withOpacity(0.4),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: TextField(
            controller: user.email,
            decoration: InputDecoration(
              hintText: "Email",
              icon: Icon(Icons.email),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordWidget(UserProvider user) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, top: 8.0, right: 15.0, bottom: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white.withOpacity(0.4),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: ListTile(
              title: TextField(
                controller: user.password,
                obscureText: hidePass,
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(Icons.lock_outline),
                  border: InputBorder.none,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.remove_red_eye),
                onPressed: () {
                  setState(() {
                    hidePass = !hidePass;
                  });
                },
              )),
        ),
      ),
    );
  }

  Widget _buttonSignUp(UserProvider user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
          borderRadius: BorderRadius.circular(20.0),
          color: mainColor,
          elevation: 0.0,
          child: MaterialButton(
            onPressed: () async {
              if (!await user.signUp()) {
                flutterToast.showToast(
                    child: ToastFailed(
                      title: 'Sign Up Failed :(',
                    ),
                    gravity: ToastGravity.BOTTOM,
                    toastDuration: Duration(milliseconds: 500));
              } else {
                user.clearController();
                flutterToast.showToast(
                    child: ToastSuccess(
                      title: 'Sign Up Successfully!',
                    ),
                    toastDuration: Duration(milliseconds: 500),
                    gravity: ToastGravity.BOTTOM);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContentPage(
                              user: user,
                            )));
              }
            },
            minWidth: MediaQuery.of(context).size.width,
            child: Text(
              "Sign up",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          )),
    );
  }

  Widget _signInWithGoogleWidget(UserProvider user) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Material(
            borderRadius: BorderRadius.circular(10.0),
            color: mainColor,
            elevation: 0.0,
            child: MaterialButton(
              onPressed: () async {
                if (!await user.signInWithGoogle()) {
                  flutterToast.showToast(
                      child: ToastFailed(title: 'Login failed :(',),
                      toastDuration: Duration(milliseconds: 500),
                      gravity: ToastGravity.BOTTOM);
                } else {
                  flutterToast.showToast(
                      child: ToastSuccess(title: 'Login Successfully!',),
                      toastDuration: Duration(milliseconds: 500),
                      gravity: ToastGravity.BOTTOM);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContentPage(
                                user: user,
                              )));
                }
              },
              minWidth: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                      'assets/icons/google.png',
                      color: Colors.white,
                      width: 30.0,
                      height: 30.0,
                    ),
                  ),
                  Text(
                    " Google",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 22.0),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      body: user.status == Status.Authenticating
          ? LoadingWidget()
          : Stack(
              children: <Widget>[
                Image.asset(
                  'assets/img/background.jpg',
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Container(
                  color: Colors.black.withOpacity(0.4),
                  width: double.infinity,
                  height: double.infinity,
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/icons/lg.png',
                    width: 280.0,
                    height: 240.0,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 200.0),
                    child: Center(
                      child: formWidget(user),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
