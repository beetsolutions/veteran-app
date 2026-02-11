import 'package:flutter/material.dart';
import '../models/soccer_match.dart';

class SoccerStatisticsScreen extends StatelessWidget {
  const SoccerStatisticsScreen({super.key});

  // Sample data for demonstration
  static const SoccerMatch _sampleMatch = SoccerMatch(
    matchDay: 'Saturday, February 10, 2026',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soccer Statistics'),
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
                value: _sampleMatch.matchDay,
              ),
              const SizedBox(height: 16),
              _buildSectionHeader('Match Officials'),
              const SizedBox(height: 12),
              _buildInfoCard(
                icon: Icons.sports,
                iconColor: Colors.orange,
                title: 'Referee',
                value: _sampleMatch.referee,
              ),
              const SizedBox(height: 8),
              _buildInfoCard(
                icon: Icons.assistant_photo,
                iconColor: Colors.orange,
                title: 'Assistant Referee 1',
                value: _sampleMatch.assistantReferee1,
              ),
              const SizedBox(height: 8),
              _buildInfoCard(
                icon: Icons.assistant_photo,
                iconColor: Colors.orange,
                title: 'Assistant Referee 2',
                value: _sampleMatch.assistantReferee2,
              ),
              const SizedBox(height: 24),

              // Goals Section
              _buildSectionHeader('Goals (${_sampleMatch.goals.length})'),
              const SizedBox(height: 12),
              ..._sampleMatch.goals.map((goal) => Padding(
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
              _buildSectionHeader('Assists (${_sampleMatch.assists.length})'),
              const SizedBox(height: 12),
              ..._sampleMatch.assists.map((assist) => Padding(
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
              _buildSectionHeader('Yellow Cards (${_sampleMatch.yellowCards.length})'),
              const SizedBox(height: 12),
              ..._sampleMatch.yellowCards.map((card) => Padding(
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
              _buildSectionHeader('Red Cards (${_sampleMatch.redCards.length})'),
              const SizedBox(height: 12),
              ..._sampleMatch.redCards.map((card) => Padding(
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
