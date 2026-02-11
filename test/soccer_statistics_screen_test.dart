import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/screens/soccer_statistics_screen.dart';

void main() {
  testWidgets('Soccer Statistics screen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SoccerStatisticsScreen(),
      ),
    );

    // Verify that the screen title is displayed
    expect(find.text('Soccer Statistics'), findsOneWidget);
    
    // Verify section headers
    expect(find.text('Match Information'), findsOneWidget);
    expect(find.text('Match Officials'), findsOneWidget);
    expect(find.text('Goals (4)'), findsOneWidget);
    expect(find.text('Assists (4)'), findsOneWidget);
    expect(find.text('Yellow Cards (3)'), findsOneWidget);
    expect(find.text('Red Cards (1)'), findsOneWidget);
  });

  testWidgets('Soccer Statistics screen displays match information', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SoccerStatisticsScreen(),
      ),
    );

    // Verify match day and officials are displayed
    expect(find.text('Match Day'), findsOneWidget);
    expect(find.text('Saturday, February 10, 2026'), findsOneWidget);
    
    // Verify team names and scores are displayed
    expect(find.text('Veterans United FC'), findsOneWidget);
    expect(find.text('City Rovers'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    
    expect(find.text('Referee'), findsOneWidget);
    expect(find.text('John Smith'), findsOneWidget);
    expect(find.text('Assistant Referee 1'), findsOneWidget);
    expect(find.text('Mike Johnson'), findsOneWidget);
    expect(find.text('Assistant Referee 2'), findsOneWidget);
    expect(find.text('Sarah Williams'), findsOneWidget);
  });

  testWidgets('Soccer Statistics screen displays goals', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SoccerStatisticsScreen(),
      ),
    );

    // Verify goals are displayed
    expect(find.text('David Martinez'), findsNWidgets(2)); // Scored 2 goals
    expect(find.text('James Wilson'), findsOneWidget);
    expect(find.text('Robert Brown'), findsOneWidget);
    expect(find.byIcon(Icons.sports_soccer), findsNWidgets(4));
  });

  testWidgets('Soccer Statistics screen displays assists', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SoccerStatisticsScreen(),
      ),
    );

    // Verify assists are displayed
    expect(find.text('Chris Anderson'), findsNWidgets(2)); // 2 assists
    expect(find.text('Tom Davis'), findsOneWidget);
    expect(find.text('Kevin Moore'), findsOneWidget);
  });

  testWidgets('Soccer Statistics screen displays yellow cards', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SoccerStatisticsScreen(),
      ),
    );

    // Verify yellow cards are displayed
    expect(find.text('Paul Taylor'), findsOneWidget);
    expect(find.text('Mark Thompson'), findsOneWidget);
    expect(find.text('Steve Harris'), findsOneWidget);
    expect(find.text('Unsporting behavior'), findsOneWidget);
    expect(find.text('Time wasting'), findsOneWidget);
    expect(find.text('Tactical foul'), findsOneWidget);
    expect(find.byIcon(Icons.warning), findsNWidgets(3));
  });

  testWidgets('Soccer Statistics screen displays red cards', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SoccerStatisticsScreen(),
      ),
    );

    // Verify red cards are displayed
    expect(find.text('Alex White'), findsOneWidget);
    expect(find.text('Violent conduct'), findsOneWidget);
    expect(find.byIcon(Icons.cancel), findsOneWidget);
  });

  testWidgets('Soccer Statistics screen is scrollable', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SoccerStatisticsScreen(),
      ),
    );

    // Verify the screen has a SingleChildScrollView
    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });

  testWidgets('Soccer Statistics screen displays correct icons', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SoccerStatisticsScreen(),
      ),
    );

    // Verify icons are displayed
    expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    expect(find.byIcon(Icons.sports), findsOneWidget);
    expect(find.byIcon(Icons.assistant_photo), findsNWidgets(2));
  });

  testWidgets('Soccer Statistics screen has floating action button for match history', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SoccerStatisticsScreen(),
      ),
    );

    // Verify floating action button is displayed
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byIcon(Icons.history), findsOneWidget);
    expect(find.text('Match History'), findsOneWidget);
  });
}
