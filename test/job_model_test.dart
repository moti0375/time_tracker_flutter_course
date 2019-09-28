import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/models/job.dart';


void main(){

  group("FromMap", (){

    test('Null Data', (){
      final job = Job.fromMap(null, 'abc');
      expect(job, null);
    });

    test('Valid Data', (){
      final name = "Development";
      final rate = 80;
      final id = '100';
      final jobMap =  <String, dynamic>{'name': name, 'ratePerHour': rate};
      final jobFromMap = Job.fromMap(jobMap, id);
//      expect(jobFromMap.id, id);
//      expect(jobFromMap.name, name);
//      expect(jobFromMap.ratePerHour, rate);

      expect(jobFromMap, Job(name: name, id: id, ratePerHour: rate));
    });

    test('Missing values', (){
      final name = "Development";
      final rate = 80;
      final id = '100';
      final noNameMap =  <String, dynamic>{'ratePerHour': rate};
      final noRateMap =  <String, dynamic>{'name': name};
      final noNameFromMap = Job.fromMap(noNameMap, id);
      final noRateFromMap = Job.fromMap(noRateMap, id);

      expect(noNameFromMap, null);
      expect(noRateFromMap, null);
    });
  });

  group("ToMap", (){
    test('Null Data', (){
      final name = "Training";
      final rate = 45;
      final id = 'abc';

      final job = Job(id: id, name: name, ratePerHour: rate);
      final map = job.toMap();

      expect(map['name'], name);
      expect(map['ratePerHour'], rate);
    });
  });



}