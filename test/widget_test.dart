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

  testWidgets('Back button returns to initial login view', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VeteranApp());

    // Navigate to email login form
    await tester.tap(find.text('Log in with email'));
    await tester.pumpAndSettle();

    // Tap back button
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify we're back at initial login view
    expect(find.text('Continue with Facebook'), findsOneWidget);
    expect(find.text('Log in with email'), findsOneWidget);
  });

  testWidgets('Sign up link shows not implemented message', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VeteranApp());

    // Find and tap the "Sign up" link
    await tester.tap(find.text('Sign up'));
    await tester.pump();

    // Verify SnackBar is displayed
    expect(find.text('Sign up not implemented'), findsOneWidget);
  });

  testWidgets('Social login buttons show not implemented message', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VeteranApp());

    // Test Facebook button
    await tester.tap(find.text('Continue with Facebook'));
    await tester.pump();
    expect(find.text('Facebook login not implemented'), findsOneWidget);
    
    // Dismiss snackbar
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Test Apple button
    await tester.tap(find.text('Continue with Apple'));
    await tester.pump();
    expect(find.text('Apple login not implemented'), findsOneWidget);
  });

  testWidgets('Forgot password link navigates to forgot password screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VeteranApp());

    // Navigate to email login form
    await tester.tap(find.text('Log in with email'));
    await tester.pumpAndSettle();

    // Tap forgot password link
    await tester.tap(find.text('Forgot your password?'));
    await tester.pumpAndSettle();

    // Verify we navigated to forgot password screen
    // Note: The actual verification depends on ForgotPasswordScreen implementation
    expect(find.text('Email address'), findsNothing);
  });

  testWidgets('Login form validates empty fields', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VeteranApp());

    // Navigate to email login form
    await tester.tap(find.text('Log in with email'));
    await tester.pumpAndSettle();

    // Tap login button without entering credentials
    await tester.tap(find.text('Log In'));
    await tester.pump();

    // Verify validation error messages appear
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });
}
