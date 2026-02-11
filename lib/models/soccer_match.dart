class SoccerMatch {
  final String matchDay;
  final String homeTeam;
  final String awayTeam;
  final int homeScore;
  final int awayScore;
  final String referee;
  final String assistantReferee1;
  final String assistantReferee2;
  final List<MatchGoal> goals;
  final List<MatchAssist> assists;
  final List<MatchCard> yellowCards;
  final List<MatchCard> redCards;

  const SoccerMatch({
    required this.matchDay,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
    required this.referee,
    required this.assistantReferee1,
    required this.assistantReferee2,
    required this.goals,
    required this.assists,
    required this.yellowCards,
    required this.redCards,
  });

  factory SoccerMatch.fromJson(Map<String, dynamic> json) {
    return SoccerMatch(
      matchDay: json['matchDay'] as String,
      homeTeam: json['homeTeam'] as String,
      awayTeam: json['awayTeam'] as String,
      homeScore: json['homeScore'] as int,
      awayScore: json['awayScore'] as int,
      referee: json['referee'] as String,
      assistantReferee1: json['assistantReferee1'] as String,
      assistantReferee2: json['assistantReferee2'] as String,
      goals: (json['goals'] as List<dynamic>)
          .map((e) => MatchGoal.fromJson(e as Map<String, dynamic>))
          .toList(),
      assists: (json['assists'] as List<dynamic>)
          .map((e) => MatchAssist.fromJson(e as Map<String, dynamic>))
          .toList(),
      yellowCards: (json['yellowCards'] as List<dynamic>)
          .map((e) => MatchCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      redCards: (json['redCards'] as List<dynamic>)
          .map((e) => MatchCard.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'matchDay': matchDay,
      'homeTeam': homeTeam,
      'awayTeam': awayTeam,
      'homeScore': homeScore,
      'awayScore': awayScore,
      'referee': referee,
      'assistantReferee1': assistantReferee1,
      'assistantReferee2': assistantReferee2,
      'goals': goals.map((e) => e.toJson()).toList(),
      'assists': assists.map((e) => e.toJson()).toList(),
      'yellowCards': yellowCards.map((e) => e.toJson()).toList(),
      'redCards': redCards.map((e) => e.toJson()).toList(),
    };
  }
}

class MatchGoal {
  final String playerName;
  final String minute;
  final String team;

  const MatchGoal({
    required this.playerName,
    required this.minute,
    required this.team,
  });

  factory MatchGoal.fromJson(Map<String, dynamic> json) {
    return MatchGoal(
      playerName: json['playerName'] as String,
      minute: json['minute'] as String,
      team: json['team'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'playerName': playerName,
      'minute': minute,
      'team': team,
    };
  }
}

class MatchAssist {
  final String playerName;
  final String minute;
  final String team;

  const MatchAssist({
    required this.playerName,
    required this.minute,
    required this.team,
  });

  factory MatchAssist.fromJson(Map<String, dynamic> json) {
    return MatchAssist(
      playerName: json['playerName'] as String,
      minute: json['minute'] as String,
      team: json['team'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'playerName': playerName,
      'minute': minute,
      'team': team,
    };
  }
}

class MatchCard {
  final String playerName;
  final String minute;
  final String team;
  final String reason;

  const MatchCard({
    required this.playerName,
    required this.minute,
    required this.team,
    required this.reason,
  });

  factory MatchCard.fromJson(Map<String, dynamic> json) {
    return MatchCard(
      playerName: json['playerName'] as String,
      minute: json['minute'] as String,
      team: json['team'] as String,
      reason: json['reason'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'playerName': playerName,
      'minute': minute,
      'team': team,
      'reason': reason,
    };
  }
}
