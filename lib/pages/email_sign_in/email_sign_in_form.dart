import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter_course/pages/email_sign_in/email_sign_in_model.dart';
import 'package:time_tracker_flutter_course/pages/email_sign_in/email_sing_in_bloc.dart';

class EmailSignInForm extends StatefulWidget {
  final EmailSignInBloc emailSignInBloc;

  EmailSignInForm({@required this.emailSignInBloc});

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  Future<void> _submit() async {
    print('_submit called');

    print("email: ${_emailController.text}, "
        "password: ${_passwordController.text}");

    try {
      await widget.emailSignInBloc.submit();
      Navigator.of(context).pop();
    } catch (e) {
      print("There was an error: ${e.toString()}");
      PlatformAlertDialog platformAlertDialog = PlatformAlertDialog(
          title: "Sign in failed",
          content: e.toString(),
          defaultActionText: 'OK',
          actions: _buildActions());
      platformAlertDialog.show(context).then((selection) {});
    }
    return;
  }

  void _emailEditComplete(BuildContext context, EmailSignInModel model) {
    print("Email edit completed: ${model.email}");

    widget.emailSignInBloc.updateWith(submitted: false);
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _passwordEditCompleted() {
    _submit();
  }

  void _toggleFormType() {
    widget.emailSignInBloc.toggleFormType();

    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    print(
        "_buildChildren: submit enabled: ${model.enableSubmit}, model is loading: ${model.isLoading}");

    return [
      _buildEmailInputField(model),
      SizedBox(height: 8),
      _buildPasswordInputField(model),
      SizedBox(height: 8),
      FormSubmitButton(
        text: model.primaryText,
        onPressed: model.enableSubmit ? () => _submit() : null,
        isLoading: model.isLoading,
      ),
      SizedBox(height: 8),
      FlatButton(
        child: Text(model.secondaryText),
        onPressed: model.isLoading ? null : _toggleFormType,
      )
    ];
  }

  TextField _buildPasswordInputField(EmailSignInModel model) {
    return TextField(
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        errorText: model.passwordErrorText,
        enabled: model.isLoading ? false : true,
      ),
      autocorrect: false,
      onEditingComplete: () => _passwordEditCompleted(),
      onChanged: widget.emailSignInBloc.updatePassword,
    );
  }

  TextField _buildEmailInputField(EmailSignInModel model) {
    return TextField(
      focusNode: _emailFocusNode,
      controller: _emailController,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Test@Test.com",
        errorText: model.emailErrorText,
        enabled: model.isLoading ? false : true,
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _emailEditComplete(context, model),
      onChanged: widget.emailSignInBloc.updateEmail,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
      stream: widget.emailSignInBloc.modelStream,
      initialData: EmailSignInModel(),
      builder: (context, snapshot) {
        final EmailSignInModel model = snapshot.data;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: _buildChildren(model),
          ),
        );
      },
    );
  }

  List<Widget> _buildActions() {
    return [
      PlatformAlertDialogAction(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          })
    ];
  }
}
