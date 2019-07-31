import 'package:meta/meta.dart';
class Job{
  final String name;
  final int ratePerHour;
  final String id;

  Job({@required this.id, @required this.name, @required this.ratePerHour});
  factory Job.fromMap(Map<String, dynamic> map, String id){
    if(map == null){
      return null;
    }

    String name = map['name'];
    int ratePerHour = map['ratePerHour'];

    return Job(name: name, ratePerHour: ratePerHour, id: id);
  }

  Map<String, dynamic> toMap(){
    return {'name': name, 'ratePerHour' : ratePerHour};
  }
}