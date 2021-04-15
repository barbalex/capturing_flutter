import 'package:capturing/screens/login.dart';
import 'package:capturing/screens/registration.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Welcome extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animation = ColorTween(
      begin: Colors.blueGrey,
      end: Colors.white,
    ).animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
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
                    ),
                    height: 60,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                Text('Capturing',
                    style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    )),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            MaterialButton(
              color: Colors.lightBlueAccent,
              child: Text(
                'Log in',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Get.to(() => Login());
              },
            ),
            MaterialButton(
              color: Colors.blueAccent,
              child: Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Get.to(() => Registration());
              },
            ),
          ],
        ),
      ),
    );
  }
}
