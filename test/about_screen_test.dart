import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/screens/about_screen.dart';

void main() {
  testWidgets('About screen displays app information', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AboutScreen(),
      ),
    );

    // Verify the main components are displayed
    expect(find.text('VeteranApp'), findsOneWidget);
    expect(find.text('Version 1.0.0'), findsOneWidget);
    expect(find.byIcon(Icons.military_tech), findsOneWidget);
  });

  testWidgets('About screen displays description', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AboutScreen(),
      ),
    );

    // Verify the description section is displayed
    expect(find.text('About VeteranApp'), findsOneWidget);
    expect(find.textContaining('VeteranApp is a comprehensive application'), findsOneWidget);
  });

  testWidgets('About screen displays features section', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AboutScreen(),
      ),
    );

    // Verify the features section is displayed
    expect(find.text('Features'), findsOneWidget);
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Member Directory'), findsOneWidget);
    expect(find.text('Hosting Schedule'), findsOneWidget);
    expect(find.text('Activity Statistics'), findsOneWidget);
    expect(find.text('Constitution'), findsOneWidget);
  });

  testWidgets('About screen displays contact information', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AboutScreen(),
      ),
    );

    // Verify the contact section is displayed
    expect(find.text('Contact & Support'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('support@veteranapp.com'), findsOneWidget);
    expect(find.text('Website'), findsOneWidget);
    expect(find.text('www.veteranapp.com'), findsOneWidget);
  });

  testWidgets('About screen displays legal section', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AboutScreen(),
      ),
    );

    // Verify the legal section is displayed
    expect(find.text('Legal'), findsOneWidget);
    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(find.text('Terms of Service'), findsOneWidget);
    expect(find.text('Open Source Licenses'), findsOneWidget);
  });

  testWidgets('About screen displays copyright', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AboutScreen(),
      ),
    );

    // Verify the copyright is displayed
    expect(find.text('© 2026 VeteranApp. All rights reserved.'), findsOneWidget);
  });

  testWidgets('About screen has AppBar with title', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AboutScreen(),
      ),
    );

    // Verify the AppBar is displayed
    expect(find.widgetWithText(AppBar, 'About'), findsOneWidget);
  });
}
