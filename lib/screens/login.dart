import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:capturing/controllers/authController.dart';

class Login extends GetWidget<AuthController> {
  static const String id = 'login_screen';
  final email = ''.obs;
  final password = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('Log in'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: ProgressHUD(
        child: Builder(
          builder: (context) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Icon(
                        FontAwesomeIcons.pen,
                        size: 80,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextFormField(
                  onChanged: (value) {
                    email.value = value;
                  },
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Enter your Email',
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  onChanged: (value) {
                    password.value = value;
                  },
                  obscureText: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Enter your Password',
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                MaterialButton(
                  color: Colors.lightBlueAccent,
                  child: Text('Log in'),
                  onPressed: () => controller.login(
                    email.value,
                    password.value,
                    context,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
