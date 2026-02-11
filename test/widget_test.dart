// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:veteranapp/main.dart';

void main() {
  testWidgets('Login screen displays correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VeteranApp());

    // Verify that the login screen is displayed
    expect(find.text('Veteran App'), findsOneWidget);
    expect(find.text('Continue with Facebook'), findsOneWidget);
    expect(find.text('Continue with Apple'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.text('Log in with email'), findsOneWidget);
    expect(find.text("Don't have an account? "), findsOneWidget);
  });

  testWidgets('Email login form displays when button is tapped', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VeteranApp());

    // Find and tap the "Log in with email" button
    await tester.tap(find.text('Log in with email'));
    await tester.pumpAndSettle();

    // Verify that the email login form is displayed
    expect(find.text('Email address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Forgot your password?'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);
  });
}
