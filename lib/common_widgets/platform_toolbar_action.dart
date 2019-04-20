import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';

class PlatformFlatButton extends PlatformWidget {
  final String title;
  final VoidCallback onPressed;

  PlatformFlatButton({@required this.title, @required this.onPressed})
      : assert(title != null),
        assert(onPressed != null);

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return FlatButton(
      child: Text(
        title,
        style: TextStyle(
          color: CupertinoTheme.of(context).textTheme.actionTextStyle.color,
        ),
      ),
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(
      child: Text(
        title,
        style: TextStyle(color: Theme.of(context).primaryTextTheme.title.color),
      ),
      onPressed: onPressed,
    );
  }
}
