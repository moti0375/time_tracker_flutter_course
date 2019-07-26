import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:time_tracker_flutter_course/pages/jobs/models/job.dart';
import 'package:time_tracker_flutter_course/services/api_path.dart';

abstract class Database {
  Future<void> createJob(Job job);
}

class FirestoreDatabase implements Database {
  final String uid;

  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  Future<void> createJob(Job job) async {
    final path = ApiPath.job(uid, 'job_abc');
    final documentReference = Firestore.instance.document(path);
    await documentReference.setData(job.toMap());
  }
}
