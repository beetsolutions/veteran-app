import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/screens/login_screen.dart';
import 'package:veteranapp/screens/home_screen.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    testWidgets('should display username and password fields', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Verify username field is present
      expect(find.widgetWithText(TextFormField, 'Username'), findsOneWidget);
      
      // Verify password field is present
      expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
    });

    testWidgets('should display login button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      expect(find.widgetWithText(ElevatedButton, 'Log In'), findsOneWidget);
    });

    testWidgets('should display forgot password link', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      expect(find.text('Forgot your password?'), findsOneWidget);
    });

    testWidgets('should display sign up link', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      expect(find.text("Don't have an account? "), findsOneWidget);
      expect(find.text('Sign up'), findsOneWidget);
    });

    testWidgets('should NOT display social login buttons', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Verify social login buttons are NOT present
      expect(find.text('Continue with Facebook'), findsNothing);
      expect(find.text('Continue with Apple'), findsNothing);
      expect(find.text('Continue with Google'), findsNothing);
      expect(find.text('Log in with email'), findsNothing);
    });

    testWidgets('should show validation error when submitting empty username', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Tap login button without entering credentials
      await tester.tap(find.widgetWithText(ElevatedButton, 'Log In'));
      await tester.pump();

      expect(find.text('Please enter your username'), findsOneWidget);
    });

    testWidgets('should show validation error when submitting empty password', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Enter username only
      await tester.enterText(find.widgetWithText(TextFormField, 'Username'), 'testuser');
      
      // Tap login button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Log In'));
      await tester.pump();

      expect(find.text('Please enter your password'), findsOneWidget);
    });

    testWidgets('should navigate to home screen with valid credentials', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Enter valid credentials
      await tester.enterText(find.widgetWithText(TextFormField, 'Username'), 'testuser');
      await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'password123');
      
      // Tap login button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Log In'));
      await tester.pumpAndSettle();

      // Verify navigation to HomeScreen
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('should toggle password visibility', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Find password field
      final passwordField = find.widgetWithText(TextFormField, 'Password');
      expect(passwordField, findsOneWidget);

      // Find the visibility toggle button
      final visibilityButton = find.descendant(
        of: passwordField,
        matching: find.byType(IconButton),
      );
      expect(visibilityButton, findsOneWidget);

      // Tap to toggle visibility
      await tester.tap(visibilityButton);
      await tester.pump();

      // Password should now be visible - verify by checking the icon changed
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('should display app logo and title', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      expect(find.byIcon(Icons.shield), findsOneWidget);
      expect(find.text('Veteran App'), findsOneWidget);
    });
  });
}
