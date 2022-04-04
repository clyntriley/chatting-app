import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:software_project/Database/database.dart';

import 'package:software_project/widgets/chatpage.dart';
class Homepage extends StatefulWidget {

  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Homepage>{
  final db = FirebaseFirestore.instance;
  late Storage storage = Storage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
        automaticallyImplyLeading: false,
        actions: [

          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(
                Icons.logout,
              ),
              onPressed: () {


              },
            ),
          ),

        ],
      ),
      body: Center(
        child: Column(
          children: [
        StreamBuilder<QuerySnapshot>(
        stream: db.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              shrinkWrap: true,
                padding: const EdgeInsets.only(left: 10, right: 20),
              children: snapshot.data!.docs.map((document) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyChatPage(),
                    ));
                  },
                  child: Card(
                      child: ListTile(
                        title: Text('Username: ' + document['name']),
                      ),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),




          ],
        ),
      )
      );



  }
}

