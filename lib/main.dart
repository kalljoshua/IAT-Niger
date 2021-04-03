import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iat_nigeria/ui/auth/phone/phone_login.dart';

import 'ui/auth/sign_in/sign_in.dart';

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
      
      home: SignIn(),
      debugShowCheckedModeBanner: false,
    );
  }
}

