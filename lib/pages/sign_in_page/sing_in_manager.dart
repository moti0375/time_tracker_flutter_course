
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:flutter/services.dart';

class SignInManager{
  final BaseAuth auth;

  final ValueNotifier<bool> isLoading;

  SignInManager({@required this.auth, @required this.isLoading});


  Future<User> signInAnonymously() => _signIn(auth.singInAnonymously);

  Future<User> singInWithGoogle() async => _signIn(auth.signInWithGoogle);

  Future<User> signInWithFacebook() => _signIn(auth.signInWithFacebook);

  Future<User> _signIn(Future<User> Function() signIn) async {
    try{
      isLoading.value = true;
      return await signIn();
    } catch (e){
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

}

