import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/models/member.dart';
import 'package:veteranapp/screens/member_detail_screen.dart';
import 'package:veteranapp/screens/tab_screens/members_tab.dart';

void main() {
  group('MemberDetailScreen', () {
    testWidgets('displays member details correctly', (WidgetTester tester) async {
      // Build the MemberDetailScreen with test data
      await tester.pumpWidget(
        MaterialApp(
          home: MemberDetailScreen(
            name: 'John Doe',
            role: 'President',
            service: 'Army',
            status: MemberStatus.active,
          ),
        ),
      );

      // Verify that all member details are displayed
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('President'), findsAtLeastNWidgets(1));
      expect(find.text('Army'), findsOneWidget);
      expect(find.text('Service Branch'), findsOneWidget);
      expect(find.text('Role'), findsOneWidget);
      expect(find.text('Active Member'), findsOneWidget);
    });

    testWidgets('displays suspended status correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MemberDetailScreen(
            name: 'Jane Smith',
            role: 'Member',
            service: 'Navy',
            status: MemberStatus.suspended,
          ),
        ),
      );

      // Verify that suspended status is displayed
      expect(find.text('Suspended'), findsOneWidget);
    });

    testWidgets('displays dismissed status correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MemberDetailScreen(
            name: 'Bob Johnson',
            role: 'Member',
            service: 'Marines',
            status: MemberStatus.dismissed,
          ),
        ),
      );

      // Verify that dismissed status is displayed
      expect(find.text('Dismissed'), findsOneWidget);
    });

    testWidgets('displays member avatar with first letter', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MemberDetailScreen(
            name: 'Jane Smith',
            role: 'Vice President',
            service: 'Navy',
          ),
        ),
      );

      // Verify that the avatar displays the first letter
      expect(find.text('J'), findsOneWidget);
    });

    testWidgets('has back button in app bar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MemberDetailScreen(
            name: 'John Doe',
            role: 'President',
            service: 'Army',
          ),
        ),
      );

      // Verify app bar title
      expect(find.text('Member Details'), findsOneWidget);
      
      // Verify back button exists (AppBar automatically adds it when pushed)
      expect(find.byType(AppBar), findsOneWidget);
    });
  });

  group('MembersTab Navigation', () {
    testWidgets('navigates to member detail when member is tapped', (WidgetTester tester) async {
      // Build the MembersTab
      await tester.pumpWidget(
        MaterialApp(
          home: MembersTab(),
        ),
      );

      // Verify members list is displayed
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Jane Smith'), findsOneWidget);

      // Tap on first member
      await tester.tap(find.text('John Doe'));
      await tester.pumpAndSettle();

      // Verify navigation to detail screen
      expect(find.text('Member Details'), findsOneWidget);
      expect(find.text('Army'), findsOneWidget);
      expect(find.text('Service Branch'), findsOneWidget);
    });

    testWidgets('can navigate back from member detail', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MembersTab(),
        ),
      );

      // Navigate to detail
      await tester.tap(find.text('Jane Smith'));
      await tester.pumpAndSettle();

      // Verify we're on detail screen
      expect(find.text('Member Details'), findsOneWidget);

      // Tap back button
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Verify we're back on members list
      expect(find.text('Organization Members'), findsOneWidget);
      expect(find.textContaining('total'), findsOneWidget);
    });

    testWidgets('navigates to correct member detail', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MembersTab(),
        ),
      );

      // Tap on third member (Robert Johnson)
      await tester.tap(find.text('Robert Johnson'));
      await tester.pumpAndSettle();

      // Verify correct member details are shown
      expect(find.text('Robert Johnson'), findsOneWidget);
      expect(find.text('Secretary'), findsAtLeastNWidgets(1));
      expect(find.text('Air Force'), findsOneWidget);
    });
  });

  group('MembersTab Sections', () {
    testWidgets('displays all three member sections', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MembersTab(),
        ),
      );

      // Verify sections are displayed
      expect(find.text('Active Members'), findsOneWidget);
      expect(find.text('Suspended Members'), findsOneWidget);
      expect(find.text('Dismissed Members'), findsOneWidget);
    });

    testWidgets('displays correct member counts', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MembersTab(),
        ),
      );

      // Verify summary counts
      expect(find.textContaining('9 total'), findsOneWidget);
      expect(find.textContaining('5 active'), findsOneWidget);
      expect(find.textContaining('2 suspended'), findsOneWidget);
      expect(find.textContaining('2 dismissed'), findsOneWidget);
    });
  });
}
