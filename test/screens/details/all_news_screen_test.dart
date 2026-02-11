import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/models/news_item.dart';
import 'package:veteranapp/screens/details/all_news_screen.dart';

void main() {
  group('AllNewsScreen Tests', () {
    final testNewsItems = [
      const NewsItem(
        title: 'Newest News',
        description: 'Most recent news',
        date: 'Nov 11, 2024',
        category: 'Events',
      ),
      const NewsItem(
        title: 'Middle News',
        description: 'Middle date news',
        date: 'Oct 28, 2024',
        category: 'News',
      ),
      const NewsItem(
        title: 'Oldest News',
        description: 'Oldest date news',
        date: 'Oct 10, 2024',
        category: 'Education',
      ),
      const NewsItem(
        title: 'Another Middle News',
        description: 'Another middle date',
        date: 'Oct 15, 2024',
        category: 'Events',
      ),
    ];

    testWidgets('AllNewsScreen displays all news items', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AllNewsScreen(newsItems: testNewsItems),
        ),
      );

      expect(find.text('All News'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      
      // Check that news items are displayed
      expect(find.text('Newest News'), findsOneWidget);
      expect(find.text('Middle News'), findsOneWidget);
      expect(find.text('Oldest News'), findsOneWidget);
    });

    testWidgets('AllNewsScreen displays sort button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AllNewsScreen(newsItems: testNewsItems),
        ),
      );

      // Find the sort icon button
      expect(find.byIcon(Icons.sort), findsOneWidget);
    });

    testWidgets('AllNewsScreen sorts news in descending order by default', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AllNewsScreen(newsItems: testNewsItems),
        ),
      );

      await tester.pumpAndSettle();

      // Find all news card titles
      final titleFinder = find.byWidgetPredicate(
        (widget) => widget is Text && 
                    (widget.data == 'Newest News' || 
                     widget.data == 'Middle News' || 
                     widget.data == 'Oldest News' ||
                     widget.data == 'Another Middle News'),
      );

      // Get the positions of the news items
      final titles = tester.widgetList<Text>(titleFinder).map((w) => w.data).toList();
      
      // The default order should be descending (newest first)
      // Nov 11 > Oct 28 > Oct 15 > Oct 10
      expect(titles[0], 'Newest News');
      expect(titles[titles.length - 1], 'Oldest News');
    });

    testWidgets('Sort menu opens and displays options', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AllNewsScreen(newsItems: testNewsItems),
        ),
      );

      // Tap the sort button
      await tester.tap(find.byIcon(Icons.sort));
      await tester.pumpAndSettle();

      // Verify menu items are displayed
      expect(find.text('Newest First'), findsOneWidget);
      expect(find.text('Oldest First'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
      expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
    });

    testWidgets('Can switch to ascending sort order', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AllNewsScreen(newsItems: testNewsItems),
        ),
      );

      // Open sort menu
      await tester.tap(find.byIcon(Icons.sort));
      await tester.pumpAndSettle();

      // Select "Oldest First" option
      await tester.tap(find.text('Oldest First'));
      await tester.pumpAndSettle();

      // Find all news card titles
      final titleFinder = find.byWidgetPredicate(
        (widget) => widget is Text && 
                    (widget.data == 'Newest News' || 
                     widget.data == 'Middle News' || 
                     widget.data == 'Oldest News' ||
                     widget.data == 'Another Middle News'),
      );

      final titles = tester.widgetList<Text>(titleFinder).map((w) => w.data).toList();
      
      // The order should now be ascending (oldest first)
      // Oct 10 < Oct 15 < Oct 28 < Nov 11
      expect(titles[0], 'Oldest News');
      expect(titles[titles.length - 1], 'Newest News');
    });

    testWidgets('Can switch back to descending sort order', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AllNewsScreen(newsItems: testNewsItems),
        ),
      );

      // Switch to ascending
      await tester.tap(find.byIcon(Icons.sort));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Oldest First'));
      await tester.pumpAndSettle();

      // Switch back to descending
      await tester.tap(find.byIcon(Icons.sort));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Newest First'));
      await tester.pumpAndSettle();

      // Find all news card titles
      final titleFinder = find.byWidgetPredicate(
        (widget) => widget is Text && 
                    (widget.data == 'Newest News' || 
                     widget.data == 'Middle News' || 
                     widget.data == 'Oldest News' ||
                     widget.data == 'Another Middle News'),
      );

      final titles = tester.widgetList<Text>(titleFinder).map((w) => w.data).toList();
      
      // Should be back to descending (newest first)
      expect(titles[0], 'Newest News');
      expect(titles[titles.length - 1], 'Oldest News');
    });

    testWidgets('Handles news items with null dates', (WidgetTester tester) async {
      final newsWithInvalidDates = [
        const NewsItem(
          title: 'Valid Date News',
          description: 'Has valid date',
          date: 'Nov 11, 2024',
          category: 'Events',
        ),
        const NewsItem(
          title: 'Invalid Date News',
          description: 'Has invalid date',
          date: 'Invalid',
          category: 'News',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: AllNewsScreen(newsItems: newsWithInvalidDates),
        ),
      );

      await tester.pumpAndSettle();

      // Should still render both items without crashing
      expect(find.text('Valid Date News'), findsOneWidget);
      expect(find.text('Invalid Date News'), findsOneWidget);
    });
  });
}
