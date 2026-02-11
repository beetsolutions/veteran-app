import 'package:flutter/material.dart';
import '../models/soccer_match.dart';
import 'soccer_statistics_screen.dart';

class SoccerMatchHistoryScreen extends StatelessWidget {
  const SoccerMatchHistoryScreen({super.key});

  // Sample data for previous matches
  static const List<SoccerMatch> _previousMatches = [
    SoccerMatch(
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
    ),
    SoccerMatch(
      matchDay: 'Saturday, February 3, 2026',
      homeTeam: 'Veterans United FC',
      awayTeam: 'Rangers FC',
      homeScore: 2,
      awayScore: 2,
      referee: 'Emily Davis',
      assistantReferee1: 'Tom Wilson',
      assistantReferee2: 'Lisa Brown',
      goals: [
        MatchGoal(playerName: 'Chris Anderson', minute: '15\'', team: 'Home'),
        MatchGoal(playerName: 'Peter Green', minute: '28\'', team: 'Away'),
        MatchGoal(playerName: 'David Martinez', minute: '56\'', team: 'Home'),
        MatchGoal(playerName: 'Luke Adams', minute: '73\'', team: 'Away'),
      ],
      assists: [
        MatchAssist(playerName: 'Kevin Moore', minute: '15\'', team: 'Home'),
        MatchAssist(playerName: 'Sam Clark', minute: '28\'', team: 'Away'),
        MatchAssist(playerName: 'Robert Brown', minute: '56\'', team: 'Home'),
        MatchAssist(playerName: 'Peter Green', minute: '73\'', team: 'Away'),
      ],
      yellowCards: [
        MatchCard(
          playerName: 'Mark Thompson',
          minute: '42\'',
          team: 'Home',
          reason: 'Delaying restart',
        ),
        MatchCard(
          playerName: 'Sam Clark',
          minute: '65\'',
          team: 'Away',
          reason: 'Tactical foul',
        ),
      ],
      redCards: [],
    ),
    SoccerMatch(
      matchDay: 'Saturday, January 27, 2026',
      homeTeam: 'Thunder United',
      awayTeam: 'Veterans United FC',
      homeScore: 1,
      awayScore: 4,
      referee: 'Michael Brown',
      assistantReferee1: 'Sarah Williams',
      assistantReferee2: 'John Anderson',
      goals: [
        MatchGoal(playerName: 'David Martinez', minute: '12\'', team: 'Away'),
        MatchGoal(playerName: 'Brian White', minute: '34\'', team: 'Home'),
        MatchGoal(playerName: 'Robert Brown', minute: '58\'', team: 'Away'),
        MatchGoal(playerName: 'Chris Anderson', minute: '71\'', team: 'Away'),
        MatchGoal(playerName: 'David Martinez', minute: '85\'', team: 'Away'),
      ],
      assists: [
        MatchAssist(playerName: 'Chris Anderson', minute: '12\'', team: 'Away'),
        MatchAssist(playerName: 'Jake Miller', minute: '34\'', team: 'Home'),
        MatchAssist(playerName: 'Kevin Moore', minute: '58\'', team: 'Away'),
        MatchAssist(playerName: 'Robert Brown', minute: '71\'', team: 'Away'),
        MatchAssist(playerName: 'Chris Anderson', minute: '85\'', team: 'Away'),
      ],
      yellowCards: [
        MatchCard(
          playerName: 'Jake Miller',
          minute: '44\'',
          team: 'Home',
          reason: 'Unsporting behavior',
        ),
      ],
      redCards: [],
    ),
    SoccerMatch(
      matchDay: 'Saturday, January 20, 2026',
      homeTeam: 'Veterans United FC',
      awayTeam: 'Eagles FC',
      homeScore: 1,
      awayScore: 0,
      referee: 'James Taylor',
      assistantReferee1: 'Mike Johnson',
      assistantReferee2: 'Robert Clark',
      goals: [
        MatchGoal(playerName: 'Robert Brown', minute: '66\'', team: 'Home'),
      ],
      assists: [
        MatchAssist(playerName: 'David Martinez', minute: '66\'', team: 'Home'),
      ],
      yellowCards: [
        MatchCard(
          playerName: 'Chris Anderson',
          minute: '52\'',
          team: 'Home',
          reason: 'Time wasting',
        ),
        MatchCard(
          playerName: 'Gary Lee',
          minute: '78\'',
          team: 'Away',
          reason: 'Tactical foul',
        ),
      ],
      redCards: [],
    ),
    SoccerMatch(
      matchDay: 'Saturday, January 13, 2026',
      homeTeam: 'Wildcats FC',
      awayTeam: 'Veterans United FC',
      homeScore: 3,
      awayScore: 3,
      referee: 'William Harris',
      assistantReferee1: 'Emily Davis',
      assistantReferee2: 'Tom Wilson',
      goals: [
        MatchGoal(playerName: 'Tony Black', minute: '8\'', team: 'Home'),
        MatchGoal(playerName: 'Chris Anderson', minute: '22\'', team: 'Away'),
        MatchGoal(playerName: 'Sean Gray', minute: '35\'', team: 'Home'),
        MatchGoal(playerName: 'David Martinez', minute: '48\'', team: 'Away'),
        MatchGoal(playerName: 'Robert Brown', minute: '61\'', team: 'Away'),
        MatchGoal(playerName: 'Tony Black', minute: '89\'', team: 'Home'),
      ],
      assists: [
        MatchAssist(playerName: 'Sean Gray', minute: '8\'', team: 'Home'),
        MatchAssist(playerName: 'Kevin Moore', minute: '22\'', team: 'Away'),
        MatchAssist(playerName: 'Tony Black', minute: '35\'', team: 'Home'),
        MatchAssist(playerName: 'Chris Anderson', minute: '48\'', team: 'Away'),
        MatchAssist(playerName: 'David Martinez', minute: '61\'', team: 'Away'),
        MatchAssist(playerName: 'Jake Ross', minute: '89\'', team: 'Home'),
      ],
      yellowCards: [
        MatchCard(
          playerName: 'Mark Thompson',
          minute: '29\'',
          team: 'Away',
          reason: 'Delaying restart',
        ),
        MatchCard(
          playerName: 'Jake Ross',
          minute: '67\'',
          team: 'Home',
          reason: 'Unsporting behavior',
        ),
      ],
      redCards: [
        MatchCard(
          playerName: 'Kevin Moore',
          minute: '75\'',
          team: 'Away',
          reason: 'Second yellow card',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match History'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _previousMatches.length,
        itemBuilder: (context, index) {
          final match = _previousMatches[index];
          return _buildMatchCard(context, match);
        },
      ),
    );
  }

  Widget _buildMatchCard(BuildContext context, SoccerMatch match) {
    final int totalGoals = match.goals.length;
    final int totalYellowCards = match.yellowCards.length;
    final int totalRedCards = match.redCards.length;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          // Navigate to detailed statistics screen for this match
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SoccerStatisticsDetailScreen(match: match),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    match.matchDay,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Score
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          match.homeTeam,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${match.homeScore}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    '-',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          match.awayTeam,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${match.awayScore}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              // Statistics summary
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatChip(Icons.sports_soccer, totalGoals, Colors.green),
                  _buildStatChip(Icons.warning, totalYellowCards, Colors.yellow.shade700),
                  _buildStatChip(Icons.cancel, totalRedCards, Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip(IconData icon, int count, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 4),
        Text(
          '$count',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// Detailed statistics screen that receives a match as parameter
class SoccerStatisticsDetailScreen extends StatelessWidget {
  final SoccerMatch match;

  const SoccerStatisticsDetailScreen({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Match Day and Officials Section
              _buildSectionHeader('Match Information'),
              const SizedBox(height: 12),
              _buildInfoCard(
                icon: Icons.calendar_today,
                iconColor: Colors.blue,
                title: 'Match Day',
                value: match.matchDay,
              ),
              const SizedBox(height: 8),
              _buildScoreCard(),
              const SizedBox(height: 16),
              _buildSectionHeader('Match Officials'),
              const SizedBox(height: 12),
              _buildInfoCard(
                icon: Icons.sports,
                iconColor: Colors.orange,
                title: 'Referee',
                value: match.referee,
              ),
              const SizedBox(height: 8),
              _buildInfoCard(
                icon: Icons.assistant_photo,
                iconColor: Colors.orange,
                title: 'Assistant Referee 1',
                value: match.assistantReferee1,
              ),
              const SizedBox(height: 8),
              _buildInfoCard(
                icon: Icons.assistant_photo,
                iconColor: Colors.orange,
                title: 'Assistant Referee 2',
                value: match.assistantReferee2,
              ),
              const SizedBox(height: 24),

              // Goals Section
              _buildSectionHeader('Goals (${match.goals.length})'),
              const SizedBox(height: 12),
              ...match.goals.map((goal) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _buildStatCard(
                      icon: Icons.sports_soccer,
                      iconColor: Colors.green,
                      playerName: goal.playerName,
                      minute: goal.minute,
                      team: goal.team,
                    ),
                  )),
              const SizedBox(height: 24),

              // Assists Section
              _buildSectionHeader('Assists (${match.assists.length})'),
              const SizedBox(height: 12),
              ...match.assists.map((assist) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _buildStatCard(
                      icon: Icons.person_add,
                      iconColor: Colors.blue,
                      playerName: assist.playerName,
                      minute: assist.minute,
                      team: assist.team,
                    ),
                  )),
              const SizedBox(height: 24),

              // Yellow Cards Section
              _buildSectionHeader('Yellow Cards (${match.yellowCards.length})'),
              const SizedBox(height: 12),
              ...match.yellowCards.map((card) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _buildCardWidget(
                      icon: Icons.warning,
                      iconColor: Colors.yellow.shade700,
                      playerName: card.playerName,
                      minute: card.minute,
                      team: card.team,
                      reason: card.reason,
                    ),
                  )),
              const SizedBox(height: 24),

              // Red Cards Section
              _buildSectionHeader('Red Cards (${match.redCards.length})'),
              const SizedBox(height: 12),
              ...match.redCards.map((card) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _buildCardWidget(
                      icon: Icons.cancel,
                      iconColor: Colors.red,
                      playerName: card.playerName,
                      minute: card.minute,
                      team: card.team,
                      reason: card.reason,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    match.homeTeam,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${match.homeScore}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              '-',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    match.awayTeam,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${match.awayScore}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String playerName,
    required String minute,
    required String team,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playerName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$team • $minute',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardWidget({
    required IconData icon,
    required Color iconColor,
    required String playerName,
    required String minute,
    required String team,
    required String reason,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playerName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$team • $minute',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    reason,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
