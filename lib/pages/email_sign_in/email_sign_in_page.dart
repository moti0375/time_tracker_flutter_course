import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_toolbar.dart';
import 'package:time_tracker_flutter_course/pages/email_sign_in/email_sign_in_form_stful.dart';
import 'package:time_tracker_flutter_course/pages/sign_in_page/sign_in_page.dart';
import 'package:time_tracker_flutter_course/pages/sign_in_page/sing_in_bloc.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlatformToolbar(
        title: Text("Sign in"),
        actions: <Widget>[],
      ).build(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            child: EmailSignInFormStful.create(context),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
