import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/screens/details/meeting_detail_screen.dart';
import 'package:veteranapp/models/meeting.dart';

void main() {
  group('MeetingDetailScreen Tests', () {
    testWidgets('MeetingDetailScreen displays meeting details', (WidgetTester tester) async {
      const meeting = Meeting(
        id: '1',
        title: 'Test Meeting',
        date: 'Feb 1, 2026',
        venue: 'Test Venue',
        attendance: 45,
        minutes: 'This is a test meeting minutes.',
        actionPoints: ['Action Point 1', 'Action Point 2'],
        fines: [
          Fine(memberName: 'John Doe', amount: 25.0, reason: 'Late arrival'),
        ],
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: MeetingDetailScreen(meeting: meeting),
        ),
      );

      // Verify the app bar title
      expect(find.text('Meeting Details'), findsOneWidget);

      // Verify meeting title
      expect(find.text('Test Meeting'), findsOneWidget);

      // Verify date
      expect(find.text('Feb 1, 2026'), findsOneWidget);

      // Verify venue
      expect(find.text('Test Venue'), findsOneWidget);

      // Verify attendance
      expect(find.text('45 members present'), findsOneWidget);
    });

    testWidgets('MeetingDetailScreen displays minutes section', (WidgetTester tester) async {
      const meeting = Meeting(
        id: '1',
        title: 'Test Meeting',
        date: 'Feb 1, 2026',
        venue: 'Test Venue',
        attendance: 45,
        minutes: 'This is a test meeting minutes.',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: MeetingDetailScreen(meeting: meeting),
        ),
      );

      // Verify minutes section header
      expect(find.text('Minutes of the Meeting'), findsOneWidget);

      // Verify minutes content
      expect(find.text('This is a test meeting minutes.'), findsOneWidget);
    });

    testWidgets('MeetingDetailScreen displays action points', (WidgetTester tester) async {
      const meeting = Meeting(
        id: '1',
        title: 'Test Meeting',
        date: 'Feb 1, 2026',
        venue: 'Test Venue',
        attendance: 45,
        actionPoints: ['Action Point 1', 'Action Point 2', 'Action Point 3'],
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: MeetingDetailScreen(meeting: meeting),
        ),
      );

      // Verify action points section header
      expect(find.text('Action Points'), findsOneWidget);

      // Verify action points are displayed
      expect(find.text('Action Point 1'), findsOneWidget);
      expect(find.text('Action Point 2'), findsOneWidget);
      expect(find.text('Action Point 3'), findsOneWidget);

      // Verify numbering (1, 2, 3)
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('MeetingDetailScreen displays fines', (WidgetTester tester) async {
      const meeting = Meeting(
        id: '1',
        title: 'Test Meeting',
        date: 'Feb 1, 2026',
        venue: 'Test Venue',
        attendance: 45,
        fines: [
          Fine(memberName: 'John Doe', amount: 25.0, reason: 'Late arrival'),
          Fine(memberName: 'Jane Smith', amount: 50.0, reason: 'Unexcused absence'),
        ],
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: MeetingDetailScreen(meeting: meeting),
        ),
      );

      // Verify fines section header
      expect(find.text('Fines'), findsOneWidget);

      // Verify fines are displayed
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Late arrival'), findsOneWidget);
      expect(find.text('\$25.00'), findsOneWidget);

      expect(find.text('Jane Smith'), findsOneWidget);
      expect(find.text('Unexcused absence'), findsOneWidget);
      expect(find.text('\$50.00'), findsOneWidget);
    });

    testWidgets('MeetingDetailScreen hides empty sections', (WidgetTester tester) async {
      const meeting = Meeting(
        id: '1',
        title: 'Test Meeting',
        date: 'Feb 1, 2026',
        venue: 'Test Venue',
        attendance: 45,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: MeetingDetailScreen(meeting: meeting),
        ),
      );

      // Verify sections are not displayed when data is null
      expect(find.text('Minutes of the Meeting'), findsNothing);
      expect(find.text('Action Points'), findsNothing);
      expect(find.text('Fines'), findsNothing);
    });

    testWidgets('MeetingDetailScreen is scrollable', (WidgetTester tester) async {
      const meeting = Meeting(
        id: '1',
        title: 'Test Meeting',
        date: 'Feb 1, 2026',
        venue: 'Test Venue',
        attendance: 45,
        minutes: 'Long meeting minutes that might require scrolling to see all content.',
        actionPoints: [
          'Action Point 1',
          'Action Point 2',
          'Action Point 3',
          'Action Point 4',
          'Action Point 5',
        ],
        fines: [
          Fine(memberName: 'John Doe', amount: 25.0, reason: 'Late arrival'),
          Fine(memberName: 'Jane Smith', amount: 50.0, reason: 'Unexcused absence'),
        ],
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: MeetingDetailScreen(meeting: meeting),
        ),
      );

      // Verify the screen has a scrollable widget
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('MeetingDetailScreen displays all icons correctly', (WidgetTester tester) async {
      const meeting = Meeting(
        id: '1',
        title: 'Test Meeting',
        date: 'Feb 1, 2026',
        venue: 'Test Venue',
        attendance: 45,
        minutes: 'Test minutes',
        actionPoints: ['Action 1'],
        fines: [
          Fine(memberName: 'John Doe', amount: 25.0, reason: 'Late'),
        ],
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: MeetingDetailScreen(meeting: meeting),
        ),
      );

      // Verify icons are displayed
      expect(find.byIcon(Icons.event), findsOneWidget);
      expect(find.byIcon(Icons.location_on), findsOneWidget);
      expect(find.byIcon(Icons.people), findsOneWidget);
      expect(find.byIcon(Icons.description), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
      expect(find.byIcon(Icons.payment), findsOneWidget);
    });
  });
}
