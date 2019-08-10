
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/models/job.dart';

class JobListTile extends StatelessWidget {

  final Job job;
  final VoidCallback onTap;

  const JobListTile({@required this.job, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Icon(Icons.chevron_right),
      title: Text(job.name),
      onTap: onTap,
    );
  }
}
