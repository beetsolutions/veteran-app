import 'package:flutter/material.dart';
import '../models/soccer_match.dart';
import 'soccer_match_history_screen.dart';
import '../data/repositories/soccer_repository.dart';
import '../utils/responsive_utils.dart';

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
                        padding: EdgeInsets.all(
                          ResponsiveUtils.getPadding(context, mobile: 16.0, tablet: 24.0, desktop: 32.0)
                        ),
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
    final fontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 20.0,
      tablet: 22.0,
      desktop: 24.0,
    );
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
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
    final padding = ResponsiveUtils.getPadding(
      context,
      mobile: 16.0,
      tablet: 20.0,
      desktop: 24.0,
    );
    final iconSize = ResponsiveUtils.getIconSize(
      context,
      mobile: 32.0,
      tablet: 36.0,
      desktop: 40.0,
    );
    final spacing = ResponsiveUtils.getSpacing(
      context,
      mobile: 16.0,
      tablet: 18.0,
      desktop: 20.0,
    );
    final titleFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 14.0,
      tablet: 15.0,
      desktop: 16.0,
    );
    final valueFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 16.0,
      tablet: 18.0,
      desktop: 20.0,
    );

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: iconSize),
            SizedBox(width: spacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: valueFontSize,
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
    final padding = ResponsiveUtils.getPadding(
      context,
      mobile: 16.0,
      tablet: 20.0,
      desktop: 24.0,
    );
    final iconSize = ResponsiveUtils.getIconSize(
      context,
      mobile: 32.0,
      tablet: 36.0,
      desktop: 40.0,
    );
    final spacing = ResponsiveUtils.getSpacing(
      context,
      mobile: 16.0,
      tablet: 18.0,
      desktop: 20.0,
    );
    final nameFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 16.0,
      tablet: 17.0,
      desktop: 18.0,
    );
    final detailFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 14.0,
      tablet: 15.0,
      desktop: 16.0,
    );

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: iconSize),
            SizedBox(width: spacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playerName,
                    style: TextStyle(
                      fontSize: nameFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$team • $minute',
                    style: TextStyle(
                      fontSize: detailFontSize,
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
    final padding = ResponsiveUtils.getPadding(
      context,
      mobile: 16.0,
      tablet: 20.0,
      desktop: 24.0,
    );
    final iconSize = ResponsiveUtils.getIconSize(
      context,
      mobile: 32.0,
      tablet: 36.0,
      desktop: 40.0,
    );
    final spacing = ResponsiveUtils.getSpacing(
      context,
      mobile: 16.0,
      tablet: 18.0,
      desktop: 20.0,
    );
    final nameFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 16.0,
      tablet: 17.0,
      desktop: 18.0,
    );
    final detailFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 14.0,
      tablet: 15.0,
      desktop: 16.0,
    );

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: iconSize),
            SizedBox(width: spacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playerName,
                    style: TextStyle(
                      fontSize: nameFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$team • $minute',
                    style: TextStyle(
                      fontSize: detailFontSize,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    reason,
                    style: TextStyle(
                      fontSize: detailFontSize - 1,
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
    final padding = ResponsiveUtils.getPadding(
      context,
      mobile: 16.0,
      tablet: 20.0,
      desktop: 24.0,
    );
    final teamFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 18.0,
      tablet: 20.0,
      desktop: 22.0,
    );
    final scoreFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 36.0,
      tablet: 40.0,
      desktop: 44.0,
    );

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    _currentMatch!.homeTeam,
                    style: TextStyle(
                      fontSize: teamFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_currentMatch!.homeScore}',
                    style: TextStyle(
                      fontSize: scoreFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '-',
              style: TextStyle(
                fontSize: teamFontSize + 6,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    _currentMatch!.awayTeam,
                    style: TextStyle(
                      fontSize: teamFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_currentMatch!.awayScore}',
                    style: TextStyle(
                      fontSize: scoreFontSize,
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
