import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class FirestoreService{

  FirestoreService._();
  static final instance = FirestoreService._();

  Stream<List<T>> collectionStream<T>({@required String path,
    @required T builder(Map<String, dynamic> data, String id)}){
    final documentReference = Firestore.instance.collection(path);
    final snapshots = documentReference.snapshots();
    return snapshots.map(
            (snapshot) => snapshot.documents.map((doc) => builder(doc.data, doc.documentID)).toList()
    );
  }

  Future<void> setData(String path, Map<String, dynamic> data) async {
    final documentReference = Firestore.instance.document(path);
    print("FirestoreDatabase: _setData: $path: $data");
    await documentReference.setData(data);
  }
}