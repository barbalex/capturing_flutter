import 'package:capturing/screens/login.dart';
import 'package:capturing/screens/projects/index.dart';
import 'package:capturing/screens/registration.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:capturing/controllers/auth.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = authController.isLoggedIn;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Icon(
                      FontAwesomeIcons.pen,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                    height: 60,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                Text('Capturing',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    )),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            isLoggedIn
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OutlinedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.signOutAlt,
                              size: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                            ),
                            Text('Log out'),
                          ],
                        ),
                        onPressed: () {
                          authController.signOut();
                          setState(() {});
                        },
                      ),
                      OutlinedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_forward,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                            ),
                            Text('Projects'),
                          ],
                        ),
                        onPressed: () {
                          Get.to(() => Projects());
                        },
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OutlinedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.signInAlt,
                              size: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                            ),
                            Text('Log in'),
                          ],
                        ),
                        onPressed: () {
                          Get.to(() => Login());
                        },
                      ),
                      OutlinedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.userCircle,
                              size: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                            ),
                            Text('Register'),
                          ],
                        ),
                        onPressed: () {
                          Get.to(() => Registration());
                        },
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
