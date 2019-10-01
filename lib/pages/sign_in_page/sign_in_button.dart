import 'package:time_tracker_flutter_course/common_widgets/custom_raised_button.dart';
import 'package:flutter/material.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton(
      {@required String text,
      Key key,
      double height,
      Color color,
      Color textColor,
      VoidCallback onPressed})
      : super(
            key: key,
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 15,
              ),
            ),
            borderRadius: 4,
            color: color,
            onPressed: onPressed);
}
