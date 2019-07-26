import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {

  static const _defaultError = "There was an error\nPlease try again later";

  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
    @required List<Widget> actions,
  }) : super(title: title, content: _message(exception), defaultActionText: "OK", actions: actions);

  static String _message(PlatformException exception){
    if(exception.message.contains("PERMISSION_DENIED") || exception.message.contains("FIRFirestoreErrorDomain")){
      return "Missing or insufficient permissions";
    }
    print("_message: Error code: ${exception.code}, Error Message: ${exception.message}");
    return _errors[exception.code.trim()] ?? _defaultError;
  }

  static Map<String, String> _errors = {
//  "ERROR_WEAK_PASSWORD",
  "ERROR_INVALID_EMAIL": "Invalid email or password",
  "ERROR_EMAIL_ALREADY_IN_USE": "This email already taken\n",
  "ERROR_INVALID_EMAIL": "Invalid email",
  "ERROR_WRONG_PASSWORD": "Invalid email or password",
  "ERROR_USER_NOT_FOUND": "No account was for this email",
  "GOOGLE_SIGNIN_ABORTED": "Google sign in aborted",
  "MISSING_GOOGLE_AUTH_TOKEN": "Failed to sign in with Google",
  "FACEBOOK_TOKEN_ERROR": "Facebook access token error",
  "Error 7": "Missing or insufficient permissions"
  };
}
