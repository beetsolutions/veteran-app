import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/models/news_item.dart';
import 'package:veteranapp/widgets/news_card.dart';

void main() {
  group('NewsCard Widget Tests', () {
    const testNewsItem = NewsItem(
      title: 'Annual Veterans Day Ceremony',
      description: 'Join us for our annual Veterans Day ceremony honoring all who have served.',
      date: 'Nov 11, 2024',
      category: 'Events',
    );

    testWidgets('NewsCard displays news information', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NewsCard(newsItem: testNewsItem),
          ),
        ),
      );

      expect(find.text('Annual Veterans Day Ceremony'), findsOneWidget);
      expect(find.text('Nov 11, 2024'), findsOneWidget);
      expect(find.text('Events'), findsOneWidget);
      expect(find.textContaining('Join us for our annual Veterans Day ceremony'), findsOneWidget);
    });

    testWidgets('NewsCard calls onTap when tapped', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NewsCard(
              newsItem: testNewsItem,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(InkWell));
      expect(tapped, true);
    });

    testWidgets('NewsCard displays category badge with correct styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NewsCard(newsItem: testNewsItem),
          ),
        ),
      );

      expect(find.text('Events'), findsOneWidget);
      
      final categoryWidget = tester.widget<Container>(
        find.ancestor(
          of: find.text('Events'),
          matching: find.byType(Container),
        ).first,
      );
      
      expect(categoryWidget.decoration, isA<BoxDecoration>());
    });
  });
}
