import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/pages/sign_in_page/sign_in_button.dart';
import 'package:time_tracker_flutter_course/pages/sign_in_page/social_sign_in_button.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class SignInPage extends StatelessWidget {
  SignInPage({@required this.auth});

  final BaseAuth auth;

  Future<void> _signInAnonymously() async {
    try {
        auth.singInAnonymously();
    } catch (e) {
      print("_signInAnonymously: There was an error: $e");
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      auth.signInWithGoogle();
    } catch (e) {
      print("_signInAnonymously: There was an error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Time Tracker"),
        elevation: 2,
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Sign in",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            text: "Sign in with Google",
            textColor: Colors.black87,
            color: Colors.white,
            assetName: "images/google-logo.png",
            onPressed: _signInWithGoogle,
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            child: SocialSignInButton(
              text: "Sign in with Facebook",
              textColor: Colors.white,
              color: Color(0xFF334D92),
              assetName: "images/facebook-logo.png",
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 8,
          ),
          SignInButton(
            text: "Sign in with email",
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: () {},
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Or",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          SizedBox(
            height: 8,
          ),
          SignInButton(
            text: "Go Anonymoues",
            textColor: Colors.black,
            color: Colors.lime[300],
            onPressed: _signInAnonymously,
          ),
        ],
      ),
    );
  }
}
