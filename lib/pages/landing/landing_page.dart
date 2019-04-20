import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/pages/home/home_page.dart';
import 'package:time_tracker_flutter_course/pages/sign_in_page/sign_in_page.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class LandingPage extends StatelessWidget {
  LandingPage({@required this.auth});

  final BaseAuth auth;

  @override
  Widget build(BuildContext context) {
    final homePage = HomePage(auth: auth);
    final signInPage = SignInPage(auth: auth);

    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          User user = snapshot.data;
          if (user != null) {
            return HomePage(
              auth: auth,
            ); //Placeholder for HomePage
          } else {
            return SignInPage(
              auth: auth,
            );
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
