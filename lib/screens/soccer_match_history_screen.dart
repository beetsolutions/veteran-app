import 'package:flutter/material.dart';
import '../models/soccer_match.dart';
import 'soccer_statistics_screen.dart';
import '../data/repositories/soccer_repository.dart';

class SoccerMatchHistoryScreen extends StatefulWidget {
  final SoccerRepository? soccerRepository;

  const SoccerMatchHistoryScreen({
    super.key,
    this.soccerRepository,
  });

  @override
  State<SoccerMatchHistoryScreen> createState() => _SoccerMatchHistoryScreenState();
}

class _SoccerMatchHistoryScreenState extends State<SoccerMatchHistoryScreen> {
  late final SoccerRepository _soccerRepository;
  List<SoccerMatch> _matchHistory = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _soccerRepository = widget.soccerRepository ?? SoccerRepository();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final history = await _soccerRepository.getMatchHistory();

      setState(() {
        _matchHistory = history;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load match history: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match History'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_errorMessage!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadData,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _matchHistory.isEmpty
                  ? const Center(child: Text('No match history available'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _matchHistory.length,
                      itemBuilder: (context, index) {
                        final match = _matchHistory[index];
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
