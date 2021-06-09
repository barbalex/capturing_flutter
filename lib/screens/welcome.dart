import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:capturing/controllers/auth.dart';
import 'package:capturing/store.dart';

class WelcomeWidget extends StatefulWidget {
  @override
  _WelcomeWidgetState createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
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
                          authController.logOut(context);
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
                          url.value = ['/projects/'];
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
                          url.value = ['/login/'];
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
                          url.value = ['/registration/'];
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
