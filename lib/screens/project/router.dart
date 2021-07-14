import 'package:flutter/material.dart';
import 'package:capturing/utils/getLayout.dart';
import 'package:capturing/screens/project/index.dart';
import 'package:capturing/screens/projects/index.dart';
import 'package:capturing/largeLayout.dart';

class ProjectRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String layout = getLayout(context: context);
    if (layout == 'lg') {
      return LargeLayout(content: ProjectContainer());
    }
    return ProjectContainer();
  }
}
