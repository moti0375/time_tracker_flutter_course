import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';

class PlatformFlatButton extends PlatformWidget {
  final Widget title;
  final VoidCallback onPressed;

  PlatformFlatButton({@required this.title, @required this.onPressed})
      : assert(title != null),
        assert(onPressed != null);

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoButton(
      child: title,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(
      textColor: Theme.of(context).primaryTextTheme.title.color,
      child: title,
      onPressed: onPressed,
    );
  }
}
