import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/utils/validators.dart';

enum EmailSignInFromType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
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
  bool _submitted = false;
  bool _loggingIn = false;

  void _submit() async {
    print('_submit called');
    setState(() {
      _submitted = true;
      _loggingIn = true;
    });

    print("email: ${_emailController.text}, "
        "password: ${_passwordController.text}");

    try {
      await Future.delayed(Duration(seconds: 5)); //Simulating a slow network
      if (_formType == EmailSignInFromType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createAccount(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print("There was an error: ${e.toString()}");
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Sign in failed"),
              content: Text(e.toString()),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    } finally {
      setState(() {
        _loggingIn = false;
      });
    }
  }

  void _emailEditComplete() {
    print("Email edit completed");
//    setState(() {
//      _submitted = true;
//    });

    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _passwordEditCompleted() {
    _submit();
  }

  void _updateForm() {
    setState(() {
      _submitted = false;
    });
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFromType.signIn
          ? EmailSignInFromType.register
          : EmailSignInFromType.signIn;
      _emailController.clear();
      _passwordController.clear();
    });
  }

  List<Widget> _buildChildren() {
    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password);

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
        onPressed: _loggingIn ? null : submitEnabled ? _submit : null,
        isLoading: _loggingIn,
      ),
      SizedBox(height: 8),
      FlatButton(
        child: Text(_secondaryText),
        onPressed: _loggingIn ? null : _toggleFormType,
      )
    ];
  }

  TextField _buildPasswordInputField() {
    bool _showErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        errorText: _showErrorText ? widget.invalidPasswordText : null,
        enabled: _loggingIn ? false : true,
      ),
      autocorrect: false,
      onEditingComplete: _passwordEditCompleted,
      onChanged: (password) => _updateForm(),
    );
  }

  TextField _buildEmailInputField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      focusNode: _emailFocusNode,
      controller: _emailController,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Test@Test.com",
        errorText: showErrorText ? widget.invalidEmailText : null,
        enabled: _loggingIn ? false : true,
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
