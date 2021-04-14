import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iat_nigeria/constants/constants.dart';
import 'package:iat_nigeria/services/auth/auth_service.dart';
import 'package:iat_nigeria/services/auth/auth_service_factory.dart';
import 'package:iat_nigeria/services/auth/user_signup_data.dart';
import 'package:iat_nigeria/ui/wallet/wallet_index.dart';
import 'package:iat_nigeria/utils/waiting_dialog.dart';
import 'package:toast/toast.dart';

class SignUpScreen extends StatefulWidget {
  final String phone;

  SignUpScreen(this.phone);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController telephoneEditingController =
      new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController usernameEditingController = new TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  bool _enabled = false;

  var _value;

  List teamsData = [];

  AuthenticationService authenticationService = AuthServiceFactory.create();

  @override
  void initState() {
    super.initState();
    _enabled = !_enabled;
  }

  _signUp() async {
    if (!formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      UserSignUpData signUpData = new UserSignUpData(
        email: emailEditingController.text,
        passWord: passwordEditingController.text,
        contact: widget.phone,
      );

      var response = await authenticationService.signUpUser(signUpData);
      print("Renspose code signup: **" + response.toString());
      if (response) {
        Toast.show("Signup succesful", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.green);
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (BuildContext context) => WalletIndex()));
      } else {
        Toast.show("Failed to signup", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.red);
      }

      setState(() {
        _isLoading = false;
      });
    }else{
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        backgroundColor: themeColor,
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
                      "Sign-Up Form",
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
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        children: [
                          /*  SizedBox(height: size.height * 0.09),
                                Image.asset(
                                  "assets/images/white_logo.png",
                                  height: size.height * 0.20,
                                ), */
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
                                            controller: emailEditingController,
                                            validator: (val) {
                                              return RegExp(
                                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                      .hasMatch(val)
                                                  ? null
                                                  : "Enter correct email";
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Email Address',
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
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
                                            obscureText: true,
                                            controller:
                                                passwordEditingController,
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
                          SizedBox(
                            height: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              _isLoading ? null :_signUp();
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
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          SizedBox(height: size.height * 0.05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "By signing up, you are agree \nwith our Terms & Conditions",
                                style: TextStyle(color: Colors.black45),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
