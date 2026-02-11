import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/models/member.dart';

void main() {
  group('Member Model Tests', () {
    test('Member can be created with all properties', () {
      const member = Member(
        id: '1',
        name: 'John Doe',
        location: 'New York, NY',
        isPaid: true,
        status: MemberStatus.active,
      );

      expect(member.id, '1');
      expect(member.name, 'John Doe');
      expect(member.location, 'New York, NY');
      expect(member.isPaid, true);
      expect(member.status, MemberStatus.active);
    });

    test('Member can be created with default isPaid and status values', () {
      const member = Member(
        id: '1',
        name: 'John Doe',
        location: 'New York, NY',
      );

      expect(member.isPaid, false);
      expect(member.status, MemberStatus.active);
    });

    test('Member copyWith creates a new instance with updated values', () {
      const member = Member(
        id: '1',
        name: 'John Doe',
        location: 'New York, NY',
        isPaid: false,
        status: MemberStatus.active,
      );

      final updatedMember = member.copyWith(isPaid: true, status: MemberStatus.suspended);

      expect(updatedMember.id, '1');
      expect(updatedMember.name, 'John Doe');
      expect(updatedMember.location, 'New York, NY');
      expect(updatedMember.isPaid, true);
      expect(updatedMember.status, MemberStatus.suspended);
      // Original should be unchanged
      expect(member.isPaid, false);
      expect(member.status, MemberStatus.active);
    });

    test('Member copyWith without parameters returns identical member', () {
      const member = Member(
        id: '1',
        name: 'John Doe',
        location: 'New York, NY',
        isPaid: true,
        status: MemberStatus.dismissed,
      );

      final copiedMember = member.copyWith();

      expect(copiedMember.id, member.id);
      expect(copiedMember.name, member.name);
      expect(copiedMember.location, member.location);
      expect(copiedMember.isPaid, member.isPaid);
      expect(copiedMember.status, member.status);
    });

    test('Member status can be active, suspended, or dismissed', () {
      const activeMember = Member(
        id: '1',
        name: 'John Doe',
        location: 'New York, NY',
        status: MemberStatus.active,
      );
      const suspendedMember = Member(
        id: '2',
        name: 'Jane Smith',
        location: 'Los Angeles, CA',
        status: MemberStatus.suspended,
      );
      const dismissedMember = Member(
        id: '3',
        name: 'Bob Johnson',
        location: 'Chicago, IL',
        status: MemberStatus.dismissed,
      );

      expect(activeMember.status, MemberStatus.active);
      expect(suspendedMember.status, MemberStatus.suspended);
      expect(dismissedMember.status, MemberStatus.dismissed);
    });
  });
}
