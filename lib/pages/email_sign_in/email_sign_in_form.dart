import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/form_submit_button.dart';

class EmailSignInForm extends StatelessWidget {

  String email;

  void _submit(){
    print("submit: $email");
  }


  List<Widget> _buildChildren() {
    return [
      TextField(
        decoration: InputDecoration(
          labelText: "Email",
          hintText: "Test@Test.com",
        ),
        onChanged: (value) => email = value,
      ),
      SizedBox(height: 8),
      TextField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
        ),
      ),
      SizedBox(height: 8),
      FormSubmitButton(
        text: "Sign In",
        onPressed: _submit,
      ),
      SizedBox(height: 8),
      FlatButton(
        child: Text("Create an account"),
        onPressed: () {},
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
