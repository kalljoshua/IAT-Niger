import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget appBarMain(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    backgroundColor: Color(0xfff44336),
    elevation: 0.0,
    centerTitle: false,
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.red, fontSize: 16);
}

TextStyle simpleTextStyle2() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle userTextStyle() {
  return TextStyle(fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}

Widget connectionError() {
  return Container(
    padding: EdgeInsets.all(16),
    child: Text('Connection Error!!!!'),
  );
}

Widget error(var error) {
  return Container(
    padding: EdgeInsets.all(16),
    child: Text(error.toString()),
  );
}

Widget noData() {
  return Container(
    padding: EdgeInsets.all(16),
    child: Text('No Data Available!'),
  );
}

Widget loading() {
  return Container(
    padding: EdgeInsets.only(top: 16, bottom: 16),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

String parseHumanDateTime(String dateTime) {
  Duration timeAgo = DateTime.now().difference(DateTime.parse(dateTime));
  DateTime theDifference = DateTime.now().subtract(timeAgo);
  return timeago.format(theDifference);
}


