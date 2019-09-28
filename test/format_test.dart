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
  
  group("Day of week - IT Local", (){
    setUp(() async {
      Intl.defaultLocale = 'it_IT';
      await initializeDateFormatting(Intl.defaultLocale);
    });

    test("Day of week today", (){
      expect(Format.dayOfWeek(DateTime.now()), 'sab');
    });


    test("Day of week Sunday", (){
      expect(Format.dayOfWeek(DateTime(2019, 9, 29)), 'dom');
    });

  });

  group("Day of week - HE Local", (){
    setUp(() async {
      Intl.defaultLocale = 'he_HE';
      await initializeDateFormatting(Intl.defaultLocale);
    });

    test("Day of week today", (){
      expect(Format.dayOfWeek(DateTime.now()), 'שבת');
    });


    test("Day of week Sunday", (){
      expect(Format.dayOfWeek(DateTime(2019, 9, 29)), 'יום א׳');
    });

  });


  group("Currency US Local", (){
    setUp(() async {
      Intl.defaultLocale = 'en_US';
      await initializeDateFormatting(Intl.defaultLocale);
    });

    test("100\$", (){
      expect(Format.currency(100.0), '\$100');
    });


    test("1000\$", (){
      expect(Format.currency(1000.0), '\$1,000');
    });

    test("0 currency", (){
      expect(Format.currency(0), '');
    });

  });
}