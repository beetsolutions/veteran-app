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
}
