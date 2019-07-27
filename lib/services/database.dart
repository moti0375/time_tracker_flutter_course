import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:time_tracker_flutter_course/pages/jobs/models/job.dart';
import 'package:time_tracker_flutter_course/services/api_path.dart';

abstract class Database {
  Future<void> createJob(Job job);

  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase implements Database {
  final String uid;

  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  Future<void> createJob(Job job) async =>
      await _setData(ApiPath.job(uid, 'job_abc'), job.toMap());

  Future<void> _setData(String path, Map<String, dynamic> data) async {
    final documentReference = Firestore.instance.document(path);
    print("FirestoreDatabase: _setData: $path: $data");
    await documentReference.setData(data);
  }

  Stream<List<Job>> jobsStream() {
    final path = ApiPath.jobs(uid);
    final documentReference = Firestore.instance.collection(path);
    final snapshots = documentReference.snapshots();
    return snapshots.map(
      (snapshot) => snapshot.documents.map(
        (doc) => Job.fromMap(doc.data),
      ).toList(),
    );
  }
}
