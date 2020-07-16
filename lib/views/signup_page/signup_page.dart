import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app_flutter/resource/colors.dart';
import 'package:shopping_app_flutter/views/content_page/content_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GoogleSignIn _googleSignIn;
  SharedPreferences _sharedPreferences;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  bool isSignin = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  FlutterToast flutterToast;

  @override
  void initState() {
    super.initState();
    flutterToast = FlutterToast(context);
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }
  Widget toastSuccess = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check),
        SizedBox(
          width: 12.0,
        ),
        Text("SignUp was successfully!"),
      ],
    ),
  );

  Widget toastFail = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.redAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.error),
        SizedBox(
          width: 12.0,
        ),
        Text("SignUp failed :("),
      ],
    ),
  );

  void _signupwithEmailPassword() async {
    setState(() {
      isLoading = true;
    });
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: _emailTextController.text, password: _passwordTextController.text)).user;
    if (user != null) {
      setState(() {
        isLoading = false;
        isSignin = true;
      });
      flutterToast.showToast(
          child: toastSuccess,
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(milliseconds: 500));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ContentPage()));
    } else {
      setState(() {
        isLoading = false;
        isSignin = false;
      });
      flutterToast.showToast(
          child: toastFail,
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(milliseconds: 500));
    }
  }
  Future handleSignIn() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;
    if (user != null) {
      final QuerySnapshot querySnapshot = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: user.uid)
          .getDocuments();
      List<DocumentSnapshot> documents = querySnapshot.documents;

      if (documents.length == 0) {
        Firestore.instance.collection("users").document(user.uid).setData({
          "id": user.uid,
          "username": user.displayName,
          "profilePicture": user.photoUrl
        });
        await _sharedPreferences.setString("id", user.uid);
        await _sharedPreferences.setString("username", user.displayName);
        await _sharedPreferences.setString("profilePicture", user.photoUrl);
      } else {
        await _sharedPreferences.setString("id", documents[0]["id"]);
        await _sharedPreferences.setString("username", documents[0]["username"]);
        await _sharedPreferences.setString(
            "profilePicture", documents[0]["profilePicture"]);
      }
      flutterToast.showToast(
          child: toastSuccess,
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(milliseconds: 500));
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ContentPage()));
    } else {
      flutterToast.showToast(
          child: toastFail,
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(milliseconds: 500));
    }
  }

  Widget formWidget() {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          _usernameWidget(),
          _passwordWidget(),
          _buttonSignUp(),
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
          _signinWithGoogleWidget(),
        ],
      ),
    );
  }

  Widget _usernameWidget() {
    return Padding(
      padding:
      const EdgeInsets.only(left: 15.0, top: 8.0, right: 15.0, bottom: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white.withOpacity(0.4),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: TextFormField(
            controller: _emailTextController,
            decoration: InputDecoration(
              hintText: "Email",
              icon: Icon(Icons.email),
            ),
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                Pattern pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regex = new RegExp(pattern);
                if (!regex.hasMatch(value))
                  return 'Please make sure your email address is valid';
                else
                  return null;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _passwordWidget() {
    return Padding(
      padding:
      const EdgeInsets.only(left: 15.0, top: 8.0, right: 15.0, bottom: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white.withOpacity(0.4),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: TextFormField(
            controller: _passwordTextController,
            decoration: InputDecoration(
              hintText: "Password",
              icon: Icon(Icons.lock_outline),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "The password field cannot be empty";
              } else if (value.length < 6) {
                return "The password has to be at least 6 characters long";
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  Widget _buttonSignUp() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
          borderRadius: BorderRadius.circular(20.0),
          color: mainColor,
          elevation: 0.0,
          child: MaterialButton(
            onPressed: () async {
              if(_formKey.currentState.validate()) {
                _signupwithEmailPassword();
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

  Widget _signinWithGoogleWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Material(
            borderRadius: BorderRadius.circular(10.0),
            color: mainColor,
            elevation: 0.0,
            child: MaterialButton(
              onPressed: () {
                handleSignIn();
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
    double height = MediaQuery.of(context).size.height / 3;
    return Scaffold(
      body:Stack(
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
                child: formWidget(),
              ),
            ),
          ),
          Visibility(
            visible: isLoading ?? true,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
