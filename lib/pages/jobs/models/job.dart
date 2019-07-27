import 'package:meta/meta.dart';
class Job{
  final String name;
  final int ratePerHour;

  Job({@required this.name, @required this.ratePerHour});
  factory Job.fromMap(Map<String, dynamic> map){
    if(map == null){
      return null;
    }

    String name = map['name'];
    int ratePerHour = map['ratePerHour'];

    return Job(name: name, ratePerHour: ratePerHour);
  }

  Map<String, dynamic> toMap(){
    return {'name': name, 'ratePerHour' : ratePerHour};
  }
}