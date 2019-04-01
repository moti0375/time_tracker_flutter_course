import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class HomePage extends StatelessWidget {

  HomePage({@required this.auth});

  final BaseAuth auth;

  _signOut() {
    try {
        auth.signOut();
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
            onPressed: _signOut,
          )
        ],
      ),
    );
  }
}
