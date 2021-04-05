import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iat_nigeria/constants/constants.dart';
import 'package:iat_nigeria/services/wallet/model/user_wallet.dart';
import 'package:iat_nigeria/ui/user/user_profile.dart';
import 'package:intl/intl.dart';

class WalletData extends StatefulWidget {
  final UserWallet usersWallet;

  const WalletData({Key key, this.usersWallet}) : super(key: key);
  @override
  _WalletDataState createState() => _WalletDataState();
}

class _WalletDataState extends State<WalletData> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UserWallet wallet;

  @override
  void initState() {
    super.initState();
    //currency();
    setState(() {
      wallet = widget.usersWallet;
    });
  }

  /* void currency() {
    Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.simpleCurrency(locale: locale.toString());
    print("CURRENCY SYMBOL ${format.currencySymbol}"); // $
    print("CURRENCY NAME ${format.currencyName}"); // USD
} */



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  wallet.balance != null
                      ? "\N " + format.format(wallet.balance).toString()
                      : "0.00",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 36,
                      fontWeight: FontWeight.w700),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.notifications,
                        color: Colors.lightBlue[100],
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProfileScreen(),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: ClipOval(
                            child: Image.asset(
                              profile_holder,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Text(
            "Available Balance",
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black),
          ),
          SizedBox(
            height: 24,
          ),
         
        ],
      ),
    );
  }
}




