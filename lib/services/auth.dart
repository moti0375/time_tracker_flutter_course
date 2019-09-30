import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class User {
  final String uid;
  final String photoUrl;
  final String displayName;

  User({@required this.uid, this.photoUrl, @required this.displayName});
}

abstract class BaseAuth {
  Stream<User> get onAuthStateChanged;

  Future<User> currentUser();

  Future<User> singInAnonymously();

  Future<void> signOut();

  Future<User> signInWithGoogle();

  Future<User> signInWithFacebook();

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<User> createAccount(String email, String password);
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser firebaseUser) {
    if (firebaseUser == null) {
      return null;
    }
    return User(uid: firebaseUser.uid, displayName: firebaseUser.displayName, photoUrl: firebaseUser.photoUrl);
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
    AuthResult result = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(result.user);
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
      if (authentication.idToken != null &&
          authentication.accessToken != null) {
        AuthResult result = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.getCredential(
                idToken: authentication.idToken,
                accessToken: authentication.accessToken));
        return _userFromFirebase(result.user);
      }
      throw PlatformException(
        code: "MISSING_GOOGLE_AUTH_TOKEN",
        message: "Google sign in failed",
      );
    } else {
      throw PlatformException(
        code: "GOOGLE_SIGNIN_ABORTED",
        message: "Sign in aborted",
      );
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    FacebookLoginResult result =
        await facebookLogin.logInWithReadPermissions(['public_profile']);
    if (result.accessToken != null) {
      AuthResult authResult = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.getCredential(
              accessToken: result.accessToken.token));
      return _userFromFirebase(authResult.user);
    } else {
      throw PlatformException(code: "FACEBOOK_TOKEN_ERROR", message: "Facebook access token error");
    }
  }

  @override
  Future<User> createAccount(String email, String password) async {
    AuthResult result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(result.user);
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    AuthResult result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(result.user);
  }
}
