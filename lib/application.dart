import 'dart:io';

import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/pages/landing/landing_page.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:provider/provider.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<BaseAuth>(
      value: Auth(),
      child: MaterialApp(
        title: "TimeTracker",
        theme: ThemeData(
          primarySwatch: Theme.of(context).primaryColor,
          primaryTextTheme: Platform.isIOS ?  Theme.of(context).cupertinoOverrideTheme : Theme.of(context).primaryTextTheme
        ),
        home: LandingPage()
      ),
    );
  }
}
