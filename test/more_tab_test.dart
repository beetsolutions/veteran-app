import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/screens/tab_screens/more_tab.dart';
import 'package:veteranapp/screens/activity_statistics_screen.dart';
import 'package:veteranapp/screens/soccer_statistics_screen.dart';
import 'package:veteranapp/screens/profile_screen.dart';
import 'package:veteranapp/screens/notifications_screen.dart';
import 'package:veteranapp/screens/settings_screen.dart';
import 'package:veteranapp/screens/help_support_screen.dart';
import 'package:veteranapp/screens/about_screen.dart';

void main() {
  testWidgets('More tab displays Activity Statistics menu item', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MoreTab(),
      ),
    );

    // Verify the Activity Statistics menu item is displayed
    expect(find.text('Activity Statistics'), findsOneWidget);
    expect(find.byIcon(Icons.bar_chart), findsOneWidget);
  });

  testWidgets('Activity Statistics item navigates to Activity Statistics screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MoreTab(),
      ),
    );

    // Tap on Activity Statistics menu item
    await tester.tap(find.text('Activity Statistics'));
    await tester.pumpAndSettle();

    // Verify that we navigated to the Activity Statistics screen
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Engagement'), findsOneWidget);
  });

  testWidgets('More tab displays all menu items in correct order', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MoreTab(),
      ),
    );

    // Find all menu items
    final menuItems = [
      'Profile',
      'Activity Statistics',
      'Soccer Statistics',
      'Settings',
      'Notifications',
      'Members Hosting',
      'Help & Support',
      'About',
      'Logout',
    ];

    // Verify all items exist
    for (final item in menuItems) {
      expect(find.text(item), findsOneWidget);
    }
  });

  testWidgets('More tab displays Soccer Statistics menu item', (WidgetTester tester) async {
  testWidgets('Profile item navigates to Profile screen', (WidgetTester tester) async {
  testWidgets('Notifications item navigates to Notifications screen', (WidgetTester tester) async {
  testWidgets('Settings item navigates to Settings screen', (WidgetTester tester) async {
  testWidgets('Help & Support item navigates to Help Support screen', (WidgetTester tester) async {
  testWidgets('About item navigates to About screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MoreTab(),
      ),
    );

    // Verify the Soccer Statistics menu item is displayed
    expect(find.text('Soccer Statistics'), findsOneWidget);
    expect(find.byIcon(Icons.sports_soccer), findsOneWidget);
  });

  testWidgets('Soccer Statistics item navigates to Soccer Statistics screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MoreTab(),
      ),
    );

    // Tap on Soccer Statistics menu item
    await tester.tap(find.text('Soccer Statistics'));
    await tester.pumpAndSettle();

    // Verify that we navigated to the Soccer Statistics screen
    expect(find.text('Match Information'), findsOneWidget);
    expect(find.text('Match Officials'), findsOneWidget);
    // Tap on Profile menu item
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    // Verify that we navigated to the Profile screen
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Contact Information'), findsOneWidget);
    expect(find.text('Military Service'), findsOneWidget);
    expect(find.text('Membership'), findsOneWidget);
    // Tap on Notifications menu item
    await tester.tap(find.text('Notifications'));
    await tester.pumpAndSettle();

    // Verify that we navigated to the Notifications screen
    expect(find.text('Recent Notifications'), findsOneWidget);
    expect(find.text('Upcoming Event'), findsOneWidget);
    // Tap on Settings menu item
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    // Verify that we navigated to the Settings screen
    expect(find.text('General'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Privacy'), findsOneWidget);
    expect(find.text('Dark Mode'), findsOneWidget);
    // Tap on Help & Support menu item
    await tester.tap(find.text('Help & Support'));
    await tester.pumpAndSettle();

    // Verify that we navigated to the Help Support screen
    expect(find.text('We\'re Here to Help'), findsOneWidget);
    expect(find.text('Frequently Asked Questions'), findsOneWidget);
    // Tap on About menu item
    await tester.tap(find.text('About'));
    await tester.pumpAndSettle();

    // Verify that we navigated to the About screen
    expect(find.text('VeteranApp'), findsOneWidget);
    expect(find.text('Version 1.0.0'), findsOneWidget);
    expect(find.text('About VeteranApp'), findsOneWidget);
  });
}
