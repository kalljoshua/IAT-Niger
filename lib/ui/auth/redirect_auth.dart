import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RediectAuth extends StatefulWidget {
    final String phone;
  RediectAuth(this.phone);
  @override
  _RediectAuthState createState() => _RediectAuthState();
}

class _RediectAuthState extends State<RediectAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
                child:
                    Text('This number ${widget.phone} is not registered on the network'),
              ),
      ),
    );
  }
}