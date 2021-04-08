import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iat_nigeria/constants/constants.dart';
import 'package:iat_nigeria/services/wallet/model/isp_data.dart';
import 'package:iat_nigeria/services/wallet/model/ott_payment_data.dart';
import 'package:iat_nigeria/services/wallet/model/user_wallet.dart';
import 'package:iat_nigeria/services/wallet/wallet_service.dart';
import 'package:iat_nigeria/services/wallet/wallet_service_factory.dart';
import 'package:toast/toast.dart';

import 'wallet_index.dart';

class PayOTT extends StatefulWidget {
  @override
  _PayOTTState createState() => _PayOTTState();
}

class _PayOTTState extends State<PayOTT> {
  final WalletService usersWallet = WalletServiceFactory.create();

  TextEditingController contactEditingController = new TextEditingController();
  TextEditingController packageEditingController = new TextEditingController();
  TextEditingController ispEditingController = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<UserWallet> wallet;

  var _package = "daily";

  Future<List<IspData>> ispData;

  var _value;

  WalletService walletService = WalletServiceFactory.create();

  @override
  void initState() {
    super.initState();
    this.fetchIsps();
  }

  fetchIsps() async {
    Future<List<IspData>> isps = walletService.getIspPageData();

    setState(() {
      ispData = isps;
    });
  }

  _payOtt() async {
    if (!formKey.currentState.validate()) {
      return;
    }

    var data = {
      'contact': contactEditingController.text,
      'package': _package,
      'isp': _value,
    };

    OttData ottData = new OttData(
      isp: int.parse(_value),
      iatPackage: _package,
      contact: contactEditingController.text,
    );

    var response = await walletService.payOtt(ottData);

    if (response) {
      setState(() {
        wallet = usersWallet.getUserWalletInfo();
      });
      Toast.show("OTT Subscription succesful", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.green);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => WalletIndex()));
    } else {
      Toast.show("Failed To Subscribe", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red);
    }

    print("****Posted values: " + jsonEncode(data));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(""),
        backgroundColor: kPrimaryWhiteColor,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.05),
                Text(
                  "Pay IAT",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Row(
                          children: <Widget>[
                            new Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: TextFormField(
                                  controller: contactEditingController,
                                  validator: (val) {
                                    return RegExp(r"^(?:[+0]11)?[0-9]{12}$")
                                            .hasMatch(val)
                                        ? "Enter a valid phone number"
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Phone Number',
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text('Daily'),
                        leading: Radio<String>(
                          value: "DAILY",
                          groupValue: _package,
                          onChanged: _handleGenderChange,
                        ),
                      ),
                      ListTile(
                        title: const Text('Weekly'),
                        leading: Radio<String>(
                          value: "WEEKLY",
                          groupValue: _package,
                          onChanged: _handleGenderChange,
                        ),
                      ),
                      ListTile(
                        title: const Text('Monthly'),
                        leading: Radio<String>(
                          value: "MONTHLY",
                          groupValue: _package,
                          onChanged: _handleGenderChange,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    constraints: BoxConstraints(minWidth: size.width),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "  Select Network  ",
                          style: TextStyle(color: Colors.black),
                        ),
                        FutureBuilder<List<IspData>>(
                            future: ispData,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return DropdownButton<String>(
                                    value: _value,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _value = newValue;
                                      });
                                    },
                                    items: snapshot.data.map((fc) {
                                      return DropdownMenuItem<String>(
                                        child: Text(fc.name),
                                        value: fc.id.toString(),
                                      );
                                    }).toList());
                              } else {
                                return CircularProgressIndicator();
                              }
                            }),
                      ],
                    )),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    _payOtt();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xfff44336),
                            const Color(0xfef45336)
                          ],
                        )),
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Text(
                      "Pay OTT",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(height: size.height * 0.05),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleGenderChange(String value) {
    setState(() {
      _package = value;
    });
  }
}
