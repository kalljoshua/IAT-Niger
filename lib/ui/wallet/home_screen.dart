import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iat_nigeria/services/iat/iat_service.dart';
import 'package:iat_nigeria/services/iat/iat_service_factory.dart';
import 'package:iat_nigeria/services/iat/models/iat_data.dart';
import 'package:iat_nigeria/services/transactions/models/last_transaction_data.dart';
import 'package:iat_nigeria/services/transactions/trans_service_factory.dart';
import 'package:iat_nigeria/services/transactions/transaction_service.dart';
import 'package:iat_nigeria/services/wallet/model/flutter_wave.dart';
import 'package:iat_nigeria/services/wallet/model/user_wallet.dart';
import 'package:iat_nigeria/services/wallet/wallet_service.dart';
import 'package:iat_nigeria/services/wallet/wallet_service_factory.dart';
import 'package:iat_nigeria/session/session_storage.dart';
import 'package:iat_nigeria/ui/auth/sign_in/sign_in.dart';
import 'package:iat_nigeria/ui/wallet/send_money.dart';
import 'package:iat_nigeria/ui/wallet/widgets/ott_subscription.dart';
import 'package:toast/toast.dart';
import 'pay_ott.dart';
import 'process_topup.dart';
import 'widgets/buttons.dart';
import 'widgets/transactions.dart';
import 'widgets/wallet_top.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.user});

  final User user;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WalletService usersWallet = WalletServiceFactory.create();
  final IatService usersIat = IatServiceFactory.create();
  final TransactionService lastTransaction = TransactionServiceFactory.create();
  final WalletService topUpLink = WalletServiceFactory.create();
  Future<UserWallet> wallet;
  Future<IatData> iat;
  Future<List<PaymentsData>> lastTrans;
  Future<FlutterWave> _link;

  String link = "";

  bool _isLoggedIn = false;

  SessionStorage sessionStorage = new SessionStorage();

  TextEditingController _amountEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserWallet();
  }

  _getUserWallet() async {
    Future<List<PaymentsData>> transFuture =
        lastTransaction.getLastPaymentData();

    var isLoggedIn = await sessionStorage.loginStatus();
    if (isLoggedIn) {
      setState(() {
        _isLoggedIn = true;
      });
    }
    if (_isLoggedIn == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignIn()));
    }
    setState(() {
      wallet = usersWallet.getUserWalletInfo();
      iat = usersIat.getUserIatInfo();
      lastTrans = transFuture;
    });
  }

  _topUp() async {
    setState(() {
      _link = topUpLink.getUserTopLink(_amountEditingController.text);
    });

    _link.then(
      (data) {
        link = data.data.link;
        if (link != null) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => WebViewClass(link)),
          );
        }
      },
      onError: (e) {
        print(e);
        Toast.show("Service down, try again letter", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.red);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            //Container for top data
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<UserWallet>(
                    future: wallet,
                    // ignore: missing_return
                    builder: (BuildContext context,
                        AsyncSnapshot<UserWallet> snapshot) {
                      /*if (!snapshot.hasData) {
                        // show loading while waiting for real data
                        return CircularProgressIndicator();
                      }*/
                      if (snapshot.hasData) {
                        UserWallet userWallet = snapshot.data;
                        return WalletData(
                          usersWallet: userWallet,
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
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          topUp(context);
                        },
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(243, 245, 248, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18))),
                                child: Icon(
                                  Icons.trending_down,
                                  color: Colors.green[900],
                                  size: 30,
                                ),
                                padding: EdgeInsets.all(12),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Topup",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => PayOTT(),
                            ),
                          );
                        },
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(243, 245, 248, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18))),
                                child: Icon(
                                  Icons.phone_android_sharp,
                                  color: Colors.green[900],
                                  size: 30,
                                ),
                                padding: EdgeInsets.all(12),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Pay IAT",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _sendMoney(context);
                        },
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(243, 245, 248, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18))),
                                child: Icon(
                                  Icons.send_to_mobile,
                                  color: Colors.green[900],
                                  size: 30,
                                ),
                                padding: EdgeInsets.all(12),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Send",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Toast.show("Coming soon", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM,
                              backgroundColor: Colors.orange);
                        },
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(243, 245, 248, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18))),
                                child: Icon(
                                  Icons.public,
                                  color: Colors.green[900],
                                  size: 30,
                                ),
                                padding: EdgeInsets.all(12),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Request",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 26,
            ),
            //draggable sheet
            DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(243, 245, 248, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: SingleChildScrollView(
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
                              Text(
                                "Recent Transactions",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 24,
                                    color: Colors.black),
                              ),
                              Text(
                                "See all",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              )
                            ],
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 32),
                        ),
                        SizedBox(
                          width: 24,
                        ),

                        //Container for buttons
                        ButtonsData(),

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "IAT Subscription",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 32),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        FutureBuilder<IatData>(
                          future: iat,
                          // ignore: missing_return
                          builder: (BuildContext context,
                              AsyncSnapshot<IatData> snapshot) {
                            if (snapshot.hasData) {
                              IatData userIat = snapshot.data;
                              if (!snapshot.hasData) {
                                return Center(
                                    child: Text('No running IAT Subscription'));
                              }
                              return OttSubscription(
                                iatSubscription: userIat,
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
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),

                        //Container Listview for expenses and incomes
                        Container(
                          child: Text(
                            "Last 5 Payments",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[500],
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 32),
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
                                primary: false,
                                shrinkWrap: true,
                                itemCount: transactions.length,
                                itemBuilder: (context, position) {
                                  return InkWell(
                                    splashColor: Colors.grey[200],
                                    onTap: () {},
                                    child: TransactionData(
                                        trans: transactions[position]),
                                  );
                                },
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
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }
                          },
                        ),

                        //now expense
                        SizedBox(
                          height: 16,
                        ),

                        Container(
                          child: Text(
                            "",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[500]),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 32),
                        ),

                        SizedBox(
                          height: 16,
                        ),

                        /* ListView.builder(
                          itemBuilder: (context, index) {
                            return TransactionData();
                          },
                          shrinkWrap: true,
                          itemCount: 2,
                          padding: EdgeInsets.all(0),
                          controller: ScrollController(keepScrollOffset: false),
                        ), */

                        //now expense
                      ],
                    ),
                    controller: scrollController,
                  ),
                );
              },
              initialChildSize: 0.65,
              minChildSize: 0.65,
              maxChildSize: 1,
            )
          ],
        ),
      ),
    );
  }

  void _sendMoney(BuildContext pd) {
    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: pd,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: 200),
        child: SendMoney(),
      ),
    );
  }

  void topUp(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 5,
        context: ctx,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        builder: (ctx) => Padding(
              padding: EdgeInsets.only(bottom: 210),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Top up',
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Enter amount',
                        ),
                        autofocus: true,
                        controller: _amountEditingController,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _topUp();
                      },
                      child: Text('Top up'))
                ],
              ),
            ));
  }
}
