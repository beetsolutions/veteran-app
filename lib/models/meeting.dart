class Meeting {
  final String id;
  final String title;
  final String date;
  final String venue;
  final int attendance;
  final String? minutes;
  final List<String>? actionPoints;
  final List<Fine>? fines;

  const Meeting({
    required this.id,
    required this.title,
    required this.date,
    required this.venue,
    required this.attendance,
    this.minutes,
    this.actionPoints,
    this.fines,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      id: json['id'] as String,
      title: json['title'] as String,
      date: json['date'] as String,
      venue: json['venue'] as String,
      attendance: json['attendance'] as int,
      minutes: json['minutes'] as String?,
      actionPoints: json['actionPoints'] != null
          ? List<String>.from(json['actionPoints'] as List)
          : null,
      fines: json['fines'] != null
          ? (json['fines'] as List)
              .map((fine) => Fine.fromJson(fine as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'venue': venue,
      'attendance': attendance,
      'minutes': minutes,
      'actionPoints': actionPoints,
      'fines': fines?.map((fine) => fine.toJson()).toList(),
    };
  }

  /// Parse the date string to DateTime for sorting purposes
  /// Expected format: "MMM dd, yyyy" (e.g., "Jan 15, 2026")
  DateTime? get parsedDate {
    final months = {
      'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4,
      'May': 5, 'Jun': 6, 'Jul': 7, 'Aug': 8,
      'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12,
    };
    
    final parts = date.split(' ');
    if (parts.length != 3) return null;
    
    final month = months[parts[0]];
    final day = int.tryParse(parts[1].replaceAll(',', ''));
    final year = int.tryParse(parts[2]);
    
    if (month != null && day != null && year != null) {
      return DateTime(year, month, day);
    }
    
    return null;
  }
}

class Fine {
  final String memberName;
  final double amount;
  final String reason;

  const Fine({
    required this.memberName,
    required this.amount,
    required this.reason,
  });

  factory Fine.fromJson(Map<String, dynamic> json) {
    return Fine(
      memberName: json['memberName'] as String,
      amount: (json['amount'] as num).toDouble(),
      reason: json['reason'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memberName': memberName,
      'amount': amount,
      'reason': reason,
    };
  }
}
