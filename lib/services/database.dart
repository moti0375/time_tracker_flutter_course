import 'package:meta/meta.dart';
import 'package:time_tracker_flutter_course/models/entry.dart';
import 'package:time_tracker_flutter_course/models/job.dart';
import 'package:time_tracker_flutter_course/services/api_path.dart';
import 'package:time_tracker_flutter_course/services/firestore_service.dart';

abstract class Database {
  //Jobs
  Future<void> setJob(Job job);
  Stream<List<Job>> jobsStream();
  Future<void> deleteJob(Job job);

  //Entries
  Future<void> deleteEntry(Entry entry);
  Future<void> setEntry(Entry entry);
  Stream<List<Entry>> entriesStream({Job job});
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  final String uid;
  final FirestoreService _service = FirestoreService.instance;

  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  @override
  Future<void> setJob(Job job) async => await _service.setData(path:
        ApiPath.job(uid, job.id),
        data: job.toMap(),
      );

  @override
  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: ApiPath.jobs(uid),
        builder: (data, docId) => Job.fromMap(data, docId),
      );


  @override
  Future<void> deleteJob(Job job) async => await _service.deleteData(path: ApiPath.job(uid, job.id));

  @override
  Future<void> deleteEntry(Entry entry) {
    // TODO: implement deleteEntry
    return null;
  }

  @override
  Future<void> setEntry(Entry entry) {
    // TODO: implement setEntry
    return null;
  }

  @override
  Stream<List<Entry>> entriesStream({Job job}) {
    // TODO: implement entriesStream
    return null;
  }


}
