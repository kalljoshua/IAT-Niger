import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iat_nigeria/constants/constants.dart';
import 'package:iat_nigeria/services/transactions/models/last_transaction_data.dart';
import 'package:iat_nigeria/ui/widgets/widget.dart';

class TransactionData extends StatefulWidget {
  final PaymentsData trans;

  const TransactionData({Key key, this.trans}) : super(key: key);
  @override
  _TransactionDataState createState() => _TransactionDataState();
}

class _TransactionDataState extends State<TransactionData> {
  PaymentsData transaction;
  @override
  void initState() {
    super.initState();
    setState(() {
      transaction = widget.trans;
    });
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
              Icons.phone_android_sharp,
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
                  transaction.paymentMethod != null
                      ? '${transaction.paymentMethod}'
                      : "Type",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[900]),
                ),
                Text(
                  transaction.message != null
                      ? '${transaction.message}'
                      : "Narative",
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
                transaction.amount != null
                    ? "\N " + format.format(transaction.amount.abs()).toString()
                    : "N 00.0",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.lightGreen),
              ),
              Text(
                parseHumanDateTime(transaction.paymentDate),
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
