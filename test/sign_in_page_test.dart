import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/pages/email_sign_in/email_sign_in_form_stful.dart';
import 'package:time_tracker_flutter_course/pages/email_sign_in/email_sign_in_page.dart';
import 'package:time_tracker_flutter_course/pages/sign_in_page/sign_in_page.dart';
import 'package:time_tracker_flutter_course/pages/sign_in_page/sing_in_manager.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

import 'mocks.dart';

void main(){
  MockAuth mockAuth;
  MockNavigatorObserver mockNavigatorObserver;


  setUp((){
    mockAuth = MockAuth();
    mockNavigatorObserver = MockNavigatorObserver();
  });

  Future<void> pumpSignInPage(WidgetTester tester) async {

    await tester.pumpWidget(
      Provider<BaseAuth>(
        builder: (_) => mockAuth,
        child: MaterialApp(
          home: Builder(
             builder: (context) => SignInPage.create(context),
          ),
          navigatorObservers: [mockNavigatorObserver],
        ),
      )
    );

    //await tester.pump();
  }

  group('SignIn page testing', (){
    testWidgets('EmailSignIn', (WidgetTester tester) async {
      await pumpSignInPage(tester);
      verify(mockNavigatorObserver.didPush(any, any)).called(1);

      final emailSignInButton = find.byKey(Key("EmailSignInButton"));
      expect(emailSignInButton, findsOneWidget);

      await tester.tap(emailSignInButton);
      await tester.pumpAndSettle(); //Waits any animation to complete

      verify(mockNavigatorObserver.didPush(any, any)).called(1);

      final emailSignInForm = find.byType(EmailSignInPage);
      expect(emailSignInForm, findsOneWidget);

    });
  }) ;

}