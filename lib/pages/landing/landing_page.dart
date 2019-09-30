import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/pages/home_page/home_page.dart';
import 'package:time_tracker_flutter_course/pages/jobs/jobs_page.dart';
import 'package:time_tracker_flutter_course/pages/sign_in_page/sign_in_page.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/services/database.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("LandingPage: build");
    final BaseAuth auth = Provider.of<BaseAuth>(context, listen: false);
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        print("LandingPage: $snapshot");
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user != null) {
            return Provider<User>.value(
              value: user,
              child: Provider<Database>(
                builder: (_) => FirestoreDatabase(uid: user.uid),
                child: HomePage(),
              ),
            ); //Placeholder for HomePage
          } else {
            return SignInPage.create(context);
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                key: Key("ProgressIndicator"),
              ),
            ),
          );
        }
      },
    );
  }
}
