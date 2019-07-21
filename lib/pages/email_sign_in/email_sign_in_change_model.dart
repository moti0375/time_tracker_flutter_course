import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter_course/pages/email_sign_in/email_sign_in_model.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/utils/validators.dart';

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailSignInChangeModel({
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
    this.auth,
  });

  String email;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;

  final BaseAuth auth;

  String get primaryText {
    return formType == EmailSignInFormType.register
        ? "Create an account"
        : "Login";
  }

  String get secondaryText {
    return formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
  }

  bool get enableSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  String get passwordErrorText {
    return (submitted && !passwordValidator.isValid(password))
        ? invalidPasswordText
        : null;
  }

  String get emailErrorText {
    return (submitted && !emailValidator.isValid(email))
        ? invalidEmailText
        : null;
  }


  void toggleFormType() {
    final type = this.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;

    updateWith(
      email: '',
      password: '',
      formType: type,
      isLoading: false,
      isSubmitted: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email.trim());
  void updatePassword(String password) => updateWith(password: password.trim());


  Future<void> submit() async {
    print('_submit called');
    updateWith(isLoading: true, isSubmitted: true);

    print("email: ${this.email}, "
        "password: ${this.password.trim()}");

    try {
      await Future.delayed(Duration(seconds: 5)); //Simulating a slow network
      if (this.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(
            this.email, this.password);
      } else {
        await auth.createAccount(this.email, this.password);
      }
    } catch (e) {
      print("There was an error: ${e.toString()}");
      rethrow;
    } finally {
      updateWith(isLoading: false);
    }
  }

  void updateWith(
  {String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool isSubmitted,}
  ) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = isSubmitted ?? this.submitted;
    notifyListeners();
  }
}
