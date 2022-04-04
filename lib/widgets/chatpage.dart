import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:software_project/widgets/homepage.dart';
import 'package:software_project/widgets/presentmessages.dart';



class MyChatPage extends StatefulWidget{
  const MyChatPage( {Key? key,}) : super(key: key);

  @override
  State<MyChatPage> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<MyChatPage> {
  final setMessage = FirebaseFirestore.instance;
  var currentAccount = FirebaseAuth.instance.currentUser;
  final db = FirebaseAuth.instance;


getUser(){
  final user = db.currentUser;
  if(user!=null){
    currentAccount = user;
  }
}

@override
  void initState() {
  super.initState();
  getUser();

}



TextEditingController message = TextEditingController();
Homepage title = Homepage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back,color: Colors.black,),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        currentAccount!.email.toString(),
                        style: const TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6,),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Container(
              height: 500,
                child: const SingleChildScrollView( physics:ScrollPhysics(), reverse: true ,child: Messages())),
            Row(
              children: [
                Expanded(child: TextField(
                  controller: message,
                  decoration: const InputDecoration(
                      hintText: 'Enter Message'
                  ),
                )),
                IconButton(onPressed: (){
                  if(message.text.isNotEmpty){
                    setMessage.collection('message').doc().set({
                      "msg":message.text.trim(),
                      "user": currentAccount!.email.toString(),
                    });
                  }
                  message.clear();
                  },
                    icon: const Icon(Icons.send))

              ],
            ),

          ],
        ),
      )
    );
  }
}

