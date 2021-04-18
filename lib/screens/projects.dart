import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:capturing/components/newProject.dart';
import 'package:capturing/components/projectsList.dart';
import 'package:capturing/controllers/authController.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:capturing/utils/constants.dart';

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final AuthController authController = Get.find<AuthController>();
  Rx<String?> token = Rx<String?>(null);

  @override
  void initState() {
    super.initState();
    token = authController.token;
    initGraphql();
  }

  void initGraphql() async {
    // TODO:
    // initialize graphql
    await initHiveForFlutter();
    final HttpLink httpLink = HttpLink(graphQlUri);
    // TODO: token updates every hour > how to catch?
    // start subscriptions
    // start syncing}
  }

  @override
  Widget build(BuildContext context) {
    print('projects, building, token: ${token}');
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              print('TODO:');
            },
            tooltip: 'Menu',
          ),
        ],
        title: Row(
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                child: Icon(
                  FontAwesomeIcons.pen,
                  size: 16,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Text('Projects'),
          ],
        ),
      ),
      body: ProjectList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => NewProject(),
          );
        },
      ),
    );
  }
}
