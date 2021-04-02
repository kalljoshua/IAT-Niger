import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TransactionIndex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: DraggableScrollableSheet(
          builder: (context, scrollController) {
            return Container(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Your Transactions",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 24,
                                    color: Colors.black),
                              ),
                              Text(
                                "Deposit and Expense transactions",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.more_horiz,
                              color: Colors.lightBlue[900],
                              size: 30,
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 32),
                    ),

                    SizedBox(
                      height: 16,
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Row(
                        children: <Widget>[
                          //copy same button
                          Container(
                            child: Text(
                              "Deposits",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.grey[900]),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[200],
                                      blurRadius: 10.0,
                                      spreadRadius: 4.5)
                                ]),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),

                          SizedBox(
                            width: 16,
                          ),

                          Container(
                            child: Text(
                              "Expenses",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.grey[900]),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[200],
                                      blurRadius: 10.0,
                                      spreadRadius: 4.5)
                                ]),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                        ],
                      ),
                    ),

                    //Container for card
                    SizedBox(
                      height: 16,
                    ),

                    Container(
                      child: Text(
                        "Deposit Transactions",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.grey[500]),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 32),
                    ),

                    SizedBox(
                      height: 16,
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(18))),
                                child: Icon(
                                  Icons.date_range,
                                  color: Colors.lightBlue[900],
                                ),
                                padding: EdgeInsets.all(12),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Payment",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey[900]),
                                    ),
                                    Text(
                                      "Payment to Joshua",
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
                                    "+\$500.5",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.lightGreen),
                                  ),
                                  Text(
                                    "26 Jan",
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
                      },
                      shrinkWrap: true,
                      itemCount: 3,
                      padding: EdgeInsets.all(0),
                      controller: ScrollController(keepScrollOffset: false),
                    ),

                    SizedBox(
                      height: 16,
                    ),

                    Container(
                      child: Text(
                        "Expense Transactions",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.grey[500]),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 32),
                    ),

                    SizedBox(
                      height: 16,
                    ),

                    ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(18))),
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
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "OTT Payment",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey[900]),
                                    ),
                                    Text(
                                      "Payment to MTN",
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
                                    "-\$500.5",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.orange),
                                  ),
                                  Text(
                                    "26 Jan",
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
                      },
                      shrinkWrap: true,
                      itemCount: 3,
                      padding: EdgeInsets.all(0),
                      controller: ScrollController(keepScrollOffset: false),
                    ),

                    SizedBox(
                      height: 16,
                    ),

                  ],
                ),
              ),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(243, 245, 248, 1),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40))),
            );
          },
          initialChildSize: 0.95,
          maxChildSize: 0.95,
        ),
      ),
    );

  }
}
