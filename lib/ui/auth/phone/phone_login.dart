import 'package:flutter/material.dart';
import 'package:iat_nigeria/models/user/numbers.dart';
import 'package:iat_nigeria/services/user/users_service.dart';
import 'package:iat_nigeria/services/user/users_service_factory.dart';
import 'opt.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();
  final UsersService usersService = UsersServiceFactory.create();
  Future<Number> _profile;
  String contact = '';

  @override
  void initState() {
    super.initState();
  }

  _getUserProfile() async {
    setState(() {
      _profile = usersService.checkUserProfile(_controller.text.toString());
    });
    _profile.then(
      (data) {
        contact = data.contact;
        String status = data.status;
        if (contact != null && status == 'Available')
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => OTPScreen(_controller.text)),
          );
      },
      onError: (e) {
        print(e);
        contact = _controller.text;
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child:
                  Text('This number $contact is not registered on the network'),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Auth'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: Center(
                child: Text(
                  'Phone Authentication',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40, right: 10, left: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  prefix: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('+256'),
                  ),
                ),
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: _controller,
              ),
            )
          ]),
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: FlatButton(
              color: Colors.blue,
              onPressed: () => _getUserProfile(),
              child: Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
