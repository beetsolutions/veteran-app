enum MemberStatus {
  active,
  suspended,
  dismissed,
}

extension MemberStatusExtension on MemberStatus {
  String toJson() {
    return name;
  }

  static MemberStatus fromJson(String value) {
    return MemberStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => MemberStatus.active,
    );
  }
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

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      isPaid: json['isPaid'] as bool? ?? false,
      status: MemberStatusExtension.fromJson(json['status'] as String? ?? 'active'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'isPaid': isPaid,
      'status': status.toJson(),
    };
  }

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
