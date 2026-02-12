import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/meeting.dart';
import '../../widgets/meeting_card.dart';
import '../details/meeting_detail_screen.dart';
import '../../data/repositories/meetings_repository.dart';
import '../../providers/user_provider.dart';

enum MeetingSortOrder { dateAscending, dateDescending, attendance }

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
  MeetingSortOrder _sortOrder = MeetingSortOrder.dateDescending;

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

      // Get the current organization ID from UserProvider
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final organizationId = userProvider.currentOrganization?.id;

      final meetings = await _meetingsRepository.getMeetings(organizationId: organizationId);

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

  List<Meeting> get _sortedMeetings {
    final meetings = List<Meeting>.from(_meetings);
    
    meetings.sort((a, b) {
      switch (_sortOrder) {
        case MeetingSortOrder.dateAscending:
          final dateA = a.parsedDate;
          final dateB = b.parsedDate;
          
          // Handle null dates by placing them at the end
          if (dateA == null && dateB == null) return 0;
          if (dateA == null) return 1;
          if (dateB == null) return -1;
          
          return dateA.compareTo(dateB);
          
        case MeetingSortOrder.dateDescending:
          final dateA = a.parsedDate;
          final dateB = b.parsedDate;
          
          // Handle null dates by placing them at the end
          if (dateA == null && dateB == null) return 0;
          if (dateA == null) return 1;
          if (dateB == null) return -1;
          
          return dateB.compareTo(dateA);
          
        case MeetingSortOrder.attendance:
          // Sort by attendance in descending order (highest first)
          return b.attendance.compareTo(a.attendance);
      }
    });
    
    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    final sortedMeetings = _sortedMeetings;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minutes'),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<MeetingSortOrder>(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort meetings',
            onSelected: (MeetingSortOrder order) {
              setState(() {
                _sortOrder = order;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MeetingSortOrder>>[
              PopupMenuItem<MeetingSortOrder>(
                value: MeetingSortOrder.dateDescending,
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_downward,
                      size: 20,
                      color: _sortOrder == MeetingSortOrder.dateDescending 
                          ? Theme.of(context).primaryColor 
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Date: Newest First',
                      style: TextStyle(
                        fontWeight: _sortOrder == MeetingSortOrder.dateDescending 
                            ? FontWeight.bold 
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<MeetingSortOrder>(
                value: MeetingSortOrder.dateAscending,
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      size: 20,
                      color: _sortOrder == MeetingSortOrder.dateAscending 
                          ? Theme.of(context).primaryColor 
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Date: Oldest First',
                      style: TextStyle(
                        fontWeight: _sortOrder == MeetingSortOrder.dateAscending 
                            ? FontWeight.bold 
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<MeetingSortOrder>(
                value: MeetingSortOrder.attendance,
                child: Row(
                  children: [
                    Icon(
                      Icons.people,
                      size: 20,
                      color: _sortOrder == MeetingSortOrder.attendance 
                          ? Theme.of(context).primaryColor 
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Attendance: Highest First',
                      style: TextStyle(
                        fontWeight: _sortOrder == MeetingSortOrder.attendance 
                            ? FontWeight.bold 
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
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
                      itemCount: sortedMeetings.length,
                      itemBuilder: (context, index) {
                        final meeting = sortedMeetings[index];
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
