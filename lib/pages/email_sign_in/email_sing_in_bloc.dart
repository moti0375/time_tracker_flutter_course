import 'dart:async';

import 'package:meta/meta.dart';
import 'package:time_tracker_flutter_course/pages/email_sign_in/email_sign_in_model.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.auth});

  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();
  final BaseAuth auth;

  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _currentModel = EmailSignInModel();

  void toggleFormType() {
    final type = _currentModel.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;

    updateWith(
      email: '',
      password: '',
      formType: type,
      loading: false,
      submitted: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email.trim());
  void updatePassword(String password) => updateWith(password: password.trim());

  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool loading,
    bool submitted,
  }) {
    _currentModel = _currentModel.copy(
      email,
      password,
      formType,
      loading,
      submitted,
    );
    //Update model and add updated model to controller
    _modelController.add(_currentModel);
  }

  Future<void> submit() async {
    print('_submit called');
    updateWith(loading: true, submitted: true);

    print("email: ${_currentModel.email}, "
        "password: ${_currentModel.password.trim()}");

    try {
      await Future.delayed(Duration(seconds: 5)); //Simulating a slow network
      if (_currentModel.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(
            _currentModel.email, _currentModel.password);
      } else {
        await auth.createAccount(_currentModel.email, _currentModel.password);
      }
    } catch (e) {
      print("There was an error: ${e.toString()}");
      rethrow;
    } finally {
      updateWith(loading: false);
    }
  }

  void dispose() {
    _modelController.close();
  }
}
