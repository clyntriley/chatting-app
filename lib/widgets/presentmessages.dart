


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('message').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView(
        shrinkWrap: true,
        primary: true,
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.only(left: 10, right: 20),
        children: snapshot.data!.docs.map((document) {
          return Card(
            child: ListTile(
              title: Text(document["msg"]),
              subtitle: Text(document["user"]),
            ),
          );
        }).toList(),
      );
    }
    );

  }
}