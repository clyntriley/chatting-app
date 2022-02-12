

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:software_project/widgets/signup.dart';

import 'homepage.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key, }) : super(key: key);




  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {

  final _formKey = GlobalKey<FormState>();


  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e){
      if (e.code == "User not Found") {
        const Text('No User found for that email');
      }
    }
    return user;
  }

  String? validateEmail(String? email){
    if (email == null || email.isEmpty){
      return 'Please Enter a Email';
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
    TextEditingController userName = TextEditingController();
    TextEditingController passWord = TextEditingController();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Login',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  controller: userName,
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





            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    User? user = await loginUsingEmailPassword(email: userName.text, password: passWord.text, context: context);
                    print(user);
                  if(user != null ){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Homepage()),
                    );
                  }
                  }

                  },
                child: const Text('Login'),


              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MySignupPage()),
                );
              },
              child: const Text('Sign-up'),
            ),




          ],
        ),
      ),





    );
  }
}



