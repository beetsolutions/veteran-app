enum MemberStatus {
  active,
  suspended,
  dismissed,
}

class Member {
  final String id;
  final String name;
  final String location;
  final bool isPaid;
  final MemberStatus status;

  const Member({
    required this.id,
    required this.name,
    required this.location,
    this.isPaid = false,
    this.status = MemberStatus.active,
  });

  Member copyWith({
    String? id,
    String? name,
    String? location,
    bool? isPaid,
    MemberStatus? status,
  }) {
    return Member(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      isPaid: isPaid ?? this.isPaid,
      status: status ?? this.status,
    );
  }
}
