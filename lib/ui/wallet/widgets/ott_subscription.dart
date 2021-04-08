import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iat_nigeria/services/iat/models/iat_data.dart';
import 'package:intl/intl.dart';

class OttSubscription extends StatefulWidget {
  final IatData iatSubscription;

  const OttSubscription({Key key, this.iatSubscription}) : super(key: key);

  @override
  _OttSubscriptionState createState() => _OttSubscriptionState();
}

class _OttSubscriptionState extends State<OttSubscription> {
  IatData iat;

  @override
  void initState() {
    super.initState();
    //currency();
    setState(() {
      iat = widget.iatSubscription;
    });
  }

  _date() {
    if (iat != null) {
      DateTime dateTimeCreatedAt = DateTime.parse(iat.expireAt);
      DateTime dateTimeNow = DateTime.now();
      final differenceInDays = dateTimeNow.difference(dateTimeCreatedAt).inDays;

      print('Difference in adys: $differenceInDays');
      return differenceInDays;
      //print('$differenceInDays');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.all(Radius.circular(18))),
            child: Icon(
              Icons.public,
              color: Colors.lightBlue[900],
            ),
            padding: EdgeInsets.all(12),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  iat != null ? iat.contact.toString() : "Expense",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[900]),
                ),
                Text(
                  iat != null ? DateFormat('yyyy-MM-dd - kk:mm').format(DateTime.parse(iat.expireAt)) : "Narrative",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                iat != null ? _date().abs().toString()+" Days" : "Days",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[500]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
