import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_toolbar.dart';

class AddJobPage extends StatefulWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(new MaterialPageRoute(
      builder: (context) => AddJobPage(),
      fullscreenDialog: true,
    ));
  }

  @override
  State<StatefulWidget> createState() {
    return AddJobPageState();
  }
}

class AddJobPageState extends State<AddJobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlatformToolbar(
        title: Text("New Job"),
        actions: <Widget>[],
      ).build(context),
    );
  }
}
