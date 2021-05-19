import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FormTitle extends StatelessWidget {
  final String title;
  FormTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title);
    // return Row(
    //   children: <Widget>[
    //     Hero(
    //       tag: 'logo',
    //       child: Container(
    //         child: Icon(
    //           FontAwesomeIcons.pen,
    //           size: 16,
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: EdgeInsets.only(left: 10),
    //     ),
    //     Text(title),
    //   ],
    // );
  }
}
