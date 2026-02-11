import 'api_client.dart';
import '../../models/soccer_match.dart';

class SoccerApi {
  final ApiClient _client;

  SoccerApi(this._client);

  /// Get current soccer match
  Future<SoccerMatch> getCurrentMatch() async {
    try {
      final data = await _client.get('/soccer/current');
      return SoccerMatch.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      // For now, return mock data if API fails (development mode)
      return _getMockMatch();
    }
  }

  /// Get soccer match history
  Future<List<SoccerMatch>> getMatchHistory() async {
    try {
      final data = await _client.get('/soccer/history');
      return (data as List<dynamic>)
          .map((json) => SoccerMatch.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // For now, return mock data if API fails (development mode)
      return _getMockMatchHistory();
    }
  }

  /// Mock data for development
  SoccerMatch _getMockMatch() {
    return const SoccerMatch(
      matchDay: 'Saturday, February 10, 2026',
      homeTeam: 'Veterans United FC',
      awayTeam: 'City Rovers',
      homeScore: 3,
      awayScore: 1,
      referee: 'John Smith',
      assistantReferee1: 'Mike Johnson',
      assistantReferee2: 'Sarah Williams',
      goals: [
        MatchGoal(playerName: 'David Martinez', minute: '23\'', team: 'Home'),
        MatchGoal(playerName: 'James Wilson', minute: '45\'', team: 'Away'),
        MatchGoal(playerName: 'David Martinez', minute: '67\'', team: 'Home'),
        MatchGoal(playerName: 'Robert Brown', minute: '82\'', team: 'Home'),
      ],
      assists: [
        MatchAssist(playerName: 'Chris Anderson', minute: '23\'', team: 'Home'),
        MatchAssist(playerName: 'Tom Davis', minute: '45\'', team: 'Away'),
        MatchAssist(playerName: 'Chris Anderson', minute: '67\'', team: 'Home'),
        MatchAssist(playerName: 'Kevin Moore', minute: '82\'', team: 'Home'),
      ],
      yellowCards: [
        MatchCard(
          playerName: 'Paul Taylor',
          minute: '31\'',
          team: 'Away',
          reason: 'Unsporting behavior',
        ),
        MatchCard(
          playerName: 'Mark Thompson',
          minute: '58\'',
          team: 'Home',
          reason: 'Time wasting',
        ),
        MatchCard(
          playerName: 'Steve Harris',
          minute: '74\'',
          team: 'Away',
          reason: 'Tactical foul',
        ),
      ],
      redCards: [
        MatchCard(
          playerName: 'Alex White',
          minute: '89\'',
          team: 'Away',
          reason: 'Violent conduct',
        ),
      ],
    );
  }

  List<SoccerMatch> _getMockMatchHistory() {
    return [_getMockMatch()];
  }
}
