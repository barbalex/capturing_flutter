import 'package:flutter/material.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/components/nameLabel.dart';

class ProjectWidget extends StatelessWidget {
  final Project project;

  ProjectWidget({required this.project});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 20, right: 20),
        children: <Widget>[
          NameLabelWidget(dataset: project),
        ],
      ),
    );
  }
}
