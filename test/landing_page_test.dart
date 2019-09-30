import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test/flutter_test.dart' as prefix0;
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/pages/home_page/home_page.dart';
import 'package:time_tracker_flutter_course/pages/landing/landing_page.dart';
import 'package:time_tracker_flutter_course/pages/sign_in_page/sign_in_page.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

import 'email_sign_in_stful_test.dart';

void main() {
  MockAuth mockAuth;
  StreamController<User> onUserChangedController;

  setUp(() {
    mockAuth = MockAuth();
    onUserChangedController = StreamController<User>();
  });

  tearDownAll((){
    onUserChangedController.close();
  });

  Future<void> pumpLandingPage(WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<BaseAuth>(
        builder: (_) => mockAuth,
        child: MaterialApp(
          home: Scaffold(
            body: LandingPage(),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  void stubOnAuthStateChangedSteram(Iterable<User> onAuthUsers) {
    onUserChangedController.addStream(Stream<User>.fromIterable(onAuthUsers));
    when(mockAuth.onAuthStateChanged).thenAnswer(
      (_) => onUserChangedController.stream,
    );
  }

  group('Landing page', (){
    testWidgets('Waiting', (WidgetTester tester) async {
      await pumpLandingPage(tester);
      stubOnAuthStateChangedSteram([]);
      var progressIndicator = find.byKey(Key("ProgressIndicator"));
      expect(progressIndicator, findsOneWidget);
    });

    testWidgets("Null user", (WidgetTester tester) async {
      stubOnAuthStateChangedSteram([null]);
      await pumpLandingPage(tester);

      var signInPage = find.byType(SignInPage);
      expect(signInPage, findsOneWidget);
    });

    testWidgets("Valid User", (WidgetTester tester) async {
      final user = User(uid: '123', displayName: "Mark");
      stubOnAuthStateChangedSteram([user]);
      await pumpLandingPage(tester);

      var homePage = find.byType(HomePage);
      expect(homePage, findsOneWidget);
    });
  });


}

