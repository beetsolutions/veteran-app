import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/screens/tab_screens/more_tab.dart';
import 'package:veteranapp/screens/members_hosting_screen.dart';

void main() {
  testWidgets('More tab displays Members Hosting menu item', (WidgetTester tester) async {
    // Build the MoreTab widget
    await tester.pumpWidget(
      const MaterialApp(
        home: MoreTab(),
      ),
    );

    // Verify that the Members Hosting menu item is displayed
    expect(find.text('Members Hosting'), findsOneWidget);
    expect(find.byIcon(Icons.home_work), findsOneWidget);
  });

  testWidgets('Members Hosting menu item navigates to Members Hosting screen', (WidgetTester tester) async {
    // Build the MoreTab widget
    await tester.pumpWidget(
      const MaterialApp(
        home: MoreTab(),
      ),
    );

    // Find and tap the Members Hosting menu item
    await tester.tap(find.text('Members Hosting'));
    await tester.pumpAndSettle();

    // Verify that we navigated to the Members Hosting screen
    expect(find.text('Members Offering Hosting'), findsOneWidget);
  });

  testWidgets('Members Hosting screen displays correctly', (WidgetTester tester) async {
    // Build the MembersHostingScreen widget
    await tester.pumpWidget(
      const MaterialApp(
        home: MembersHostingScreen(),
      ),
    );

    // Verify that the screen title is displayed
    expect(find.text('Members Hosting'), findsOneWidget);
    expect(find.text('Members Offering Hosting'), findsOneWidget);

    // Verify that hosting members are displayed
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Jane Smith'), findsOneWidget);
    expect(find.text('Robert Johnson'), findsOneWidget);
    expect(find.text('Mary Williams'), findsOneWidget);
  });

  testWidgets('Members Hosting screen displays availability status', (WidgetTester tester) async {
    // Build the MembersHostingScreen widget
    await tester.pumpWidget(
      const MaterialApp(
        home: MembersHostingScreen(),
      ),
    );

    // Verify that availability chips are displayed
    expect(find.text('Available'), findsNWidgets(3)); // 3 available hosts
    expect(find.text('Unavailable'), findsOneWidget); // 1 unavailable host
  });

  testWidgets('Tapping a hosting member shows details dialog', (WidgetTester tester) async {
    // Build the MembersHostingScreen widget
    await tester.pumpWidget(
      const MaterialApp(
        home: MembersHostingScreen(),
      ),
    );

    // Tap on the first member
    await tester.tap(find.text('John Doe').first);
    await tester.pumpAndSettle();

    // Verify that the dialog is displayed with details
    expect(find.text('New York, NY'), findsOneWidget);
    expect(find.text('Can host 2 people'), findsOneWidget);
    expect(find.text('Contact Host'), findsOneWidget);
  });
}
