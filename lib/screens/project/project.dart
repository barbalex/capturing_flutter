import 'package:flutter/material.dart';
import 'package:capturing/models/project.dart';
import 'package:capturing/components/nameLabel.dart';
import 'package:capturing/screens/project/projectUsers/index.dart';

class ProjectWidget extends StatelessWidget {
  final Project project;

  ProjectWidget({required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 30,
      ),
      child: Column(
        children: <Widget>[
          NameLabelWidget(dataset: project),
          SizedBox(height: 20),
          ProjectUsersList(project: project),
        ],
      ),
    );
  }
}
