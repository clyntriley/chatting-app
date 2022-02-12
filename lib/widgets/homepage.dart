import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {

  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Homepage>{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: (
        Text('Homepage')
        ),
      ),

    );

  }

}
