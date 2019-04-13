import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/form_submit_button.dart';

enum EmailSignInFromType { signIn, register }

class EmailSignInForm extends StatefulWidget {
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  EmailSignInFromType _formType = EmailSignInFromType.signIn;

  void _submit() {
    print(
        "email: ${_emailController.text}, password: ${_passwordController.text}");
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFromType.signIn ? EmailSignInFromType.register : EmailSignInFromType.signIn;
      _emailController.clear();
      _passwordController.clear();
    });
  }

  List<Widget> _buildChildren() {
    final String _primaryText = _formType == EmailSignInFromType.signIn
        ? 'Sign In'
        : 'Create an account';
    final String _secondaryText = _formType == EmailSignInFromType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
    return [
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: "Email",
          hintText: "Test@Test.com",
        ),
      ),
      SizedBox(height: 8),
      TextField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
        ),
      ),
      SizedBox(height: 8),
      FormSubmitButton(
        text: _primaryText,
        onPressed: _submit,
      ),
      SizedBox(height: 8),
      FlatButton(
        child: Text(_secondaryText),
        onPressed: _toggleFormType,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
