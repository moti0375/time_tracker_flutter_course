import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker_flutter_course/pages/job_entries/format.dart';
void main(){
  group("Hours", (){
    test("positive", (){
      expect(Format.hours(10), '10h');
    });

    test("zero", (){
      expect(Format.hours(0), '0h');
    });

    test("negative", (){
      expect(Format.hours(-5), '0h');
    });

    test("decimal", (){
      expect(Format.hours(4.5), '4.5h');
    });
  });

  group("Date", (){
    setUp(() async {
      Intl.defaultLocale = 'en_GB';
      await initializeDateFormatting(Intl.defaultLocale);
    });

    test("Date today", (){
      expect(Format.date(DateTime.now()), '28 Sep 2019');
    });

    test("16 Aug", (){
      expect(Format.date(DateTime(2019, 9, 16)), '16 Aug 2019');
    });
  });
}