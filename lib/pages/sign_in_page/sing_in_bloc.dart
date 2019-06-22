
import 'dart:async';

import 'package:meta/meta.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:flutter/services.dart';

class SignInBloc{
  final BaseAuth auth;
  final StreamController<bool> _isLoadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  SignInBloc({@required this.auth});

  void dispose(){
    _isLoadingController.close();
  }

  void setIsLoading(bool isLoading){
    _isLoadingController.add(isLoading);
  }

  Future<User> signInAnonymously() => _signIn(auth.singInAnonymously);

  Future<User> singInWithGoogle() async => _signIn(auth.signInWithGoogle);

  Future<User> signInWithFacebook() => _signIn(auth.signInWithFacebook);

  Future<User> _signIn(Future<User> Function() signIn) async {
    try{
      setIsLoading(true);
      return await signIn();
    } catch (e){
      rethrow;
    } finally {
      setIsLoading(false);
    }
  }

}

