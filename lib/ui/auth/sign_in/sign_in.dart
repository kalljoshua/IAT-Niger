import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iat_nigeria/constants/size_config.dart';
import 'package:iat_nigeria/services/auth/auth_service.dart';
import 'package:iat_nigeria/services/auth/auth_service_factory.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _passwordEditingController =
      new TextEditingController();

  AuthenticationService authenticationAPI = AuthServiceFactory.create();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String username;
  String password;

  signIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      username = _emailEditingController.text;
      password = _passwordEditingController.text;

      var response = await authenticationAPI.login(username, password);

      if (response) {
        print("logged in");
      } else {
        print("logged in");
        /* Toast.show("Failed to Login", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.red); */
      }

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
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
                              signIn();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 20),
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
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.05),
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
    );
  }
}
