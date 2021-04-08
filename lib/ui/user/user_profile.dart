import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iat_nigeria/constants/constants.dart';
import 'package:iat_nigeria/services/settings/models/password_data.dart';
import 'package:iat_nigeria/services/settings/settings_service.dart';
import 'package:iat_nigeria/services/settings/settings_service_factory.dart';
import 'package:iat_nigeria/session/session_storage.dart';
import 'package:iat_nigeria/ui/auth/sign_in/sign_in.dart';
import 'package:iat_nigeria/ui/user/widgets/settings.dart';
import 'package:iat_nigeria/ui/widgets/profile_menu.dart';
import 'package:iat_nigeria/ui/widgets/profile_pic.dart';
import 'package:toast/toast.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController _oldpassEditingController = new TextEditingController();
  TextEditingController _newpassEditingController = new TextEditingController();
  TextEditingController _confirmpassEditingController =
      new TextEditingController();

  SettingsService settingsService = SettingsServiceFactory.create();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _update() async {
    if (!formKey.currentState.validate()) {
      return;
    }

    PasswordData passwordUpdateData = new PasswordData(
      newPass: _newpassEditingController.text,
      oldPass: _oldpassEditingController.text,
      confirm: _confirmpassEditingController.text,
    );

    var response = await settingsService.updatePassword(passwordUpdateData);
    print("Renspose code signup: **" + response.toString());
    if (response) {
      Toast.show("Password update successful", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.green);
      SessionStorage sessionStorage = new SessionStorage();
      sessionStorage.logout();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => SignIn()));
    } else {
      Toast.show("Failed to update Password", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(""),
        backgroundColor: kPrimaryWhiteColor,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        color: kPrimaryWhiteColor,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              ProfilePic(),
              SizedBox(height: 20),
              ProfileMenu(
                text: "My Account",
                icon: "assets/icons/User Icon.svg",
                press: () => {
                  //_profileDisplay(context)
                  Toast.show("Coming soon", context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                      backgroundColor: Colors.orange)
                },
              ),
              ProfileMenu(
                text: "Notifications",
                icon: "assets/icons/Bell.svg",
                press: () {
                  Toast.show("Coming soon", context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                      backgroundColor: Colors.orange);
                },
              ),
              ProfileMenu(
                text: "Settings",
                icon: "assets/icons/Settings.svg",
                press: () {
                  _updatePassword(context);
                },
              ),
              ProfileMenu(
                text: "Help Center",
                icon: "assets/icons/Question mark.svg",
                press: () {
                  Toast.show("Coming soon", context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                      backgroundColor: Colors.orange);
                },
              ),
              ProfileMenu(
                text: "Log Out",
                icon: "assets/icons/Log out.svg",
                press: () {
                  SessionStorage sessionStorage = new SessionStorage();
                  sessionStorage.logout();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SignIn()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _profileDisplay(BuildContext pd) {
    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: pd,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: ProfileDisplay(),
      ),
    );
  }

  void _updatePassword(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 5,
        context: ctx,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        builder: (ctx) => Padding(
              padding: EdgeInsets.only(bottom: 210),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Update Password',
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
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Old Password',
                        ),
                        controller: _oldpassEditingController,
                        validator: (val) {
                          return val.length < 6
                              ? "Enter Password 6+ characters"
                              : null;
                        },
                      ),
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
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration.collapsed(
                          hintText: 'New Password',
                        ),
                        controller: _newpassEditingController,
                        validator: (val) {
                          return val.length < 6
                              ? "Enter Password 6+ characters"
                              : null;
                        },
                      ),
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
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Confirm Password',
                        ),
                        obscureText: true,
                        controller: _confirmpassEditingController,
                        validator: (val) {
                          return val.length < 6
                              ? "Enter Password 6+ characters"
                              : null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _update();
                        },
                        child: Text('Update'))
                  ],
                ),
              ),
            ));
  }
}
