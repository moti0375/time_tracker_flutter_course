import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/pages/jobs/jobs_page.dart';
import 'package:time_tracker_flutter_course/pages/sign_in_page/sign_in_page.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/services/database.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BaseAuth auth = Provider.of<BaseAuth>(context);
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user != null) {
            return Provider<Database>(
              builder: (_) => FirestoreDatabase(uid: user.uid),
              child: JobsPage(),
            ); //Placeholder for HomePage
          } else {
            return SignInPage.create(context);
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
