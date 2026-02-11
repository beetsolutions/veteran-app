import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/screens/notifications_screen.dart';

void main() {
  testWidgets('Notifications screen displays title', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: NotificationsScreen(),
      ),
    );

    // Verify the screen title is displayed
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Recent Notifications'), findsOneWidget);
  });

  testWidgets('Notifications screen displays notification items', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: NotificationsScreen(),
      ),
    );

    // Verify notification items are displayed
    expect(find.text('Upcoming Event'), findsOneWidget);
    expect(find.text('Payment Reminder'), findsOneWidget);
    expect(find.text('New Member Joined'), findsOneWidget);
    expect(find.text('Hosting Schedule Updated'), findsOneWidget);
  });

  testWidgets('Notifications screen displays notification icons', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: NotificationsScreen(),
      ),
    );

    // Verify notification icons are displayed
    expect(find.byIcon(Icons.event), findsOneWidget);
    expect(find.byIcon(Icons.account_balance_wallet), findsOneWidget);
    expect(find.byIcon(Icons.people), findsOneWidget);
    expect(find.byIcon(Icons.home_work), findsOneWidget);
  });
}
