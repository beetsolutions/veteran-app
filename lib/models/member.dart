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
  final String? role;
  final String? service;

  const Member({
    required this.id,
    required this.name,
    required this.location,
    this.isPaid = false,
    this.status = MemberStatus.active,
    this.role,
    this.service,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      isPaid: json['isPaid'] as bool? ?? false,
      status: MemberStatusExtension.fromJson(json['status'] as String? ?? 'active'),
      role: json['role'] as String?,
      service: json['service'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'isPaid': isPaid,
      'status': status.toJson(),
      'role': role,
      'service': service,
    };
  }

  Member copyWith({
    String? id,
    String? name,
    String? location,
    bool? isPaid,
    MemberStatus? status,
    String? role,
    String? service,
  }) {
    return Member(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      isPaid: isPaid ?? this.isPaid,
      status: status ?? this.status,
      role: role ?? this.role,
      service: service ?? this.service,
    );
  }
}
