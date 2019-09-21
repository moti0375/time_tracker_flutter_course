import 'package:time_tracker_flutter_course/models/entry.dart';
import 'package:time_tracker_flutter_course/models/job.dart';

class EntryJob {
  EntryJob(this.entry, this.job);

  final Entry entry;
  final Job job;
}
