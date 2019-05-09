import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_toolbar.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_toolbar_action.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class HomePage extends StatelessWidget {


  _signOut(BuildContext context) async {
    try {
      await Provider.of<BaseAuth>(context).signOut();
    } catch (e) {
      print("_signInAnonymously: There was an error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    PlatformToolbar appBar = PlatformToolbar(
      title: Text("Home Page"),
      actions: _buildToolbarActions(context),
    );

    return Scaffold(
      appBar: appBar.build(context),
    );
  }

  List<Widget> _buildToolbarActions(BuildContext context) {
    return <Widget>[
      PlatformFlatButton(
        title: Text("Logout"),
        onPressed: () {
          _showSignOutDialog(context);
        },
      ),
    ];
  }

  Future<void> _showSignOutDialog(BuildContext context) async {
    await PlatformAlertDialog(
      title: 'Sign out?',
      content: 'Are you sure?',
      defaultActionText: "Logout",
      actions: _buildActions(context),
    ).show(context).then((selection) {
      if (selection) {
        _signOut(context);
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
