import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iat_nigeria/session/session_storage.dart';
import 'package:iat_nigeria/ui/auth/phone/phone_login.dart';
import 'package:iat_nigeria/ui/wallet/wallet_index.dart';

import 'ui/auth/sign_in/sign_in.dart';


Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(StartApp());
}

class StartApp extends StatefulWidget {

  @override
  _StartAppState createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    navigationToNextPage();
  }

  Future<void> navigationToNextPage() async {
    SessionStorage sessionStorage = new SessionStorage();
    var isLoggedIn = await sessionStorage.loginStatus();
    if (isLoggedIn) {
      setState(() {
        _isLoggedIn = true;
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IAT Nigeria',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
      home: _isLoggedIn
        ? WalletIndex()
        : LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

