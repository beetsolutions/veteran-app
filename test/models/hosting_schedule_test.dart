import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/models/member.dart';
import 'package:veteranapp/models/hosting_schedule.dart';

void main() {
  group('HostingSchedule Model Tests', () {
    final testMembers = [
      const Member(id: '1', name: 'John Doe', location: 'New York, NY', isPaid: true),
      const Member(id: '2', name: 'Jane Smith', location: 'Los Angeles, CA', isPaid: true),
      const Member(id: '3', name: 'Robert Johnson', location: 'Chicago, IL', isPaid: false),
      const Member(id: '4', name: 'Mary Williams', location: 'Houston, TX', isPaid: true),
      const Member(id: '5', name: 'James Brown', location: 'Phoenix, AZ', isPaid: false),
    ];

    final testHosts = [
      testMembers[0],
      testMembers[1],
      testMembers[2],
    ];

    test('HostingSchedule can be created with all properties', () {
      final schedule = HostingSchedule(
        id: 'schedule_1',
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 15),
        hosts: testHosts,
        allMembers: testMembers,
      );

      expect(schedule.id, 'schedule_1');
      expect(schedule.hosts.length, 3);
      expect(schedule.allMembers.length, 5);
      expect(schedule.contributionAmount, 30.0);
    });

    test('HostingSchedule isActive returns true when current date is within period', () {
      final now = DateTime.now();
      final schedule = HostingSchedule(
        id: 'schedule_1',
        startDate: now.subtract(const Duration(days: 7)),
        endDate: now.add(const Duration(days: 7)),
        hosts: testHosts,
        allMembers: testMembers,
      );

      expect(schedule.isActive, true);
      expect(schedule.isUpcoming, false);
      expect(schedule.isPast, false);
    });

    test('HostingSchedule isUpcoming returns true when current date is before period', () {
      final now = DateTime.now();
      final schedule = HostingSchedule(
        id: 'schedule_1',
        startDate: now.add(const Duration(days: 7)),
        endDate: now.add(const Duration(days: 21)),
        hosts: testHosts,
        allMembers: testMembers,
      );

      expect(schedule.isActive, false);
      expect(schedule.isUpcoming, true);
      expect(schedule.isPast, false);
    });

    test('HostingSchedule isPast returns true when current date is after period', () {
      final now = DateTime.now();
      final schedule = HostingSchedule(
        id: 'schedule_1',
        startDate: now.subtract(const Duration(days: 21)),
        endDate: now.subtract(const Duration(days: 7)),
        hosts: testHosts,
        allMembers: testMembers,
      );

      expect(schedule.isActive, false);
      expect(schedule.isUpcoming, false);
      expect(schedule.isPast, true);
    });

    test('HostingSchedule daysRemaining calculates correctly', () {
      final now = DateTime.now();
      final schedule = HostingSchedule(
        id: 'schedule_1',
        startDate: now.subtract(const Duration(days: 7)),
        endDate: now.add(const Duration(days: 7)),
        hosts: testHosts,
        allMembers: testMembers,
      );

      expect(schedule.daysRemaining, 7);
    });

    test('HostingSchedule daysRemaining returns 0 for past schedules', () {
      final now = DateTime.now();
      final schedule = HostingSchedule(
        id: 'schedule_1',
        startDate: now.subtract(const Duration(days: 21)),
        endDate: now.subtract(const Duration(days: 7)),
        hosts: testHosts,
        allMembers: testMembers,
      );

      expect(schedule.daysRemaining, 0);
    });

    test('HostingSchedule paidMembers returns only paid members', () {
      final schedule = HostingSchedule(
        id: 'schedule_1',
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 15),
        hosts: testHosts,
        allMembers: testMembers,
      );

      expect(schedule.paidMembers.length, 3);
      expect(schedule.paidMembers.every((m) => m.isPaid), true);
    });

    test('HostingSchedule unpaidMembers returns only unpaid members', () {
      final schedule = HostingSchedule(
        id: 'schedule_1',
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 15),
        hosts: testHosts,
        allMembers: testMembers,
      );

      expect(schedule.unpaidMembers.length, 2);
      expect(schedule.unpaidMembers.every((m) => !m.isPaid), true);
    });

    test('HostingSchedule calculates total amounts correctly', () {
      final schedule = HostingSchedule(
        id: 'schedule_1',
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 15),
        hosts: testHosts,
        allMembers: testMembers,
        contributionAmount: 30.0,
      );

      expect(schedule.totalCollected, 90.0); // 3 paid members * £30
      expect(schedule.totalPending, 60.0); // 2 unpaid members * £30
      expect(schedule.totalExpected, 150.0); // 5 total members * £30
    });

    test('HostingSchedule calculates payment progress correctly', () {
      final schedule = HostingSchedule(
        id: 'schedule_1',
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 15),
        hosts: testHosts,
        allMembers: testMembers,
      );

      expect(schedule.paymentProgress, 60.0); // 3 paid out of 5 = 60%
    });

    test('HostingSchedule payment progress is 0 when no members', () {
      final schedule = HostingSchedule(
        id: 'schedule_1',
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 15),
        hosts: [],
        allMembers: [],
      );

      expect(schedule.paymentProgress, 0.0);
    });

    test('HostingSchedule uses custom contribution amount', () {
      final schedule = HostingSchedule(
        id: 'schedule_1',
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 15),
        hosts: testHosts,
        allMembers: testMembers,
        contributionAmount: 50.0,
      );

      expect(schedule.totalCollected, 150.0); // 3 paid members * £50
      expect(schedule.totalPending, 100.0); // 2 unpaid members * £50
      expect(schedule.totalExpected, 250.0); // 5 total members * £50
    });
  });
}
