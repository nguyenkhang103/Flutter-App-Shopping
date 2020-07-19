import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app_flutter/models/card.dart';
import 'package:shopping_app_flutter/models/users.dart';
import 'package:shopping_app_flutter/services/card_service.dart';
import 'package:shopping_app_flutter/services/user_service.dart';
//import 'package:mastering_payments/models/cards.dart';
//import 'package:mastering_payments/models/purchase.dart';
//import 'package:mastering_payments/services/cards.dart';
//import 'package:mastering_payments/services/purchases.dart';
//import 'package:mastering_payments/services/user.dart';
enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  SharedPreferences sharedPreferences;
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;

  Status get status => _status;

  FirebaseUser get user => _user;
  Firestore _firestore = Firestore.instance;
  UserModel _userModel;
  List<CardModel> cards = [];
//  List<PurchaseModel> purchaseHistory = [];
  UserService _userService = UserService();
  CardServices _cardServices  = CardServices();
//  PurchaseServices _purchaseServices = PurchaseServices();
  final formKey = GlobalKey<FormState>();

//  getter
  UserModel get userModel => _userModel;
  bool hasStripeId = true;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();


  UserProvider.initialize() : _auth = FirebaseAuth.instance{
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }
  Future<bool> signInWithEmailPassword()async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      _status = Status.Authenticating;
      notifyListeners();
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final AuthResult authResult = await _auth.signInWithCredential(
          credential);
      FirebaseUser user = authResult.user;
      final QuerySnapshot querySnapshot = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: user.uid)
          .getDocuments();
      List<DocumentSnapshot> documents = querySnapshot.documents;

      if (documents.length == 0) {
        Firestore.instance.collection("users").document(user.uid).setData({
          "id": user.uid,
          "username": user.displayName,
          "email": user.email
        });
        await sharedPreferences.setString("id", user.uid);
        await sharedPreferences.setString("username", user.displayName);
        await sharedPreferences.setString("email", user.email);
      } else {
        await sharedPreferences.setString("id", documents[0]["id"]);
        await sharedPreferences.setString("username", documents[0]["username"]);
        await sharedPreferences.setString(
            "email", documents[0]["email"]);
      }
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  void hasCard(){
    hasStripeId = !hasStripeId;
    notifyListeners();
  }

  Future<void> loadCardsAndPurchase({String userId})async{
    cards = await _cardServices.getCards(userId: userId);
//    purchaseHistory = await _purchaseServices.getPurchaseHistory(userId: userId);
  }


  Future<bool> signUp()async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((result){
        _firestore.collection('users').document(result.user.uid).setData({
          "id": result.user.uid,
          "username": name.text,
          "email": email.text
        });
      });
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut()async{
    await _auth.signOut();
    await _googleSignIn.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController(){
    name.text = "";
    password.text = "";
    email.text = "";
  }

  Future<void> _onStateChanged(FirebaseUser user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _status = Status.Authenticated;
      _userModel = await _userService.getUserById(user.uid);
      if (_userModel.stripeId == null) {
        hasStripeId = false;
        notifyListeners();
      }
      print(_userModel.username);
      print(_userModel.email);
      print(_userModel.stripeId);
    }
    notifyListeners();
  }
}