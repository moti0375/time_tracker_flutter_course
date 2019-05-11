import 'package:time_tracker_flutter_course/utils/validators.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidators{
  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.isSubmited = false,
  });

  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool isSubmited;

  String get primaryText {
    return formType == EmailSignInFormType.register ? "Create an account" : "Login";
  }

  String get secondaryText {
    return formType == EmailSignInFormType.signIn ? 'Need an account? Register'
        : 'Have an account? Sign in';
  }

  bool get enableSubmit {
    return emailValidator.isValid(email) && passwordValidator.isValid(password) && !isLoading;
  }

  String get passwordErrorText {
    return (isSubmited && !passwordValidator.isValid(password)) ? invalidPasswordText : null ;
  }

  String get emailErrorText {
    return (isSubmited && !emailValidator.isValid(email)) ? invalidEmailText : null ;
  }

  EmailSignInModel copy(
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool isSubmitted,
  ) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      isSubmited: isSubmitted ?? this.isSubmited
    );
  }
}
