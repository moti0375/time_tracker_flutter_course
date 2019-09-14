import 'package:meta/meta.dart';
import 'package:time_tracker_flutter_course/models/entry.dart';
import 'package:time_tracker_flutter_course/models/job.dart';
import 'package:time_tracker_flutter_course/services/api_path.dart';
import 'package:time_tracker_flutter_course/services/firestore_service.dart';

abstract class Database {
  //Jobs
  Future<void> setJob(Job job);

  Stream<List<Job>> jobsStream();

  Stream<Job> jobStream({@required String jobId});

  Future<void> deleteJob(Job job);

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
  Future<void> setJob(Job job) async => await _service.setData(
        path: ApiPath.job(uid, job.id),
        data: job.toMap(),
      );

  @override
  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: ApiPath.jobs(uid),
        builder: (data, docId) => Job.fromMap(data, docId),
      );

  @override
  Stream<Job> jobStream({@required String jobId}) => _service.documentStream(
        path: ApiPath.job(uid, jobId),
        builder: (data, documentId) => Job.fromMap(data, documentId),
      );

  @override
  Future<void> deleteJob(Job job) async {
    final allEntries = await entriesStream(job: job).first;

    return await _service
        .deleteData(path: ApiPath.job(uid, job.id))
        .then((val) {
      //Delete all entries for the deleted job
      for (Entry entry in allEntries) {
        if (entry.jobId == job.id) {
          deleteEntry(entry);
        }
      }
    });
  }

  @override
  Future<void> deleteEntry(Entry entry) async =>
      await _service.deleteData(path: ApiPath.entry(uid, entry.id));

  @override
  Future<void> setEntry(Entry entry) async => await _service.setData(
      path: ApiPath.entry(uid, entry.id), data: entry.toMap());

  @override
  Stream<List<Entry>> entriesStream({Job job}) =>
      _service.collectionStream<Entry>(
        path: ApiPath.entries(uid),
        queryBuilder: job != null
            ? (query) => query.where('jobId', isEqualTo: job.id)
            : null,
        builder: (data, documentID) => Entry.fromMap(data, documentID),
        sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
      );
}
