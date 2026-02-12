import 'package:flutter/material.dart';
import '../../models/meeting.dart';
import '../../widgets/meeting_card.dart';
import '../details/meeting_detail_screen.dart';
import '../../data/repositories/meetings_repository.dart';

class MinutesTab extends StatefulWidget {
  final MeetingsRepository? meetingsRepository;

  const MinutesTab({
    super.key,
    this.meetingsRepository,
  });

  @override
  State<MinutesTab> createState() => _MinutesTabState();
}

class _MinutesTabState extends State<MinutesTab> {
  late final MeetingsRepository _meetingsRepository;
  List<Meeting> _meetings = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _meetingsRepository = widget.meetingsRepository ?? MeetingsRepository();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final meetings = await _meetingsRepository.getMeetings();

      setState(() {
        _meetings = meetings;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load meetings: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minutes'),
        automaticallyImplyLeading: false,
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
              : _meetings.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.event_note, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No meetings found',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      itemCount: _meetings.length,
                      itemBuilder: (context, index) {
                        final meeting = _meetings[index];
                        return MeetingCard(
                          meeting: meeting,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MeetingDetailScreen(
                                  meeting: meeting,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
    );
  }
}
