import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/models/news_item.dart';

void main() {
  group('NewsItem Model Tests', () {
    test('parsedDate returns correct DateTime for valid date', () {
      const newsItem = NewsItem(
        title: 'Test News',
        description: 'Description',
        date: 'Nov 11, 2024',
        category: 'Events',
      );

      final parsedDate = newsItem.parsedDate;
      expect(parsedDate, isNotNull);
      expect(parsedDate!.year, 2024);
      expect(parsedDate.month, 11);
      expect(parsedDate.day, 11);
    });

    test('parsedDate handles different months correctly', () {
      const testCases = [
        ('Jan 15, 2024', 1, 15),
        ('Feb 28, 2024', 2, 28),
        ('Mar 10, 2024', 3, 10),
        ('Apr 5, 2024', 4, 5),
        ('May 20, 2024', 5, 20),
        ('Jun 30, 2024', 6, 30),
        ('Jul 4, 2024', 7, 4),
        ('Aug 15, 2024', 8, 15),
        ('Sep 11, 2024', 9, 11),
        ('Oct 31, 2024', 10, 31),
        ('Nov 25, 2024', 11, 25),
        ('Dec 25, 2024', 12, 25),
      ];

      for (final (dateStr, expectedMonth, expectedDay) in testCases) {
        final newsItem = NewsItem(
          title: 'Test',
          description: 'Test',
          date: dateStr,
          category: 'Test',
        );
        
        final parsedDate = newsItem.parsedDate;
        expect(parsedDate, isNotNull, reason: 'Failed to parse: $dateStr');
        expect(parsedDate!.month, expectedMonth, reason: 'Month mismatch for: $dateStr');
        expect(parsedDate.day, expectedDay, reason: 'Day mismatch for: $dateStr');
      }
    });

    test('parsedDate returns null for invalid date format', () {
      const newsItem = NewsItem(
        title: 'Test News',
        description: 'Description',
        date: 'Invalid Date',
        category: 'Events',
      );

      expect(newsItem.parsedDate, isNull);
    });

    test('parsedDate returns null for empty date', () {
      const newsItem = NewsItem(
        title: 'Test News',
        description: 'Description',
        date: '',
        category: 'Events',
      );

      expect(newsItem.parsedDate, isNull);
    });

    test('parsedDate returns null for malformed date parts', () {
      const newsItem = NewsItem(
        title: 'Test News',
        description: 'Description',
        date: 'Nov XX, YYYY',
        category: 'Events',
      );

      expect(newsItem.parsedDate, isNull);
    });
  });
}
