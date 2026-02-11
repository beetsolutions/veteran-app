import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/screens/activity_statistics_screen.dart';

void main() {
  testWidgets('Activity Statistics screen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ActivityStatisticsScreen(),
      ),
    );

    // Verify that the screen title is displayed
    expect(find.text('Activity Statistics'), findsOneWidget);
    
    // Verify section headers
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Engagement'), findsOneWidget);
    
    // Verify stat cards are displayed
    expect(find.text('Total Members'), findsOneWidget);
    expect(find.text('Active Members'), findsOneWidget);
    expect(find.text('Events This Month'), findsOneWidget);
    expect(find.text('Account Balance'), findsOneWidget);
    expect(find.text('Event Attendance'), findsOneWidget);
    expect(find.text('Volunteer Hours'), findsOneWidget);
    expect(find.text('New Members'), findsOneWidget);
    expect(find.text('Meetings Held'), findsOneWidget);
    
    // Verify stat values are displayed
    expect(find.text('150'), findsOneWidget);
    expect(find.text('142'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
    expect(find.text('\$25,000'), findsOneWidget);
    expect(find.text('85%'), findsOneWidget);
    expect(find.text('320'), findsOneWidget);
    expect(find.text('8'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
  });

  testWidgets('Activity Statistics screen is scrollable', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ActivityStatisticsScreen(),
      ),
    );

    // Verify the screen has a SingleChildScrollView
    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });
}
