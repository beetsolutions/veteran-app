import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/models/meeting.dart';

void main() {
  group('Meeting Model Tests', () {
    test('Meeting fromJson creates correct Meeting instance', () {
      final json = {
        'id': '1',
        'title': 'Test Meeting',
        'date': 'Feb 1, 2026',
        'venue': 'Test Venue',
        'attendance': 45,
        'minutes': 'Test minutes',
        'actionPoints': ['Action 1', 'Action 2'],
        'fines': [
          {'memberName': 'John Doe', 'amount': 25.0, 'reason': 'Late'},
        ],
      };

      final meeting = Meeting.fromJson(json);

      expect(meeting.id, '1');
      expect(meeting.title, 'Test Meeting');
      expect(meeting.date, 'Feb 1, 2026');
      expect(meeting.venue, 'Test Venue');
      expect(meeting.attendance, 45);
      expect(meeting.minutes, 'Test minutes');
      expect(meeting.actionPoints, hasLength(2));
      expect(meeting.fines, hasLength(1));
    });

    test('Meeting toJson creates correct JSON', () {
      const meeting = Meeting(
        id: '1',
        title: 'Test Meeting',
        date: 'Feb 1, 2026',
        venue: 'Test Venue',
        attendance: 45,
        minutes: 'Test minutes',
        actionPoints: ['Action 1', 'Action 2'],
        fines: [
          Fine(memberName: 'John Doe', amount: 25.0, reason: 'Late'),
        ],
      );

      final json = meeting.toJson();

      expect(json['id'], '1');
      expect(json['title'], 'Test Meeting');
      expect(json['date'], 'Feb 1, 2026');
      expect(json['venue'], 'Test Venue');
      expect(json['attendance'], 45);
      expect(json['minutes'], 'Test minutes');
      expect(json['actionPoints'], hasLength(2));
      expect(json['fines'], hasLength(1));
    });

    test('parsedDate returns correct DateTime for valid date', () {
      const meeting = Meeting(
        id: '1',
        title: 'Test Meeting',
        date: 'Feb 1, 2026',
        venue: 'Test Venue',
        attendance: 45,
      );

      final parsedDate = meeting.parsedDate;
      expect(parsedDate, isNotNull);
      expect(parsedDate!.year, 2026);
      expect(parsedDate.month, 2);
      expect(parsedDate.day, 1);
    });

    test('parsedDate handles different months correctly', () {
      const testCases = [
        ('Jan 15, 2026', 1, 15),
        ('Feb 28, 2026', 2, 28),
        ('Mar 10, 2026', 3, 10),
        ('Dec 25, 2026', 12, 25),
      ];

      for (final (dateStr, expectedMonth, expectedDay) in testCases) {
        final meeting = Meeting(
          id: '1',
          title: 'Test',
          date: dateStr,
          venue: 'Test',
          attendance: 10,
        );

        final parsedDate = meeting.parsedDate;
        expect(parsedDate, isNotNull, reason: 'Failed to parse: $dateStr');
        expect(parsedDate!.month, expectedMonth, reason: 'Month mismatch for: $dateStr');
        expect(parsedDate.day, expectedDay, reason: 'Day mismatch for: $dateStr');
      }
    });

    test('parsedDate returns null for invalid date format', () {
      const meeting = Meeting(
        id: '1',
        title: 'Test Meeting',
        date: 'Invalid Date',
        venue: 'Test Venue',
        attendance: 45,
      );

      expect(meeting.parsedDate, isNull);
    });
  });

  group('Fine Model Tests', () {
    test('Fine fromJson creates correct Fine instance', () {
      final json = {
        'memberName': 'John Doe',
        'amount': 25.5,
        'reason': 'Late arrival',
      };

      final fine = Fine.fromJson(json);

      expect(fine.memberName, 'John Doe');
      expect(fine.amount, 25.5);
      expect(fine.reason, 'Late arrival');
    });

    test('Fine toJson creates correct JSON', () {
      const fine = Fine(
        memberName: 'John Doe',
        amount: 25.5,
        reason: 'Late arrival',
      );

      final json = fine.toJson();

      expect(json['memberName'], 'John Doe');
      expect(json['amount'], 25.5);
      expect(json['reason'], 'Late arrival');
    });
  });
}
