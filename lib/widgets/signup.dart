

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:software_project/services/validate.dart';
import 'package:software_project/Database/database.dart';
import 'homepage.dart';
import 'log_in.dart';



class MySignupPage extends StatefulWidget {
  const MySignupPage({Key? key}) : super(key: key);





  @override
  State<MySignupPage> createState() => _MySignupPageState();
}

class _MySignupPageState extends State<MySignupPage> {
  final setMessage = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  late Validate validate = Validate();
  late Storage storage = Storage();



  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController passWord = TextEditingController();
    TextEditingController name = TextEditingController();
    return Scaffold(
        body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Sign up',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
            Padding(
              padding:  const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: email,
                validator: validate.validateEmail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),

            Padding(
              padding:  const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nickname',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passWord,
                validator: validate.validatePassWord,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),



            ElevatedButton(
                  onPressed: () async {
                    if(email.text.isNotEmpty && passWord.text.isNotEmpty ){
                      setMessage.collection('users').doc().set({
                        "emailUser":email.text.trim(),
                        "name": name.text.trim(),

                      });
                    }
                  if(_formKey.currentState!.validate()) {
                    User? users = await storage.createUserUsingEmailPassword(
                        email: email.text,
                        password: passWord.text,
                        context: context);
                    if(users != null ){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Homepage()),
                      );
                    }
                  }
                  },
                  child: const Text('Sign-up'),
                ),


                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => const MyLoginPage()),
                    );
                  },
                  child: const Text('Login'),
                ),





              ],
            )
        )





    );
  }
}
