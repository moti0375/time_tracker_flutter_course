import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_widget.dart';

class PlatformToolbar extends PlatformWidget {
  final Widget title;
  final List<Widget> actions;

  PlatformToolbar({this.title, this.actions});

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    Widget trailing = actions[0];
    print("Trailing: $trailing");
    return CupertinoNavigationBar(
      middle: title,
      trailing: trailing,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AppBar(
      title: title,
      actions: actions,
    );
  }
}
