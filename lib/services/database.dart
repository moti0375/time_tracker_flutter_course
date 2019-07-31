import 'package:meta/meta.dart';
import 'package:time_tracker_flutter_course/pages/jobs/models/job.dart';
import 'package:time_tracker_flutter_course/services/api_path.dart';
import 'package:time_tracker_flutter_course/services/firestore_service.dart';

abstract class Database {
  Future<void> setJob(Job job);

  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase implements Database {
  final String uid;
  final FirestoreService _service = FirestoreService.instance;

  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  Future<void> setJob(Job job) async => await _service.setData(
        ApiPath.job(uid, job.id),
        job.toMap(),
      );

  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: ApiPath.jobs(uid),
        builder: (data, docId) => Job.fromMap(data, docId),
      );

}
