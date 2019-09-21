import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/pages/job_entries/job_entries_page.dart';
import 'package:time_tracker_flutter_course/pages/jobs/jobs_page.dart';
import 'package:time_tracker_flutter_course/pages/tabs/tabs_item.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigationKeys;

  CupertinoHomeScaffold({
    Key key,
    @required this.currentTab,
    @required this.onSelectTab,
    @required this.widgetBuilders,
    @required this.navigationKeys
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _buildItem(TabItem.jobs),
          _buildItem(TabItem.entries),
          _buildItem(TabItem.account)
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final item = TabItem.values[index];

        return CupertinoTabView(
          navigatorKey: navigationKeys[item],
          builder: (context) => widgetBuilders[currentTab](context),
        );
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem item) {
    final itemData = TabItemData.allTabs[item];
    final color = currentTab == item ? Colors.indigo : Colors.grey;
    return BottomNavigationBarItem(
      icon: Icon(
        itemData.icon,
        color: color,
      ),
      title: Text(
        itemData.title,
        style: TextStyle(color: color),
      ),
    );
  }
}
