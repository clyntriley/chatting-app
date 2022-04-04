


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:software_project/widgets/log_in.dart';




class Storage {
  FirebaseAuth auth = FirebaseAuth.instance;
  // login
  Future<User?> loginUsingEmailPassword(
      {required String email, required String password, required BuildContext context}) async {
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "User not Found") {
        print('No User found for that email');
      }
    }
    return user;
  }


  // Sign up
  Future<User?> createUserUsingEmailPassword(
      {required String email, required String password, required BuildContext context}) async {
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        const Text('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        const Text('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

//sign out
  Future<void> signOut(BuildContext context) async {
   try{
     await auth.signOut().then((value) => {
       Navigator.pushAndRemoveUntil(context,
           MaterialPageRoute(builder: (context) => const MyLoginPage()),
       (route) => false)
     });
   } catch (e){
    print("Error");
   }
  }





}


