import 'package:flutter/material.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/store.dart';
import './map.dart';

class MapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        List<String> newUrl = [...url];
        newUrl.removeLast();
        url.value = newUrl;
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: FormTitle(title: 'Project Map'),
        ),
        body: MapMapWidget(),
      ),
    );
  }
}
