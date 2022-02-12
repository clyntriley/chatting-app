import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:software_project/widgets/log_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


