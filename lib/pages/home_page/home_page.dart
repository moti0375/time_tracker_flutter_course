import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/pages/home_page/cupertino_home_scaffold.dart';
import 'package:time_tracker_flutter_course/pages/tabs/tabs_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem tab = TabItem.jobs;

  void _select(TabItem tabItem) {
    setState(() {
      tab = tabItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoHomeScaffold(
      currentTab: tab,
      onSelectTab: _select,
    );
  }


}
