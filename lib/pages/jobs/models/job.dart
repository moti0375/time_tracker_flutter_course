import 'package:meta/meta.dart';
class Job{
  final String name;
  final int ratePerHour;

  Job({@required this.name, @required this.ratePerHour});

  Map<String, dynamic> toMap(){
    return {'name': name, 'ratePerHour' : ratePerHour};
  }

  static Job fromMap(Map<String, dynamic> map){
    return Job(name: map["name"], ratePerHour: map["ratePerHour"]);
  }
}