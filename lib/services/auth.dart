import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class User{
  final String uid;
  User({@required this.uid});
}


abstract class BaseAuth{
  Stream<User> get onAuthStateChanged;
  Future<User> currentUser();
  Future<User> singInAnonymously();
  Future<void> signOut();
}

class Auth implements BaseAuth{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser firebaseUser){
    if(firebaseUser == null){
      return null;
    }
    return User(uid: firebaseUser.uid);
  }

  @override
  Stream<User> get onAuthStateChanged{
    return _firebaseAuth.onAuthStateChanged.map((firebaseUser){
      return _userFromFirebase(firebaseUser);
    });
  }


  @override
  Future<User> currentUser() async {
    FirebaseUser user =  await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  Future<User> singInAnonymously() async {
    FirebaseUser user =  await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(user);
  }

  @override
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}