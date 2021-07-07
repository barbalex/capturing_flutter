import 'package:flutter/material.dart';
import 'package:capturing/utils/getLayout.dart';
import 'package:capturing/screens/project/index.dart';
import 'package:capturing/screens/projects/index.dart';

class ProjectRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String layout = getLayout(context: context);
    if (layout == 'large') {
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ProjectsContainer(),
              flex: 1,
            ),
            Expanded(
              child: ProjectContainer(),
              flex: 2,
            )
          ],
        ),
      );
    }
    return ProjectContainer();
  }
}
