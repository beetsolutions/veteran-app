import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/models/soccer_match.dart';

void main() {
  group('SoccerMatch Model', () {
    test('SoccerMatch can be instantiated with all required fields', () {
      const match = SoccerMatch(
        matchDay: 'Saturday, February 10, 2026',
        homeTeam: 'Veterans United FC',
        awayTeam: 'City Rovers',
        homeScore: 3,
        awayScore: 1,
        referee: 'John Smith',
        assistantReferee1: 'Mike Johnson',
        assistantReferee2: 'Sarah Williams',
        goals: [],
        assists: [],
        yellowCards: [],
        redCards: [],
      );

      expect(match.matchDay, 'Saturday, February 10, 2026');
      expect(match.homeTeam, 'Veterans United FC');
      expect(match.awayTeam, 'City Rovers');
      expect(match.homeScore, 3);
      expect(match.awayScore, 1);
      expect(match.referee, 'John Smith');
      expect(match.assistantReferee1, 'Mike Johnson');
      expect(match.assistantReferee2, 'Sarah Williams');
      expect(match.goals, isEmpty);
      expect(match.assists, isEmpty);
      expect(match.yellowCards, isEmpty);
      expect(match.redCards, isEmpty);
    });

    test('SoccerMatch can contain goals', () {
      const match = SoccerMatch(
        matchDay: 'Saturday, February 10, 2026',
        homeTeam: 'Veterans United FC',
        awayTeam: 'City Rovers',
        homeScore: 2,
        awayScore: 0,
        referee: 'John Smith',
        assistantReferee1: 'Mike Johnson',
        assistantReferee2: 'Sarah Williams',
        goals: [
          MatchGoal(playerName: 'David Martinez', minute: '23\'', team: 'Home'),
          MatchGoal(playerName: 'James Wilson', minute: '45\'', team: 'Away'),
        ],
        assists: [],
        yellowCards: [],
        redCards: [],
      );

      expect(match.goals.length, 2);
      expect(match.goals[0].playerName, 'David Martinez');
      expect(match.goals[0].minute, '23\'');
      expect(match.goals[0].team, 'Home');
    });
  });

  group('MatchGoal Model', () {
    test('MatchGoal can be instantiated', () {
      const goal = MatchGoal(
        playerName: 'David Martinez',
        minute: '23\'',
        team: 'Home',
      );

      expect(goal.playerName, 'David Martinez');
      expect(goal.minute, '23\'');
      expect(goal.team, 'Home');
    });
  });

  group('MatchAssist Model', () {
    test('MatchAssist can be instantiated', () {
      const assist = MatchAssist(
        playerName: 'Chris Anderson',
        minute: '23\'',
        team: 'Home',
      );

      expect(assist.playerName, 'Chris Anderson');
      expect(assist.minute, '23\'');
      expect(assist.team, 'Home');
    });
  });

  group('MatchCard Model', () {
    test('MatchCard can be instantiated', () {
      const card = MatchCard(
        playerName: 'Paul Taylor',
        minute: '31\'',
        team: 'Away',
        reason: 'Unsporting behavior',
      );

      expect(card.playerName, 'Paul Taylor');
      expect(card.minute, '31\'');
      expect(card.team, 'Away');
      expect(card.reason, 'Unsporting behavior');
    });
  });
}
