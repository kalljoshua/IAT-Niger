import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iat_nigeria/constants/constants.dart';

class ProfileDisplay extends StatefulWidget {
  @override
  _ProfileDisplayState createState() => _ProfileDisplayState();
}

class _ProfileDisplayState extends State<ProfileDisplay> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: _height / 12,
            ),
            CircleAvatar(
              radius: _width < _height ? _width / 4 : _height / 4,
              backgroundImage: AssetImage(profile_holder),
            ),
            SizedBox(
              height: _height / 25.0,
            ),
            Text(
              'Eric Schmidt',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: _width / 15,
                  color: Colors.black),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _height / 30, left: _width / 8, right: _width / 8),
              child: Text(
                'Snowboarder, Superhero and writer.\nSometime I work at google as Executive Chairman ',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: _width / 25,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              height: _height / 30,
              color: Colors.black,
            ),
            Row(
              children: <Widget>[],
            ),

          ],
        ),
      ),
    );
  }
}
