import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_toolbar.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_toolbar_action.dart';
import 'package:time_tracker_flutter_course/models/job.dart';
import 'package:time_tracker_flutter_course/pages/job_entries/job_entries_page.dart';
import 'package:time_tracker_flutter_course/pages/jobs/edit_job_page.dart';
import 'package:time_tracker_flutter_course/pages/jobs/empty_content.dart';
import 'package:time_tracker_flutter_course/pages/jobs/job_list_tile.dart';
import 'package:time_tracker_flutter_course/utils/list_item_builder.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/services/database.dart';
import 'package:flutter/services.dart';

class JobsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text("Jobs"),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => EditJobPage.show(
            context,
            database: Provider.of<Database>(context),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: _buildContent(context),
    );
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
    //print("JobsPage: _buildContent");
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
        stream: database.jobsStream(),
        builder: (context, snapshot) {
          return ListItemsBuilder<Job>(
            snapshot: snapshot,
            itemBuilder: (context, job) => Dismissible(
              key: Key("job-${job.id}"),
              background: Container(
                color: Colors.red,
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => _delete(context, job),
              child: JobListTile(
                job: job,
                onTap: () {
                  print("JobListTile: onTap");
                  JobEntriesPage.show(context: context, job: job);
                },
              ),
            ),
          );
        });
  }
}
