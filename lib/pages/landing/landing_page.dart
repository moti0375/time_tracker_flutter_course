import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/pages/home/home_page.dart';
import 'package:time_tracker_flutter_course/pages/sign_in_page/sign_in_page.dart';
import 'package:time_tracker_flutter_course/pages/sign_in_page/sing_in_bloc.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

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
            return HomePage(); //Placeholder for HomePage
          } else {
            return _buildSignInPage(auth);
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

  Widget _buildSignInPage(BaseAuth auth){
    final signInBloc = SignInBloc(auth: auth);
    return StatefulProvider<SignInBloc>(
      valueBuilder: (context) => signInBloc,
      onDispose: (context, bloc) => bloc.dispose(),
      child: SignInPage(bloc: signInBloc,),
    );

  }
}
