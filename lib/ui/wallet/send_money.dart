import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iat_nigeria/services/transactions/models/last_transaction_data.dart';
import 'package:iat_nigeria/services/transactions/trans_service_factory.dart';
import 'package:iat_nigeria/services/transactions/transaction_service.dart';
import 'package:iat_nigeria/services/wallet/wallet_service.dart';
import 'package:iat_nigeria/services/wallet/wallet_service_factory.dart';
import 'package:iat_nigeria/utils/waiting_dialog.dart';
import 'package:toast/toast.dart';

class SendMoney extends StatefulWidget {
  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  final formKey = GlobalKey<FormState>();

  TextEditingController _contactEditingController = new TextEditingController();
  TextEditingController _amountEditingController = new TextEditingController();

  final WalletService sendWallet = WalletServiceFactory.create();
  final TransactionService lastTransaction = TransactionServiceFactory.create();

  Future<PaymentsData> _lastTrans;
  Future<List<PaymentsData>> lastTrans;

  bool _isLoading = false;

  _sendMoney() {
    if (!formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      if (_isLoading == true) {
        showWaitingDialog(context);
      }

      var contact = _contactEditingController.text;
      var amount = _amountEditingController.text;

      setState(() {
        _lastTrans = sendWallet.sendMoney(contact, amount);
      });

      _lastTrans.then(
        (data) {
          if (data.status == "success") {
            Future<List<PaymentsData>> transFuture =
                lastTransaction.getLastPaymentData();
            setState(() {
              lastTrans = transFuture;
            });
            setState(() {
              _isLoading = false;
            });
            Toast.show("Successfully sent $amount to $contact", context,
                duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM,
                backgroundColor: Colors.green);
          }
        },
        onError: (e) {
          print(e.message);
          if (e.message != null) {
            setState(() {
              _isLoading = false;
            });
            Toast.show(e.message, context,
                duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM,
                backgroundColor: Colors.red);
          } else {
            setState(() {
              _isLoading = false;
            });
            Toast.show(
                "Failed to send money to $contact, please try again later",
                context,
                duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM,
                backgroundColor: Colors.red);
          }
        },
      );
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
    print("****Posted values: " + _lastTrans.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                "Pay IAT",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
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
                                controller: _contactEditingController,
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
                                keyboardType: TextInputType.number,
                                controller: _amountEditingController,
                                validator: (val) {
                                  return val.length < 1
                                      ? "Enter amount to continue"
                                      : null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter Amount',
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
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  _sendMoney();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromRGBO(0, 131, 78, 1),
                          const Color(0xfe1cb430),
                        ],
                      )),
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    "Send Money",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
