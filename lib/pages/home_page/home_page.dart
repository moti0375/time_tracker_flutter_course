import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/pages/account/account_page.dart';
import 'package:time_tracker_flutter_course/pages/entries/entries_page.dart';
import 'package:time_tracker_flutter_course/pages/home_page/cupertino_home_scaffold.dart';
import 'package:time_tracker_flutter_course/pages/job_entries/entry_page.dart';
import 'package:time_tracker_flutter_course/pages/jobs/jobs_page.dart';
import 'package:time_tracker_flutter_course/pages/tabs/tabs_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem tab = TabItem.jobs;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.jobs: GlobalKey<NavigatorState>(),
    TabItem.entries: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>()
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.jobs: (context) => JobsPage(),
      TabItem.entries: (context) => EntriesPage.create(context),
      TabItem.account: (context) => AccountPage()
    };
  }

  void _select(TabItem tabItem) {
    if (tabItem == tab) {
      navigatorKeys[tab].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        tab = tabItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await navigatorKeys[tab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: tab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigationKeys: navigatorKeys,
      ),
    );
  }


}
