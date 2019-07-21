import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/common_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/pages/email_sign_in/email_sign_in_change_model.dart';
import 'package:time_tracker_flutter_course/pages/email_sign_in/email_sign_in_model.dart';
import 'package:time_tracker_flutter_course/pages/email_sign_in/email_sing_in_bloc.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class EmailSignInFormChangeNotifier extends StatefulWidget {
  final EmailSignInChangeModel model;

  EmailSignInFormChangeNotifier({@required this.model});

  @override
  _EmailSignInFormChangeNotifierState createState() => _EmailSignInFormChangeNotifierState();

  static Widget create(BuildContext context) {
    final BaseAuth auth = Provider.of<BaseAuth>(context);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      builder: (context) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (context, model, _) => EmailSignInFormChangeNotifier(
          model: model,
        ),
      ),
    );
  }
}

class _EmailSignInFormChangeNotifierState extends State<EmailSignInFormChangeNotifier> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  EmailSignInChangeModel get model => widget.model;

  Future<void> _submit() async {
    print('EmailSignInFormBlocBased _submit called');

    print("email: ${_emailController.text}, "
        "password: ${_passwordController.text}");

    try {
      await model.submit();
      Navigator.of(context).pop(); //This will close the keyboard
    } on PlatformException catch (e) {
      print("There was an error: ${e.toString()}");
      PlatformExceptionAlertDialog platformAlertDialog = PlatformExceptionAlertDialog(
          title: "Sign in failed",
          exception: e,
          actions: _buildActions());
      platformAlertDialog.show(context).then((selection) {});
    }
    return;
  }

  void _emailEditComplete(BuildContext context) {
    print("Email edit completed: ${model.email}");

    model.updateWith(isSubmitted: false);
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _passwordEditCompleted() {
    _submit();
  }

  void _toggleFormType() {
    model.toggleFormType();

    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    print(
        "_buildChildren: submit enabled: ${model.enableSubmit}, model is loading: ${model.isLoading}");

    return [
      _buildEmailInputField(),
      SizedBox(height: 8),
      _buildPasswordInputField(),
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

  TextField _buildPasswordInputField() {
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
      onChanged: model.updatePassword,
    );
  }

  TextField _buildEmailInputField() {
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
      onEditingComplete: () => _emailEditComplete(context),
      onChanged: model.updateEmail,
    );
  }


  @override
  void dispose() {
    _emailFocusNode.dispose();
    _emailController.dispose();
    _passwordFocusNode.dispose();
    _passwordController.dispose();
    super.dispose();
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
