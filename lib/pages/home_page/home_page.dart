import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/pages/account/account_page.dart';
import 'package:time_tracker_flutter_course/pages/home_page/cupertino_home_scaffold.dart';
import 'package:time_tracker_flutter_course/pages/jobs/jobs_page.dart';
import 'package:time_tracker_flutter_course/pages/tabs/tabs_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem tab = TabItem.jobs;

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.jobs: (context) => JobsPage(),
      TabItem.entries: (context) => Container(),
      TabItem.account: (context) => AccountPage()
    };
  }

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
      widgetBuilders: widgetBuilders,
    );
  }


}
