import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iat_nigeria/ui/auth/phone_login.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(StartApp());
}

class StartApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IAT Nigeria',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

