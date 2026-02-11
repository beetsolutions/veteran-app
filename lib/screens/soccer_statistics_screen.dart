import 'package:flutter/material.dart';
import '../models/soccer_match.dart';
import 'soccer_match_history_screen.dart';
import '../data/repositories/soccer_repository.dart';

class SoccerStatisticsScreen extends StatefulWidget {
  final SoccerRepository? soccerRepository;

  const SoccerStatisticsScreen({
    super.key,
    this.soccerRepository,
  });

  @override
  State<SoccerStatisticsScreen> createState() => _SoccerStatisticsScreenState();
}

class _SoccerStatisticsScreenState extends State<SoccerStatisticsScreen> {
  late final SoccerRepository _soccerRepository;
  SoccerMatch? _currentMatch;
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

      final match = await _soccerRepository.getCurrentMatch();

      setState(() {
        _currentMatch = match;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load match data: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soccer Statistics'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SoccerMatchHistoryScreen(),
            ),
          );
        },
        icon: const Icon(Icons.history),
        label: const Text('Match History'),
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
              : _currentMatch == null
                  ? const Center(child: Text('No match data available'))
                  : SingleChildScrollView(
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
                              value: _currentMatch!.matchDay,
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
                              value: _currentMatch!.referee,
                            ),
                            const SizedBox(height: 8),
                            _buildInfoCard(
                              icon: Icons.assistant_photo,
                              iconColor: Colors.orange,
                              title: 'Assistant Referee 1',
                              value: _currentMatch!.assistantReferee1,
                            ),
                            const SizedBox(height: 8),
                            _buildInfoCard(
                              icon: Icons.assistant_photo,
                              iconColor: Colors.orange,
                              title: 'Assistant Referee 2',
                              value: _currentMatch!.assistantReferee2,
                            ),
                            const SizedBox(height: 24),

                            // Goals Section
                            _buildSectionHeader('Goals (${_currentMatch!.goals.length})'),
                            const SizedBox(height: 12),
                            ..._currentMatch!.goals.map((goal) => Padding(
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
                            _buildSectionHeader('Assists (${_currentMatch!.assists.length})'),
                            const SizedBox(height: 12),
                            ..._currentMatch!.assists.map((assist) => Padding(
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
                            _buildSectionHeader('Yellow Cards (${_currentMatch!.yellowCards.length})'),
                            const SizedBox(height: 12),
                            ..._currentMatch!.yellowCards.map((card) => Padding(
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
                            _buildSectionHeader('Red Cards (${_currentMatch!.redCards.length})'),
                            const SizedBox(height: 12),
                            ..._currentMatch!.redCards.map((card) => Padding(
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
                    _currentMatch!.homeTeam,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_currentMatch!.homeScore}',
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
                    _currentMatch!.awayTeam,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_currentMatch!.awayScore}',
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
}
