import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iat_nigeria/services/transactions/models/last_transaction_data.dart';
import 'package:iat_nigeria/services/transactions/trans_service_factory.dart';
import 'package:iat_nigeria/services/transactions/transaction_service.dart';
import 'package:iat_nigeria/session/session_storage.dart';
import 'package:iat_nigeria/ui/auth/sign_in/sign_in.dart';

import 'deposit_transactions.dart';
import 'expense_transactions.dart';

class TransactionIndex extends StatefulWidget {
  @override
  _TransactionIndexState createState() => _TransactionIndexState();
}

class _TransactionIndexState extends State<TransactionIndex> {
  final TransactionService lastTransaction = TransactionServiceFactory.create();

  Future<List<PaymentsData>> lastTrans;

  SessionStorage sessionStorage = new SessionStorage();
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _getUserTransactions();
  }

  _getUserTransactions() async{

    var isLoggedIn = await sessionStorage.loginStatus();
    if (isLoggedIn) {
      setState(() {
        _isLoggedIn = true;
      });
    }
    if(_isLoggedIn == false){
      sessionStorage.logout();
      Navigator.pushReplacement( context, MaterialPageRoute( builder: (context) => SignIn()));
    }
    Future<List<PaymentsData>> transFuture =
        lastTransaction.getPaymentData();

    setState(() {
      lastTrans = transFuture;
    });
  }

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
                    FutureBuilder<List<PaymentsData>>(
                      future: lastTrans,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PaymentsData>> snapshot) {
                        if (snapshot.hasData) {
                          List<PaymentsData> depositTransactions = snapshot.data;
                          if (snapshot.data.length < 1) {
                            return Center(
                                child: Text('No transactions to display'));
                          }
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              return DepositTransaction(deposit: depositTransactions [index]);
                            },
                            primary: false,
                            shrinkWrap: true,
                            itemCount: depositTransactions .length,
                            padding: EdgeInsets.all(0),
                            controller:
                                ScrollController(keepScrollOffset: false),
                          );
                        } else if (snapshot.hasError) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: Text(
                                  "Failed To fetch data, Please check your internet connection"),
                            ),
                          );
                        } else {
                          return Container(
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      },
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

                    FutureBuilder<List<PaymentsData>>(
                      future: lastTrans,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PaymentsData>> snapshot) {
                        if (snapshot.hasData) {
                          List<PaymentsData> transactions = snapshot.data;
                          if (snapshot.data.length < 1) {
                            return Center(
                                child: Text('No transactions to display'));
                          }
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              return ExpenseTransaction(trans: transactions [index]);
                            },
                            primary: false,
                            shrinkWrap: true,
                            itemCount: transactions .length,
                            padding: EdgeInsets.all(0),
                            controller:
                            ScrollController(keepScrollOffset: false),
                          );
                        } else if (snapshot.hasError) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: Text(
                                  "Failed To fetch data, Please check your internet connection"),
                            ),
                          );
                        } else {
                          return Container(
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      },
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
