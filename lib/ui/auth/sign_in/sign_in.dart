import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iat_nigeria/constants/constants.dart';
import 'package:iat_nigeria/services/auth/auth_service.dart';
import 'package:iat_nigeria/services/auth/auth_service_factory.dart';
import 'package:iat_nigeria/session/session_storage.dart';
import 'package:iat_nigeria/ui/auth/sign_in/widgets/already_have_accout.dart';
import 'package:iat_nigeria/ui/wallet/wallet_index.dart';
import 'package:iat_nigeria/utils/waiting_dialog.dart';
import 'package:toast/toast.dart';

class SignIn extends StatefulWidget {
  //final String phone;
  //SignIn(this.phone);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _passwordEditingController =
      new TextEditingController();

  AuthenticationService authenticationAPI = AuthServiceFactory.create();

  final formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  String username;
  String password;

 /* @override
  void initState() {
    super.initState();
    _logout();
  }
  _logout(){
    SessionStorage sessionStorage = new SessionStorage();
    sessionStorage.logout();
  }
*/
  _signIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      username = _emailEditingController.text;
      password = _passwordEditingController.text;

      var response = await authenticationAPI.login(username, password);

      if (response) {
        print("logged in");
        setState(() {
          _isLoading = false;
        });
        Toast.show("Login successful", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.green);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => WalletIndex()));
      } else {
        setState(() {
          _isLoading = false;
        });
        Toast.show(
            "Failed to Login, check you credentials and try again", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.red);
      }


    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit the App'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Text("YES"),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
          backgroundColor: themeColor,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.10),
                      Text(
                        "Sign-in Form",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Sign in with your email and password  \n",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: size.height * 0.03),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
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
                                              controller: _emailEditingController,
                                              validator: (val) {
                                                return RegExp(
                                                            r"^(?:[+0]11)?[0-9]{12}$")
                                                        .hasMatch(val)
                                                    ? "Enter a valid phone number"
                                                    : null;
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Phone Number',
                                                hintStyle:
                                                    TextStyle(color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.03),
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
                                              obscureText: true,
                                              controller:
                                                  _passwordEditingController,
                                              validator: (val) {
                                                return val.length < 6
                                                    ? "Enter Password 6+ characters"
                                                    : null;
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Password',
                                                hintStyle:
                                                    TextStyle(color: Colors.grey),
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
                            SizedBox(height: size.height * 0.05),
                            GestureDetector(
                              onTap: () {
                                _isLoading ? null :_signIn();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 20),
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
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.05),
                            AlreadyHaveAnAccountCheck(
                              press: () {
                                Navigator.pushReplacementNamed(context, '/login');
                              },
                            ),
                            SizedBox(height: size.height * 0.10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "By signing in, you are agree \nwith our Terms & Conditions",
                                  style: TextStyle(color: Colors.black45),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: size.height * 0.08),

                      SizedBox(height: 20),
                      //NoAccountText(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
