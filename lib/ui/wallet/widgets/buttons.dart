import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iat_nigeria/ui/transactions/transactions.dart';

class ButtonsData extends StatefulWidget {
  @override
  _ButtonsDataState createState() => _ButtonsDataState();
}

class _ButtonsDataState extends State<ButtonsData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 50.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => TransactionIndex(),
                        ),
                      );
                    },
                    child: Container(
                      child: Text(
                        "All",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.grey[900]),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                blurRadius: 10.0,
                                spreadRadius: 4.5)
                          ]),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.green,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Deposits",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.grey[900]),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 10.0,
                              spreadRadius: 4.5)
                        ]),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.orange,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Expenses",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.grey[900]),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 10.0,
                              spreadRadius: 4.5)
                        ]),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
