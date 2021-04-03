import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iat_nigeria/services/auth/auth_service.dart';
import 'package:iat_nigeria/services/auth/auth_service_factory.dart';
import 'package:iat_nigeria/services/auth/user_signup_data.dart';
import 'package:iat_nigeria/wallet_index.dart';
import 'package:toast/toast.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController telephoneEditingController =
      new TextEditingController();
  TextEditingController addressEditingController = new TextEditingController();
  TextEditingController teamEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController usernameEditingController = new TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  var _value;

  List teamsData = [];

  AuthenticationService authenticationService = AuthServiceFactory.create();

  @override
  void initState() {
    super.initState();
  }

  

  singUp() async {
    if (!formKey.currentState.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    UserSignUpData signUpData = new UserSignUpData(
        email: emailEditingController.text,
        passWord: passwordEditingController.text,
        contact: _value,);

    var response = await authenticationService.signUpUser(signUpData);

    if (response) {
      Toast.show("Signup succesful", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.green);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => WalletIndex()),
          (Route<dynamic> route) => false);
    } else {
      Toast.show("Failed to signup", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
       appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
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
                                color: Colors.red,
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
                                color: Colors.red,
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
                                      controller: passwordEditingController,
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
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.red,
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
                                      controller: telephoneEditingController,
                                      validator: (val) {
                                        return RegExp(r"^(?:[+0]11)?[0-9]{12}$")
                                                .hasMatch(val)
                                            ? "Enter a valid phone number"
                                            : null;
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Telephone',
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
                        singUp();
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
                    SizedBox(height: size.height * 0.03),
                    AlreadyHaveAnAccountCheck(
                      press: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
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
            ),
    );
  }
}

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;

  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Already have an Account ? ",
          style: TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            "Sign In",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
