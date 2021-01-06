import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User user = userCredential.user;
      print(user.displayName);
      return Future.value(user);
    } catch (e) {
      print(e);
    }
  }

  Future<User> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = userCredential.user;
      print(user.displayName);
      return Future.value(user);
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
      return await firebaseAuth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
