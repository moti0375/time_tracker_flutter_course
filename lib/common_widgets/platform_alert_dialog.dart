import 'dart:io';

import 'package:time_tracker_flutter_course/common_widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAlertDialog extends PlatformWidget {
  final String title;
  final String content;
  final String positiveActionText;
  final String negativeActionText;
  final VoidCallback onPositive;
  final VoidCallback onNegative;

  PlatformAlertDialog({
    @required this.title,
    @required this.content,
    this.positiveActionText = "OK",
    this.negativeActionText,
    @required this.onPositive,
    this.onNegative,
  })  : assert(title != null),
        assert(content != null);

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context,
            builder: (context) => this,
          )
        : await showDialog<bool>(
            barrierDismissible: false,
            context: context,
            builder: (context) => this,
          );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: negativeActionText.isEmpty
          ? _setDefaultAction(context)
          : _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: negativeActionText.isEmpty
          ? _setDefaultAction(context)
          : _buildActions(context),
    );
  }

  List<Widget> _setDefaultAction(BuildContext context) {
    return [
      PlatformAlertDialogAction(
        child: Text(positiveActionText),
        onPressed: () {
          onPositive();
          Navigator.of(context).pop();
        },
      )
    ];
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      PlatformAlertDialogAction(
        child: Text(negativeActionText),
        onPressed: () {
          Navigator.of(context).pop();
          if (onNegative != null) {
            onNegative();
          }
        },
      ),
      PlatformAlertDialogAction(
        child: Text(positiveActionText),
        onPressed: () {
          Navigator.of(context).pop();
          onPositive();
        },
      ),
    ];
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  final Widget child;
  final VoidCallback onPressed;

  PlatformAlertDialogAction({@required this.child, @required this.onPressed})
      : assert(child != null),
        assert(onPressed != null);

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    // TODO: implement buildMaterialWidget
    return FlatButton(
      child: child,
      onPressed: onPressed,
    );
  }
}
