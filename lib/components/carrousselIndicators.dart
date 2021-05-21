import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarrousselIndicators extends StatelessWidget {
  final List<dynamic> fields;
  final PageController controller;
  final RxInt activePageIndex;

  CarrousselIndicators({
    required this.fields,
    required this.controller,
    required this.activePageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: fields
              .map(
                (field) => indicator(
                  isActive: fields.indexOf(field) == activePageIndex.value,
                  context: context,
                  onTap: () {
                    controller.animateToPage(
                      fields.indexOf(field),
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

Widget indicator({required bool isActive, context, required onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 10,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
                ? BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.72),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: Offset(
                      0.0,
                      0.0,
                    ),
                  )
                : BoxShadow(
                    color: Colors.transparent,
                  )
          ],
          shape: BoxShape.circle,
          color: isActive ? Theme.of(context).primaryColor : Color(0XFFEAEAEA),
          //color: isActive ? Colors.red : Color(0XFFEAEAEA),
        ),
      ),
    ),
  );
}
