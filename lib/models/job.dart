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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Job &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              ratePerHour == other.ratePerHour &&
              id == other.id;

  @override
  int get hashCode =>
      name.hashCode ^
      ratePerHour.hashCode ^
      id.hashCode;


}