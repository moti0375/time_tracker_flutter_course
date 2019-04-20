import 'package:time_tracker_flutter_course/common_widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAlertDialog extends PlatformWidget {
  final String title;
  final String content;
  final String defaultActionText;
  final List<Widget> actions;

  PlatformAlertDialog(
      {@required this.title,
      @required this.content,
      @required this.defaultActionText,
      @required this.actions})
      : assert(title != null),
        assert(content != null),
        assert(defaultActionText != null),
        assert(actions != null);

  Future<bool> show<bool>(BuildContext context) async {
    return await showDialog(
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
      actions: actions,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: actions,
    );
  }

  List<Widget> _buildActions(BuildContext context, List<Widget> actions) {
    return [
      PlatformAlertDialogAction(
        child: Text(defaultActionText),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
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
