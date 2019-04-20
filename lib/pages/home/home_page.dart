import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({@required this.auth});

  final BaseAuth auth;

  _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print("_signInAnonymously: There was an error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Logout",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              _showSignOutDialog(context);
            },
          )
        ],
      ),
    );
  }

  Future<void> _showSignOutDialog(BuildContext context) async {
    await PlatformAlertDialog(
      title: 'Sign out?',
      content: 'Are you sure?',
      defaultActionText: "Logout",
      actions: _buildActions(context),
    ).show(context).then((selection) {
      if (selection) {
        _signOut();
      }
    });
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      PlatformAlertDialogAction(
          child: Text("No"),
          onPressed: () {
            Navigator.of(context).pop(false);
          }),
      PlatformAlertDialogAction(
          child: Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop(true);
          })
    ];
  }
}
