import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_toolbar.dart';
import 'package:time_tracker_flutter_course/pages/email_sign_in/email_sign_in_page.dart';
import 'package:time_tracker_flutter_course/pages/sign_in_page/sign_in_button.dart';
import 'package:time_tracker_flutter_course/pages/sign_in_page/social_sign_in_button.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:flutter/services.dart';

class SignInPage extends StatelessWidget {

  void _showErrorMessage(BuildContext context, PlatformException exception){
    PlatformExceptionAlertDialog platformAlertDialog = PlatformExceptionAlertDialog(
        title: "Sign in failed",
        exception: exception,
        actions: []);
    platformAlertDialog.show(context).then((selection) {});
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await Provider.of<BaseAuth>(context).singInAnonymously();
    } on PlatformException catch (e) {
      print("_signInAnonymously: There was an error: $e");
      _showErrorMessage(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await Provider.of<BaseAuth>(context).signInWithGoogle();
    } on PlatformException catch (e) {
      print("_signInWithGoogle: There was an error: $e");
      _showErrorMessage(context, e);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await Provider.of<BaseAuth>(context).signInWithFacebook();
    } on PlatformException catch (e) {
      print("_signInAnonymously: There was an error: $e");
      _showErrorMessage(context, e);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlatformToolbar(
        title: Text("Flutter Time Tracker"),
        actions: <Widget>[],
      ).build(context),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
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
            onPressed: () => _signInWithGoogle(context),
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
              onPressed: () => _signInWithFacebook(context),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          SignInButton(
            text: "Sign in with email",
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: () => _signInWithEmail(context),
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
            onPressed: () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }
}
