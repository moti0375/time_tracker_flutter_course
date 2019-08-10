import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_toolbar.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_toolbar_action.dart';
import 'package:time_tracker_flutter_course/pages/jobs/edit_job_page.dart';
import 'package:time_tracker_flutter_course/pages/jobs/empty_content.dart';
import 'package:time_tracker_flutter_course/pages/jobs/job_list_tile.dart';
import 'package:time_tracker_flutter_course/pages/jobs/list_item_builder.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/services/database.dart';
import 'package:flutter/services.dart';

import 'models/job.dart';

class JobsPage extends StatelessWidget {
  _signOut(BuildContext context) async {
    try {
      await Provider.of<BaseAuth>(context).signOut();
    } catch (e) {
      print("_signInAnonymously: There was an error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    PlatformToolbar appBar = PlatformToolbar(
      title: Text("Jobs"),
      actions: _buildToolbarActions(context),
    );

    return Scaffold(
      appBar: appBar.build(context),
      body: _buildContent(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () => EditJobPage.show(context)),
    );
  }

  List<Widget> _buildToolbarActions(BuildContext context) {
    return <Widget>[
      PlatformFlatButton(
        title: Text("Signout"),
        onPressed: () => _showSignOutDialog(context),
      ),
    ];
  }

  Future<void> _showSignOutDialog(BuildContext context) async {
    await PlatformAlertDialog(
      title: 'Sign out?',
      content: 'Are you sure?',
      defaultActionText: "Logout",
      actions: _buildActions(context),
    ).show(context).then((selection) {
      if (selection) {
        _signOut(context);
      }
    });
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      PlatformAlertDialogAction(
          child: Text("No"),
          onPressed: () {
            Navigator.of(context).pop(false);
          }),
      PlatformAlertDialogAction(
          child: Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop(true);
          })
    ];
  }

  Future<void> _delete(BuildContext context, Job job) async {
    try {
      final database = Provider.of<Database>(context);
      await database.deleteJob(job);
    } on PlatformException catch (e) {
      PlatformAlertDialog(
        title: "there was an error",
        content: e.message,
        defaultActionText: "OK",
        actions: [],
      ).show(context);
    }
  }

  Widget _buildContent(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
        stream: database.jobsStream(),
        builder: (context, snapshot) {
          return ListItemBuilder<Job>(
            snapshot: snapshot,
            itemBuilder: (context, job) => Dismissible(
              key: Key("job-${job.id}"),
              background: Container(
                color: Colors.red,
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                _delete(context, job);
              },
              child: JobListTile(
                job: job,
                onTap: () => EditJobPage.show(context, job: job),
              ),
            ),
          );
        });
  }
}
