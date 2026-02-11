class Member {
  final String id;
  final String name;
  final String location;
  final bool isPaid;

  const Member({
    required this.id,
    required this.name,
    required this.location,
    this.isPaid = false,
  });

  Member copyWith({
    String? id,
    String? name,
    String? location,
    bool? isPaid,
  }) {
    return Member(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      isPaid: isPaid ?? this.isPaid,
    );
  }
}
