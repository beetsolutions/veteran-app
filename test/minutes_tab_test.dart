import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:veteranapp/screens/tab_screens/minutes_tab.dart';
import 'package:veteranapp/models/meeting.dart';
import 'package:veteranapp/models/user.dart';
import 'package:veteranapp/models/organization.dart';
import 'package:veteranapp/data/repositories/meetings_repository.dart';
import 'package:veteranapp/providers/user_provider.dart';

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
  Future<List<Meeting>> getMeetings({String? organizationId}) async {
    if (_shouldFail) {
      throw Exception('Failed to load meetings');
    }
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));
    return _meetings;
  }

  @override
  Future<Meeting> getMeetingById(String id, {String? organizationId}) async {
    if (_shouldFail) {
      throw Exception('Failed to load meeting');
    }
    await Future.delayed(const Duration(milliseconds: 100));
    return _meetings.firstWhere((m) => m.id == id);
  }
}

// Helper function to create a test UserProvider
UserProvider createMockUserProvider() {
  final organization = const Organization(
    id: 'test-org-1',
    name: 'Test Organization',
    location: 'Test Location',
  );
  
  final user = User(
    id: 'test-user-1',
    username: 'testuser',
    email: 'test@example.com',
    name: 'Test User',
    organizations: [organization],
    currentOrganizationId: organization.id,
  );
  
  final userProvider = UserProvider();
  userProvider.setUser(user);
  return userProvider;
}

// Helper function to wrap a widget with necessary providers
Widget wrapWithProviders(Widget child, {UserProvider? userProvider}) {
  return ChangeNotifierProvider<UserProvider>.value(
    value: userProvider ?? createMockUserProvider(),
    child: MaterialApp(
      home: child,
    ),
  );
}

void main() {
  group('MinutesTab Tests', () {
    testWidgets('MinutesTab displays loading indicator initially', (WidgetTester tester) async {
      final repository = MockMeetingsRepository();

      await tester.pumpWidget(
        wrapWithProviders(MinutesTab(meetingsRepository: repository)),
      );

      // Should show loading indicator initially
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('MinutesTab displays meetings after loading', (WidgetTester tester) async {
      final repository = MockMeetingsRepository();

      await tester.pumpWidget(
        wrapWithProviders(MinutesTab(meetingsRepository: repository)),
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
        wrapWithProviders(MinutesTab(meetingsRepository: repository)),
      );

      await tester.pumpAndSettle();

      // Verify attendance is displayed
      expect(find.text('45 members present'), findsOneWidget);
      expect(find.text('30 members present'), findsOneWidget);
    });

    testWidgets('MinutesTab displays error message on failure', (WidgetTester tester) async {
      final repository = MockMeetingsRepository(shouldFail: true);

      await tester.pumpWidget(
        wrapWithProviders(MinutesTab(meetingsRepository: repository)),
      );

      await tester.pumpAndSettle();

      // Verify error message is displayed
      expect(find.textContaining('Failed to load meetings'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('MinutesTab retry button reloads data', (WidgetTester tester) async {
      final repository = MockMeetingsRepository(shouldFail: true);

      await tester.pumpWidget(
        wrapWithProviders(MinutesTab(meetingsRepository: repository)),
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
        wrapWithProviders(MinutesTab(meetingsRepository: repository)),
      );

      await tester.pumpAndSettle();

      // Verify empty state is displayed
      expect(find.text('No meetings found'), findsOneWidget);
      expect(find.byIcon(Icons.event_note), findsOneWidget);
    });

    testWidgets('MinutesTab meeting card is tappable', (WidgetTester tester) async {
      final repository = MockMeetingsRepository();

      await tester.pumpWidget(
        wrapWithProviders(MinutesTab(meetingsRepository: repository)),
      );

      await tester.pumpAndSettle();

      // Tap on first meeting card
      await tester.tap(find.text('Test Meeting 1'));
      await tester.pumpAndSettle();

      // Should navigate to detail screen
      expect(find.text('Meeting Details'), findsOneWidget);
    });

    testWidgets('MinutesTab displays sort button', (WidgetTester tester) async {
      final repository = MockMeetingsRepository();

      await tester.pumpWidget(
        wrapWithProviders(MinutesTab(meetingsRepository: repository)),
      );

      await tester.pumpAndSettle();

      // Verify sort button is displayed
      expect(find.byIcon(Icons.sort), findsOneWidget);
    });

    testWidgets('MinutesTab shows sort menu with three options', (WidgetTester tester) async {
      final repository = MockMeetingsRepository();

      await tester.pumpWidget(
        wrapWithProviders(MinutesTab(meetingsRepository: repository)),
      );

      await tester.pumpAndSettle();

      // Tap the sort button
      await tester.tap(find.byIcon(Icons.sort));
      await tester.pumpAndSettle();

      // Verify sort options are displayed
      expect(find.text('Date: Newest First'), findsOneWidget);
      expect(find.text('Date: Oldest First'), findsOneWidget);
      expect(find.text('Attendance: Highest First'), findsOneWidget);
    });

    testWidgets('MinutesTab sorts by date descending (newest first) by default', (WidgetTester tester) async {
      final repository = MockMeetingsRepository(
        meetings: [
          const Meeting(
            id: '1',
            title: 'Meeting A',
            date: 'Jan 15, 2026',
            venue: 'Venue A',
            attendance: 30,
          ),
          const Meeting(
            id: '2',
            title: 'Meeting B',
            date: 'Feb 1, 2026',
            venue: 'Venue B',
            attendance: 45,
          ),
          const Meeting(
            id: '3',
            title: 'Meeting C',
            date: 'Jan 1, 2026',
            venue: 'Venue C',
            attendance: 20,
          ),
        ],
      );

      await tester.pumpWidget(
        wrapWithProviders(MinutesTab(meetingsRepository: repository)),
      );

      await tester.pumpAndSettle();

      // Find all meeting cards
      final meetingCards = find.byType(ListTile);
      expect(meetingCards, findsNWidgets(3));

      // Verify order: Feb 1 (newest), Jan 15, Jan 1 (oldest)
      final titles = tester.widgetList<Text>(find.byType(Text))
          .where((text) => text.data?.startsWith('Meeting') ?? false)
          .map((text) => text.data)
          .toList();
      
      expect(titles[0], 'Meeting B'); // Feb 1, 2026
      expect(titles[1], 'Meeting A'); // Jan 15, 2026
      expect(titles[2], 'Meeting C'); // Jan 1, 2026
    });

    testWidgets('MinutesTab sorts by date ascending (oldest first)', (WidgetTester tester) async {
      final repository = MockMeetingsRepository(
        meetings: [
          const Meeting(
            id: '1',
            title: 'Meeting A',
            date: 'Jan 15, 2026',
            venue: 'Venue A',
            attendance: 30,
          ),
          const Meeting(
            id: '2',
            title: 'Meeting B',
            date: 'Feb 1, 2026',
            venue: 'Venue B',
            attendance: 45,
          ),
          const Meeting(
            id: '3',
            title: 'Meeting C',
            date: 'Jan 1, 2026',
            venue: 'Venue C',
            attendance: 20,
          ),
        ],
      );

      await tester.pumpWidget(
        wrapWithProviders(MinutesTab(meetingsRepository: repository)),
      );

      await tester.pumpAndSettle();

      // Tap the sort button
      await tester.tap(find.byIcon(Icons.sort));
      await tester.pumpAndSettle();

      // Select "Date: Oldest First"
      await tester.tap(find.text('Date: Oldest First'));
      await tester.pumpAndSettle();

      // Find all meeting cards
      final meetingCards = find.byType(ListTile);
      expect(meetingCards, findsNWidgets(3));

      // Verify order: Jan 1 (oldest), Jan 15, Feb 1 (newest)
      final titles = tester.widgetList<Text>(find.byType(Text))
          .where((text) => text.data?.startsWith('Meeting') ?? false)
          .map((text) => text.data)
          .toList();
      
      expect(titles[0], 'Meeting C'); // Jan 1, 2026
      expect(titles[1], 'Meeting A'); // Jan 15, 2026
      expect(titles[2], 'Meeting B'); // Feb 1, 2026
    });

    testWidgets('MinutesTab sorts by attendance (highest first)', (WidgetTester tester) async {
      final repository = MockMeetingsRepository(
        meetings: [
          const Meeting(
            id: '1',
            title: 'Meeting A',
            date: 'Jan 15, 2026',
            venue: 'Venue A',
            attendance: 30,
          ),
          const Meeting(
            id: '2',
            title: 'Meeting B',
            date: 'Feb 1, 2026',
            venue: 'Venue B',
            attendance: 45,
          ),
          const Meeting(
            id: '3',
            title: 'Meeting C',
            date: 'Jan 1, 2026',
            venue: 'Venue C',
            attendance: 20,
          ),
        ],
      );

      await tester.pumpWidget(
        wrapWithProviders(MinutesTab(meetingsRepository: repository)),
      );

      await tester.pumpAndSettle();

      // Tap the sort button
      await tester.tap(find.byIcon(Icons.sort));
      await tester.pumpAndSettle();

      // Select "Attendance: Highest First"
      await tester.tap(find.text('Attendance: Highest First'));
      await tester.pumpAndSettle();

      // Find all meeting cards
      final meetingCards = find.byType(ListTile);
      expect(meetingCards, findsNWidgets(3));

      // Verify order: 45, 30, 20
      final titles = tester.widgetList<Text>(find.byType(Text))
          .where((text) => text.data?.startsWith('Meeting') ?? false)
          .map((text) => text.data)
          .toList();
      
      expect(titles[0], 'Meeting B'); // 45 attendance
      expect(titles[1], 'Meeting A'); // 30 attendance
      expect(titles[2], 'Meeting C'); // 20 attendance
    });
  });
}
