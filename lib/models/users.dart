
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const USERNAME = 'username';
  static const EMAIL = "email";
  static const ID = 'id';
  static const STRIPE_ID = 'stripeId';
  static const ACTIVE_CARD = 'activeCard';


  String _username;
  String _email;
  String _id;
  String _stripeId;
  String _activeCard;

  String get username => _username;

  String get email => _email;

  String get id => _id;

  String get stripeId => _stripeId;

  String get activeCard => _activeCard;


  UserModel.fromSnapshot(DocumentSnapshot snap){
    _email = snap.data[EMAIL];
    _username = snap.data[USERNAME];
    _id = snap.data[ID];
    _stripeId = snap[STRIPE_ID] ?? null;
    _activeCard = snap[ACTIVE_CARD] ?? null;
  }
}