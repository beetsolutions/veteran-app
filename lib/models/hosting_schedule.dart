import 'member.dart';

class HostingSchedule {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final List<Member> hosts;
  final List<Member> allMembers;
  final double contributionAmount;

  const HostingSchedule({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.hosts,
    required this.allMembers,
    this.contributionAmount = 30.0,
  });

  factory HostingSchedule.fromJson(Map<String, dynamic> json) {
    return HostingSchedule(
      id: json['id'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      hosts: (json['hosts'] as List<dynamic>)
          .map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
      allMembers: (json['allMembers'] as List<dynamic>)
          .map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
      contributionAmount: (json['contributionAmount'] as num?)?.toDouble() ?? 30.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'hosts': hosts.map((e) => e.toJson()).toList(),
      'allMembers': allMembers.map((e) => e.toJson()).toList(),
      'contributionAmount': contributionAmount,
    };
  }

  /// Check if this schedule is currently active
  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }

  /// Check if this schedule is upcoming
  bool get isUpcoming {
    final now = DateTime.now();
    return now.isBefore(startDate);
  }

  /// Check if this schedule is past
  bool get isPast {
    final now = DateTime.now();
    return now.isAfter(endDate);
  }

  /// Get the number of days remaining in this rotation
  int get daysRemaining {
    final now = DateTime.now();
    if (isPast) return 0;
    return endDate.difference(now).inDays;
  }

  /// Get list of members who have paid
  List<Member> get paidMembers {
    return allMembers.where((m) => m.isPaid).toList();
  }

  /// Get list of members who have not paid
  List<Member> get unpaidMembers {
    return allMembers.where((m) => !m.isPaid).toList();
  }

  /// Calculate total amount collected
  double get totalCollected {
    return paidMembers.length * contributionAmount;
  }

  /// Calculate total amount pending
  double get totalPending {
    return unpaidMembers.length * contributionAmount;
  }

  /// Calculate total expected amount
  double get totalExpected {
    return allMembers.length * contributionAmount;
  }

  /// Get payment completion percentage
  double get paymentProgress {
    if (allMembers.isEmpty) return 0.0;
    return (paidMembers.length / allMembers.length) * 100;
  }
}
