import 'package:flutter/material.dart';
import 'package:get/get.dart';

// could also use TabPageSelector for indicator
// https://api.flutter.dev/flutter/material/TabPageSelector-class.html
// https://www.youtube.com/watch?v=Q628ue9Cq7U
class CarrouselIndicators extends StatelessWidget {
  final List<dynamic> datasets;
  final PageController controller;
  final RxInt activePageIndex;

  CarrouselIndicators({
    required this.datasets,
    required this.controller,
    required this.activePageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: datasets
              .map(
                (field) => Obx(
                  () => indicator(
                    isActive: datasets.indexOf(field) == activePageIndex.value,
                    context: context,
                    onTap: () {
                      controller.animateToPage(
                        datasets.indexOf(field),
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                  ),
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
