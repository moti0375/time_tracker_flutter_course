import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/common_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter_course/pages/email_sign_in/email_sign_in_model.dart';
import 'package:time_tracker_flutter_course/pages/email_sign_in/email_sing_in_bloc.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/services/auth_provider.dart';
import 'package:time_tracker_flutter_course/utils/validators.dart';


class EmailSignInFormStlss extends StatelessWidget with EmailAndPasswordValidators {


  final EmailSignInBloc emailSignInBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  EmailSignInFormStlss({@required this.emailSignInBloc})

  Future<void> _submit(BuildContext context) async {
    print('_submit called');

    print("email: ${_emailController.text}, "
        "password: ${_passwordController.text}");

    try {
      await emailSignInBloc.submit();
      Navigator.of(context).pop();
    } catch (e) {
      print("There was an error: ${e.toString()}");
      PlatformAlertDialog platformAlertDialog = PlatformAlertDialog(title: "Sign in failed", content: e.toString(), defaultActionText: 'OK', actions: _buildActions(context));
      platformAlertDialog.show(context).then((selection){

      });

    } finally {

    }
  }

  void _emailEditComplete(BuildContext context) {
    print("Email edit completed");

    emailSignInBloc.updateWith(submitted: true);
    final newFocus = emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _passwordEditCompleted(BuildContext context) {
    _submit(context);
  }

  void _updateForm() {
    emailSignInBloc.updateWith(submitted: false);
  }

  void _toggleFormType() {

    emailSignInBloc.toggleFormType();

    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(BuildContext context) {
    bool submitEnabled = emailValidator.isValid(_email) &&
        passwordValidator.isValid(_password);

    final String _primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign In'
        : 'Create an account';
    final String _secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
    return [
      _buildEmailInputField(context),
      SizedBox(height: 8),
      _buildPasswordInputField(context),
      SizedBox(height: 8),
      FormSubmitButton(
        text: _primaryText,
        onPressed: () => _submit(context),
        isLoading: _loggingIn,
      ),
      SizedBox(height: 8),
      FlatButton(
        child: Text(_secondaryText),
        onPressed: _loggingIn ? null : _toggleFormType,
      )
    ];
  }

  TextField _buildPasswordInputField(BuildContext context) {
    bool _showErrorText =
        _submitted && !passwordValidator.isValid(_password);
    return TextField(
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        errorText: _showErrorText ? invalidPasswordText : null,
        enabled: _loggingIn ? false : true,
      ),
      autocorrect: false,
      onEditingComplete: () => _passwordEditCompleted(context),
      onChanged: emailSignInBloc.updatePassword,
    );
  }

  TextField _buildEmailInputField(BuildContext context) {
    bool showErrorText = _submitted && !emailValidator.isValid(_email);
    return TextField(
      focusNode: _emailFocusNode,
      controller: _emailController,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Test@Test.com",
        errorText: showErrorText ? invalidEmailText : null,
        enabled: _loggingIn ? false : true,
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _emailEditComplete(context),
      onChanged: emailSignInBloc.updateEmail,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(context),
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      PlatformAlertDialogAction(child: Text("OK"), onPressed: (){
        Navigator.of(context).pop();
      })
    ];
  }
}
