import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:software_project/Database/database.dart';

import 'package:software_project/widgets/chatpage.dart';
import 'package:software_project/widgets/log_in.dart';
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
                storage.signOut(context);
              },
            ),
          ),

        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Text("List of Accounts", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
                return Card(
                    child: ListTile(
                      title: Text('Username: ' + document['name']),
                    ),
                );
              }).toList(),
            );
          }
        },
      ),
            ElevatedButton(onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyChatPage(),
                  ));
            }
                , child: const Text("Enter Chat Room"))




          ],
        ),
      )
      );



  }
}

