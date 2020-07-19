import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/notifications/snack_bar.dart';
import 'package:shopping_app_flutter/provider/user_provider.dart';
import 'package:shopping_app_flutter/resource/colors.dart';
import 'package:shopping_app_flutter/views/content_page/content_page.dart';
import 'package:shopping_app_flutter/views/signup_page/signup_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app_flutter/views/widget/loading.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  FlutterToast flutterToast;

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
          _passwordWidget(user),
          _buttonLogin(user),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  "Forgot password",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage())),
                    child: Text(
                      "Sign up",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: secondColor,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 18.0),
                    )),
              ),
            ],
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
            controller: user.email,
            decoration: InputDecoration(
              hintText: "Email",
              icon: Icon(Icons.email),
            ),
            // ignore: missing_return
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
          padding: const EdgeInsets.only(left: 12.0),
          child: TextField(
            controller: user.password,
            decoration: InputDecoration(
              hintText: "Password",
              icon: Icon(Icons.lock_outline),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonLogin(UserProvider user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
          borderRadius: BorderRadius.circular(20.0),
          color: mainColor,
          elevation: 0.0,
          child: MaterialButton(
            onPressed: () async {
              if (!await user.signInWithEmailPassword()) {
                flutterToast.showToast(
                    child: ToastFailed(title: 'Login Failed :(',),
                    toastDuration: Duration(milliseconds: 500),
                    gravity: ToastGravity.BOTTOM);
              } else {
                flutterToast.showToast(
                    child: ToastSuccess(title: 'Login was successfully!',),
                    toastDuration: Duration(milliseconds: 500),
                    gravity: ToastGravity.BOTTOM);
                user.clearController();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ContentPage(user: user,)));
              }
            },
            minWidth: MediaQuery.of(context).size.width,
            child: Text(
              "Login",
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
                if (!await user.signInWithGoogle()){
                  flutterToast.showToast(
                      child: ToastFailed(title: 'Login Failed :(',),
                      toastDuration: Duration(milliseconds: 500),
                      gravity: ToastGravity.BOTTOM);
                } else {
                  flutterToast.showToast(
                      child: ToastSuccess(title: 'Login was successfully!',),
                      toastDuration: Duration(milliseconds: 500),
                      gravity: ToastGravity.BOTTOM);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ContentPage(user: user,)));
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
      key: _key,
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
