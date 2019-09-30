import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/pages/email_sign_in/email_sign_in_form_stful.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class MockAuth extends Mock implements BaseAuth {}

void main() {
  MockAuth mockAuth;

  setUp(() {
    mockAuth = MockAuth();
  });

  Future<void> pumpEmailSignInForm(WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<BaseAuth>(
        builder: (_) => mockAuth,
        child: MaterialApp(
          home: Scaffold(
            body: EmailSignInFormStful(),
          ),
        ),
      ),
    );
  }

  group('sign in', () {
    testWidgets('Click sign in when no email and passwrod',
        (WidgetTester tester) async {
      await pumpEmailSignInForm(tester);
      final signInButton = find.text('Sign In');
      await tester.tap(signInButton);

      verifyNever(mockAuth.signInWithEmailAndPassword(any, any));
    });

    testWidgets('User enters email and passwrod', (WidgetTester tester) async {
      const email = 'moti@gmail.com';
      const password = 'password';

      await pumpEmailSignInForm(tester);

      final emailInputField = find.byKey(Key('email'));
      expect(emailInputField, findsOneWidget);
      await tester.enterText(emailInputField, email);

      final passwordInputField = find.byKey(Key('password'));
      expect(passwordInputField, findsOneWidget);
      await tester.enterText(passwordInputField, password);

      await tester.pump();

      final singInButton = find.text('Sign In');
      await tester.tap(singInButton);

      verify(mockAuth.signInWithEmailAndPassword(email, password)).called(1);

    });
  });
}
