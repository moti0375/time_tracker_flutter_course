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

  Future<void> pumpEmailSignInForm(
      WidgetTester tester, {VoidCallback onSignIn}) async {
    await tester.pumpWidget(
      Provider<BaseAuth>(
        builder: (_) => mockAuth,
        child: MaterialApp(
          home: Scaffold(
            body: EmailSignInFormStful(
              onSignIn: onSignIn,
            ),
          ),
        ),
      ),
    );
  }

  group('sign in', () {
    testWidgets('Click sign in when no email and passwrod',
        (WidgetTester tester) async {
      var signedIn = false;
      await pumpEmailSignInForm(tester, onSignIn: () => signedIn = true);
      final signInButton = find.text('Sign In');
      await tester.tap(signInButton);

      verifyNever(mockAuth.signInWithEmailAndPassword(any, any));
      expect(signedIn, false);
    });

    testWidgets('User enters email and passwrod', (WidgetTester tester) async {
      const email = 'moti@gmail.com';
      const password = 'password';

      var singedIn = false;
      await pumpEmailSignInForm(tester, onSignIn: () => singedIn = true);

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
      expect(singedIn, true);
    });
  });

  group('Register', () {
    testWidgets('Set register mode', (WidgetTester tester) async {
      await pumpEmailSignInForm(tester);
      final modeButton = find.byKey(Key("formMode"));
      await tester.tap(modeButton);

      await tester.pump();

      final registerButton = find.text('Create an account');
      expect(registerButton, findsOneWidget);
//          await tester.tap(registerButton);

//          verifyNever(mockAuth.createAccount(any, any));
    });

    testWidgets('User create account', (WidgetTester tester) async {
      const email = 'moti@gmail.com';
      const password = 'password';

      await pumpEmailSignInForm(tester);
      final modeButton = find.byKey(Key("formMode"));
      await tester.tap(modeButton);
      await tester.pump();

      final emailInputField = find.byKey(Key('email'));
      expect(emailInputField, findsOneWidget);
      await tester.enterText(emailInputField, email);

      final passwordInputField = find.byKey(Key('password'));
      expect(passwordInputField, findsOneWidget);
      await tester.enterText(passwordInputField, password);

      await tester.pump();

      final registerButton = find.text('Create an account');
      await tester.tap(registerButton);

      verify(mockAuth.createAccount(email, password)).called(1);
    });
  });
}
