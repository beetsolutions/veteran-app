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
      );

      expect(member.id, '1');
      expect(member.name, 'John Doe');
      expect(member.location, 'New York, NY');
      expect(member.isPaid, true);
    });

    test('Member can be created with default isPaid value', () {
      const member = Member(
        id: '1',
        name: 'John Doe',
        location: 'New York, NY',
      );

      expect(member.isPaid, false);
    });

    test('Member copyWith creates a new instance with updated values', () {
      const member = Member(
        id: '1',
        name: 'John Doe',
        location: 'New York, NY',
        isPaid: false,
      );

      final updatedMember = member.copyWith(isPaid: true);

      expect(updatedMember.id, '1');
      expect(updatedMember.name, 'John Doe');
      expect(updatedMember.location, 'New York, NY');
      expect(updatedMember.isPaid, true);
      // Original should be unchanged
      expect(member.isPaid, false);
    });

    test('Member copyWith without parameters returns identical member', () {
      const member = Member(
        id: '1',
        name: 'John Doe',
        location: 'New York, NY',
        isPaid: true,
      );

      final copiedMember = member.copyWith();

      expect(copiedMember.id, member.id);
      expect(copiedMember.name, member.name);
      expect(copiedMember.location, member.location);
      expect(copiedMember.isPaid, member.isPaid);
    });
  });
}
