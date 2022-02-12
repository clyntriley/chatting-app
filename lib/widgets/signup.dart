import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';
import 'log_in.dart';



class MySignupPage extends StatefulWidget {
  const MySignupPage({Key? key}) : super(key: key);





  @override
  State<MySignupPage> createState() => _MySignupPageState();
}

class _MySignupPageState extends State<MySignupPage> {


  final _formKey = GlobalKey<FormState>();


  static Future<User?> createUserUsingEmailPassword({required String email, required String password, required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
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

  String? validateEmail(String? email){
    if (email == null || email.isEmpty){
      return 'Please Enter a  Valid Email';
    }
    String pattern = r'\w+@\w+\.\w+';
    RegExp regex =RegExp(pattern);
    if (!regex.hasMatch((email))) {
      return 'Invalid Email Address';
    }
    return null;
  }

  String? validatePassWord(String? password){
    if (password == null || password.isEmpty){
      return 'Please Enter a Password';
    }
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(password)) {
      return '''
      Password must be at least 8 characters,
      include an uppercase letter, number and symbol.
      ''';
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController passWord = TextEditingController();
    return Scaffold(
        body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Sign up',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Padding(
              padding:  const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: email,
                validator: validateEmail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passWord,
                validator: validatePassWord,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),



            ElevatedButton(
                  onPressed: () async {
                  if(_formKey.currentState!.validate()) {
                    User? user = await createUserUsingEmailPassword(
                        email: email.text,
                        password: passWord.text,
                        context: context);
                    print(user);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Homepage()),
                    );
                  }
                  },
                  child: const Text('Sign-up'),
                ),


                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
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
