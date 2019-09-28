import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/utils/validators.dart';
void main(){
  
  test("None Empty String Test", (){
    final validator = NonEmptyStringValidator();
    expect(validator.isValid('test'), true);
  });

  test("Empty String Test", (){
    final validator = NonEmptyStringValidator();
    expect(validator.isValid(''), false);
  });
}