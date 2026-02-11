import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/screens/soccer_match_history_screen.dart';

void main() {
  testWidgets('Soccer Match History screen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SoccerMatchHistoryScreen(),
      ),
    );

    // Verify that the screen title is displayed
    expect(find.text('Match History'), findsOneWidget);
    
    // Verify that the screen has a ListView
    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Soccer Match History screen displays match cards', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SoccerMatchHistoryScreen(),
      ),
    );

    // Verify that multiple match cards are displayed
    expect(find.byType(Card), findsWidgets);
    
    // Verify team names are displayed
    expect(find.text('Veterans United FC'), findsWidgets);
    expect(find.text('City Rovers'), findsOneWidget);
    expect(find.text('Rangers FC'), findsOneWidget);
  });

  testWidgets('Soccer Match History screen displays match dates', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SoccerMatchHistoryScreen(),
      ),
    );

    // Verify that match dates are displayed
    expect(find.text('Saturday, February 10, 2026'), findsOneWidget);
    expect(find.text('Saturday, February 3, 2026'), findsOneWidget);
    expect(find.text('Saturday, January 27, 2026'), findsOneWidget);
  });

  testWidgets('Soccer Match History screen displays scores', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SoccerMatchHistoryScreen(),
      ),
    );

    // Verify that scores are displayed
    expect(find.text('3'), findsWidgets);
    expect(find.text('1'), findsWidgets);
    expect(find.text('2'), findsWidgets);
    expect(find.text('4'), findsWidgets);
  });

  testWidgets('Soccer Match History screen displays statistics icons', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SoccerMatchHistoryScreen(),
      ),
    );

    // Verify that statistics icons are displayed
    expect(find.byIcon(Icons.sports_soccer), findsWidgets);
    expect(find.byIcon(Icons.warning), findsWidgets);
    expect(find.byIcon(Icons.cancel), findsWidgets);
    expect(find.byIcon(Icons.calendar_today), findsWidgets);
  });

  testWidgets('Tapping on a match card navigates to details screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SoccerMatchHistoryScreen(),
      ),
    );

    // Verify there are InkWell widgets (tappable cards)
    expect(find.byType(InkWell), findsWidgets);
    
    // Tap on the first match card
    await tester.tap(find.byType(InkWell).first);
    await tester.pumpAndSettle();

    // Verify navigation to details screen
    expect(find.text('Match Details'), findsOneWidget);
    expect(find.text('Match Officials'), findsOneWidget);
  });
}
