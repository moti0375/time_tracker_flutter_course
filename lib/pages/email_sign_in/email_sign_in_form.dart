import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

enum EmailSignInFromType { signIn, register }

class EmailSignInForm extends StatefulWidget {
  final BaseAuth auth;

  EmailSignInForm({@required this.auth});

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  EmailSignInFromType _formType = EmailSignInFromType.signIn;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  void _submit() async {
    print("email: ${_emailController.text}, "
        "password: ${_passwordController.text}");

    try {
      if (_formType == EmailSignInFromType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createAccount(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print("There was an error: ${e.toString()}");
    }
  }

  void _emailEditComplete() {
    print("Email edit completed");
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _passwordEditCompleted() {
    _submit();
  }

  void _updateForm() {setState((){});}

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFromType.signIn
          ? EmailSignInFromType.register
          : EmailSignInFromType.signIn;
      _emailController.clear();
      _passwordController.clear();
    });
  }

  List<Widget> _buildChildren() {
    bool submitEnabled = _email.isNotEmpty && _password.isNotEmpty;


    final String _primaryText = _formType == EmailSignInFromType.signIn
        ? 'Sign In'
        : 'Create an account';
    final String _secondaryText = _formType == EmailSignInFromType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
    return [
      _buildEmailInputField(),
      SizedBox(height: 8),
      _buildPasswordInputField(),
      SizedBox(height: 8),
      FormSubmitButton(
        text: _primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      SizedBox(height: 8),
      FlatButton(
        child: Text(_secondaryText),
        onPressed: _toggleFormType,
      )
    ];
  }

  TextField _buildPasswordInputField() {
    return TextField(
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
      ),
      autocorrect: false,
      onEditingComplete: _passwordEditCompleted,
      onChanged: (password) => _updateForm(),
    );
  }

  TextField _buildEmailInputField() {
    return TextField(
      focusNode: _emailFocusNode,
      controller: _emailController,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Test@Test.com",
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditComplete,
      onChanged: (email) => _updateForm(),
    );
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
