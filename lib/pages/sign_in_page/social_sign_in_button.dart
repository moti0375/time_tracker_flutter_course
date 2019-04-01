import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton(
      {@required String text,
      double height,
      Color color,
      Color textColor,
      @required String assetName,
      VoidCallback onPressed})
      : super(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Opacity(
                  opacity: 1,
                  child: Image.asset(assetName),
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                  ),
                ),
                Opacity(
                  opacity: 0,
                  child: Image.asset(assetName),
                ),
              ],
            ),
            borderRadius: 4,
            color: color,
            onPressed: onPressed);
}
