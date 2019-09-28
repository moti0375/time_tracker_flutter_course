import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/common_widgets/Avatar.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Page"),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Logout",
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            onPressed: () => _showSignOutDialog(context),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: _buildAccountInfo(user),
        ),
      ),
    );
  }

  Future<void> _showSignOutDialog(BuildContext context) async {
    print("_showSignOutDialog:");
    await PlatformAlertDialog(
      title: 'Sign out?',
      content: 'Are you sure?',
      positiveActionText: "Logout",
      negativeActionText: "Cancel",
      onPositive: (){
        _signOut(context);
      },
    ).show(context);
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
          _signOut(context);
        },
      )
    ];
  }

  _signOut(BuildContext context) async {
    print("_signOut");
    try {
      await Provider.of<BaseAuth>(context).signOut();
    } catch (e) {
      print("_signInAnonymously: There was an error: $e");
    }
  }

  Widget _buildAccountInfo(User user) {
    return Column(
      children: <Widget>[
        Avatar(
          photoUrl: user.photoUrl,
          radius: 50,
        ),
        SizedBox(
          height: 8.0,
        ),
        if (user.displayName != null)
          Container(
            child: Text(
              user.displayName,
              style: TextStyle(color: Colors.white),
            ),
          ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}
