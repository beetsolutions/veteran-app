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

    // Verify that we navigated to the Hosting Schedule screen
    expect(find.text('Hosting Schedule'), findsOneWidget);
    expect(find.text('Current Hosting Rotation'), findsOneWidget);
  });

  testWidgets('Members Hosting screen displays correctly', (WidgetTester tester) async {
    // Build the MembersHostingScreen widget
    await tester.pumpWidget(
      const MaterialApp(
        home: MembersHostingScreen(),
      ),
    );

    // Verify that the screen title is displayed
    expect(find.text('Hosting Schedule'), findsOneWidget);
    expect(find.text('Current Hosting Rotation'), findsOneWidget);

    // Verify that hosting members are displayed
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Jane Smith'), findsOneWidget);
    expect(find.text('Robert Johnson'), findsOneWidget);
    expect(find.text('Mary Williams'), findsOneWidget);
  });

  testWidgets('Members Hosting screen displays current hosts section', (WidgetTester tester) async {
    // Build the MembersHostingScreen widget
    await tester.pumpWidget(
      const MaterialApp(
        home: MembersHostingScreen(),
      ),
    );

    // Verify that the current hosts section is displayed
    expect(find.text('Current Hosts (3 Members)'), findsOneWidget);
    expect(find.text('These members are hosting for this 2-week period'), findsOneWidget);
    
    // Verify the hosting badge is displayed for current hosts
    expect(find.text('Hosting'), findsAtLeastNWidgets(1));
  });

  testWidgets('Members Hosting screen displays payment tracking section', (WidgetTester tester) async {
    // Build the MembersHostingScreen widget
    await tester.pumpWidget(
      const MaterialApp(
        home: MembersHostingScreen(),
      ),
    );

    // Verify that payment tracking section is displayed
    expect(find.text('Payment Tracking'), findsOneWidget);
    expect(find.textContaining('Each member contributes £30'), findsOneWidget);
    
    // Verify payment summary cards
    expect(find.text('Collected'), findsOneWidget);
    expect(find.text('Pending'), findsOneWidget);
    
    // Verify payment progress section
    expect(find.text('Payment Progress'), findsOneWidget);
  });

  testWidgets('Members Hosting screen displays paid and unpaid members lists', (WidgetTester tester) async {
    // Build the MembersHostingScreen widget
    await tester.pumpWidget(
      const MaterialApp(
        home: MembersHostingScreen(),
      ),
    );

    // Verify that paid members section exists
    expect(find.textContaining('Paid Members'), findsOneWidget);
    
    // Verify that unpaid members section exists
    expect(find.textContaining('Pending Payments'), findsOneWidget);
    
    // Verify payment status chips are displayed
    expect(find.text('Paid'), findsAtLeastNWidgets(1));
    expect(find.text('Pending'), findsAtLeastNWidgets(1));
  });

  testWidgets('Members Hosting screen displays next rotation', (WidgetTester tester) async {
    // Build the MembersHostingScreen widget
    await tester.pumpWidget(
      const MaterialApp(
        home: MembersHostingScreen(),
      ),
    );

    // Verify that next rotation section is displayed
    expect(find.text('Next Rotation'), findsOneWidget);
  });

  testWidgets('Members Hosting screen shows correct rotation period info', (WidgetTester tester) async {
    // Build the MembersHostingScreen widget
    await tester.pumpWidget(
      const MaterialApp(
        home: MembersHostingScreen(),
      ),
    );

    // Verify that rotation period info is displayed
    expect(find.textContaining('days remaining'), findsOneWidget);
  });
}
