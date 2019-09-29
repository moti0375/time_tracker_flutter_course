import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_raised_button.dart';

void main() {
  testWidgets("OnPressed Callback", (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidget(MaterialApp(
      home: CustomRaisedButton(
        color: Colors.teal[700],
        child: Text("Tap me"),
        onPressed: () => pressed = true,
      ),
    ));

    final button = find.byType(RaisedButton);

    expect(button, findsOneWidget);
    expect(find.byType(FlatButton), findsNothing);
    expect(find.text("Tap me"), findsOneWidget);
    await tester.tap(button);
    expect(pressed, true);
  });
}
