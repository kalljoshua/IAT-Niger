import 'package:flutter/material.dart';
import 'package:iat_nigeria/models/user/numbers.dart';
import 'package:iat_nigeria/services/user/users_service.dart';
import 'package:iat_nigeria/services/user/users_service_factory.dart';
import 'package:iat_nigeria/ui/auth/sign_in/sign_in.dart';
import '../../../constants/constants.dart';
import '../redirect_auth.dart';
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
        if (contact == _controller.text && status == 'Available') {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => OTPScreen(_controller.text, code)),
          );
        } else if (contact == _controller.text && status == 'Account Exists') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SignIn()),
          );
        }
      },
      onError: (e) {
        print(e);
        contact = _controller.text;
        return Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => RediectAuth(_controller.text, code)),
        );
      },
    );
  }

  List<String> _values = <String>['+234', '+256'];
  String code = '+234';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Authentication'),
        backgroundColor: themeColor,
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
              child: Row(
                mainAxisSize: MainAxisSize.min, // see 3
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: DropdownButtonFormField(
                      decoration:
                          InputDecoration(contentPadding: EdgeInsets.all(0.0)),
                      value: code,
                      items: ['+234', '+256']
                          .map((String unit) => DropdownMenuItem<String>(
                              value: unit, child: Text(unit)))
                          .toList(),
                      onChanged: (value) => setState(
                        () {
                          code = value;
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Flexible(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '0700000000',
                        prefix: Padding(
                          padding: EdgeInsets.all(4),
                        ),
                      ),
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      controller: _controller,
                    ),
                  ),
                ],
              ),
            )
          ]),
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: FlatButton(
              color: themeColor,
              onPressed: () => _getUserProfile(),
              child: Text(
                'Verify',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
