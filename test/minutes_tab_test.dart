import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/screens/tab_screens/minutes_tab.dart';
import 'package:veteranapp/models/meeting.dart';
import 'package:veteranapp/data/repositories/meetings_repository.dart';

// Mock repository for testing
class MockMeetingsRepository implements MeetingsRepository {
  final List<Meeting> _meetings;
  final bool _shouldFail;

  MockMeetingsRepository({
    List<Meeting>? meetings,
    bool shouldFail = false,
  })  : _meetings = meetings ?? _defaultMeetings,
        _shouldFail = shouldFail;

  static final List<Meeting> _defaultMeetings = [
    const Meeting(
      id: '1',
      title: 'Test Meeting 1',
      date: 'Feb 1, 2026',
      venue: 'Test Venue 1',
      attendance: 45,
      minutes: 'Test minutes 1',
      actionPoints: ['Action 1'],
      fines: [],
    ),
    const Meeting(
      id: '2',
      title: 'Test Meeting 2',
      date: 'Jan 15, 2026',
      venue: 'Test Venue 2',
      attendance: 30,
      minutes: 'Test minutes 2',
      actionPoints: ['Action 2'],
      fines: [],
    ),
  ];

  @override
  Future<List<Meeting>> getMeetings() async {
    if (_shouldFail) {
      throw Exception('Failed to load meetings');
    }
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));
    return _meetings;
  }

  @override
  Future<Meeting> getMeetingById(String id) async {
    if (_shouldFail) {
      throw Exception('Failed to load meeting');
    }
    await Future.delayed(const Duration(milliseconds: 100));
    return _meetings.firstWhere((m) => m.id == id);
  }
}

void main() {
  group('MinutesTab Tests', () {
    testWidgets('MinutesTab displays loading indicator initially', (WidgetTester tester) async {
      final repository = MockMeetingsRepository();

      await tester.pumpWidget(
        MaterialApp(
          home: MinutesTab(meetingsRepository: repository),
        ),
      );

      // Should show loading indicator initially
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('MinutesTab displays meetings after loading', (WidgetTester tester) async {
      final repository = MockMeetingsRepository();

      await tester.pumpWidget(
        MaterialApp(
          home: MinutesTab(meetingsRepository: repository),
        ),
      );

      // Wait for loading to complete
      await tester.pumpAndSettle();

      // Verify the app bar title is displayed
      expect(find.text('Minutes'), findsOneWidget);

      // Verify meetings are displayed
      expect(find.text('Test Meeting 1'), findsOneWidget);
      expect(find.text('Test Meeting 2'), findsOneWidget);
      expect(find.text('Test Venue 1'), findsOneWidget);
      expect(find.text('Test Venue 2'), findsOneWidget);
    });

    testWidgets('MinutesTab displays attendance information', (WidgetTester tester) async {
      final repository = MockMeetingsRepository();

      await tester.pumpWidget(
        MaterialApp(
          home: MinutesTab(meetingsRepository: repository),
        ),
      );

      await tester.pumpAndSettle();

      // Verify attendance is displayed
      expect(find.text('45 members present'), findsOneWidget);
      expect(find.text('30 members present'), findsOneWidget);
    });

    testWidgets('MinutesTab displays error message on failure', (WidgetTester tester) async {
      final repository = MockMeetingsRepository(shouldFail: true);

      await tester.pumpWidget(
        MaterialApp(
          home: MinutesTab(meetingsRepository: repository),
        ),
      );

      await tester.pumpAndSettle();

      // Verify error message is displayed
      expect(find.textContaining('Failed to load meetings'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('MinutesTab retry button reloads data', (WidgetTester tester) async {
      final repository = MockMeetingsRepository(shouldFail: true);

      await tester.pumpWidget(
        MaterialApp(
          home: MinutesTab(meetingsRepository: repository),
        ),
      );

      await tester.pumpAndSettle();

      // Verify error message is displayed
      expect(find.textContaining('Failed to load meetings'), findsOneWidget);

      // Tap retry button
      await tester.tap(find.text('Retry'));
      await tester.pump();

      // Should show loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('MinutesTab displays empty state when no meetings', (WidgetTester tester) async {
      final repository = MockMeetingsRepository(meetings: []);

      await tester.pumpWidget(
        MaterialApp(
          home: MinutesTab(meetingsRepository: repository),
        ),
      );

      await tester.pumpAndSettle();

      // Verify empty state is displayed
      expect(find.text('No meetings found'), findsOneWidget);
      expect(find.byIcon(Icons.event_note), findsOneWidget);
    });

    testWidgets('MinutesTab meeting card is tappable', (WidgetTester tester) async {
      final repository = MockMeetingsRepository();

      await tester.pumpWidget(
        MaterialApp(
          home: MinutesTab(meetingsRepository: repository),
        ),
      );

      await tester.pumpAndSettle();

      // Tap on first meeting card
      await tester.tap(find.text('Test Meeting 1'));
      await tester.pumpAndSettle();

      // Should navigate to detail screen
      expect(find.text('Meeting Details'), findsOneWidget);
    });
  });
}
