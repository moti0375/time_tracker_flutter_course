import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/pages/home_page/cupertino_home_scaffold.dart';
import 'package:time_tracker_flutter_course/pages/tabs/tabs_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem tab = TabItem.jobs;

  @override
  Widget build(BuildContext context) {
    return CupertinoHomeScaffold(
      currentTab: tab,
      onSelectTab: (item) {

      },
    );
  }
}
