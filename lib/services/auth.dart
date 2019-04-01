import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class User {
  final String uid;

  User({@required this.uid});
}

abstract class BaseAuth {
  Stream<User> get onAuthStateChanged;
  Future<User> currentUser();
  Future<User> singInAnonymously();
  Future<void> signOut();
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser firebaseUser) {
    if (firebaseUser == null) {
      return null;
    }
    return User(uid: firebaseUser.uid);
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map((firebaseUser) {
      return _userFromFirebase(firebaseUser);
    });
  }

  @override
  Future<User> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  Future<User> singInAnonymously() async {
    FirebaseUser user = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(user);
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    return await _firebaseAuth.signOut();
  }

  @override
  Future<User> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount account = await googleSignIn.signIn();
    if (account != null) {
      GoogleSignInAuthentication authentication = await account.authentication;
      if(authentication.idToken != null && authentication.accessToken != null){
        FirebaseUser user = await _firebaseAuth.signInWithGoogle(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken,
        );
        return _userFromFirebase(user);
      }
      throw StateError("Google sign in failed");
    } else {
      throw StateError("Google sign in aborted");
    }
  }

  @override
  Future<User> signInWithFacebook() async{
    final facebookLogin = FacebookLogin();
    FacebookLoginResult result = await facebookLogin.logInWithReadPermissions(['public_profile']);
    if(result.accessToken != null){
      FirebaseUser user = await _firebaseAuth.signInWithFacebook(accessToken: result.accessToken.token);
      return _userFromFirebase(user);
    }else{
      throw StateError("Facebook access token error");
    }
  }

}
