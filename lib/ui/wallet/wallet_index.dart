import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iat_nigeria/services/wallet/model/flutter_wave.dart';
import 'package:iat_nigeria/services/wallet/model/user_wallet.dart';
import 'package:iat_nigeria/services/wallet/wallet_service.dart';
import 'package:iat_nigeria/services/wallet/wallet_service_factory.dart';
import 'package:iat_nigeria/session/session_storage.dart';
import 'package:iat_nigeria/ui/auth/sign_in/sign_in.dart';
import 'package:iat_nigeria/ui/wallet/process_topup.dart';
import 'package:toast/toast.dart';

import 'home_screen.dart';
import '../transactions/transactions.dart';

class WalletIndex extends StatefulWidget {
  @override
  _WalletIndexState createState() => _WalletIndexState();
}

class _WalletIndexState extends State<WalletIndex> {
  final WalletService usersWallet = WalletServiceFactory.create();
  final WalletService topUpLink = WalletServiceFactory.create();
  Future<FlutterWave> _link;
  Future<UserWallet> wallet;

  String link = "";
  bool _isLoggedIn = false;

  TextEditingController _amountEditingController = new TextEditingController();

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    TransactionIndex(),
  ]; //screens for each tab

  int selectedTab = 0;

  Future<void> navigationToNextPage() async {
    SessionStorage sessionStorage = new SessionStorage();
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
        setState(() {
          wallet = usersWallet.getUserWalletInfo();
        });
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
      backgroundColor: Color.fromRGBO(38, 81, 158, 1),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
            color: Colors.black,),
            activeIcon: Icon(
                Icons.home,
                color: Colors.green,
              ),
            label: "Home",
          ),

          BottomNavigationBarItem(
              icon: Icon(
                Icons.list_outlined,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.list_outlined,
                color: Colors.green,
              ),
              label: "Transactions",
          ),
        ],
        onTap: (index){
          setState(() {
            selectedTab = index;
          });
        },
        selectedItemColor: Colors.green,
        currentIndex: selectedTab,
        showUnselectedLabels: true,
        elevation: 5,
        iconSize: 30,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          topUp(context);
        },
        backgroundColor: Colors.green,
        elevation: 8,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _widgetOptions.elementAt(selectedTab),
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