import 'api_client.dart';
import '../../models/meeting.dart';

class MeetingsApi {
  final ApiClient _client;

  MeetingsApi(this._client);

  /// Get all meetings
  Future<List<Meeting>> getMeetings({String? organizationId}) async {
    try {
      final endpoint = organizationId != null
          ? '/meetings?organizationId=$organizationId'
          : '/meetings';
      final data = await _client.get(endpoint);
      return (data as List<dynamic>)
          .map((json) => Meeting.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // For now, return mock data if API fails (development mode)
      return _getMockMeetings();
    }
  }

  /// Get meeting by ID
  Future<Meeting> getMeetingById(String id, {String? organizationId}) async {
    try {
      final endpoint = organizationId != null
          ? '/meetings/$id?organizationId=$organizationId'
          : '/meetings/$id';
      final data = await _client.get(endpoint);
      return Meeting.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      // For now, return mock data if API fails (development mode)
      final meetings = _getMockMeetings();
      final meeting = meetings.firstWhere(
        (m) => m.id == id,
        orElse: () => throw Exception('Meeting not found'),
      );
      return meeting;
    }
  }

  /// Mock data for development
  List<Meeting> _getMockMeetings() {
    return const [
      Meeting(
        id: '1',
        title: 'Monthly General Meeting',
        date: 'Feb 1, 2026',
        venue: 'Veterans Community Center',
        attendance: 45,
        minutes: 'The monthly general meeting was called to order at 6:00 PM by President John Doe. The minutes from the previous meeting were read and approved. The treasurer reported a current balance of \$25,000. Discussion included upcoming Veterans Day ceremony planning and new member recruitment strategies. The meeting was adjourned at 8:00 PM.',
        actionPoints: [
          'Form committee for Veterans Day ceremony planning',
          'Create recruitment flyer for new members',
          'Schedule maintenance for community center',
          'Review and update membership database'
        ],
        fines: [
          Fine(memberName: 'James Brown', amount: 25.00, reason: 'Late arrival'),
          Fine(memberName: 'Patricia Garcia', amount: 50.00, reason: 'Unexcused absence from previous meeting'),
        ],
      ),
      Meeting(
        id: '2',
        title: 'Emergency Board Meeting',
        date: 'Jan 20, 2026',
        venue: 'Online via Video Conference',
        attendance: 12,
        minutes: 'Emergency board meeting convened to address urgent facility maintenance issues. The board discussed and approved emergency repair funding of \$3,000 for roof repairs. All board members present voted unanimously in favor. Meeting concluded with plans to schedule contractor visits.',
        actionPoints: [
          'Contact three contractors for repair quotes',
          'Schedule emergency repairs within two weeks',
          'Document all expenses for insurance claims'
        ],
        fines: [],
      ),
      Meeting(
        id: '3',
        title: 'Annual Planning Session',
        date: 'Jan 5, 2026',
        venue: 'Veterans Community Center',
        attendance: 38,
        minutes: 'Annual planning session covered goals and objectives for 2026. Key discussion points included membership growth targets, fundraising initiatives, and community outreach programs. The organization set a goal of 200 total members by year end. Budget allocation for various programs was reviewed and approved.',
        actionPoints: [
          'Develop marketing plan for membership growth',
          'Organize quarterly fundraising events',
          'Establish partnership with local schools for outreach',
          'Create annual budget spreadsheet'
        ],
        fines: [
          Fine(memberName: 'Michael Davis', amount: 25.00, reason: 'Late arrival'),
        ],
      ),
      Meeting(
        id: '4',
        title: 'Quarterly Financial Review',
        date: 'Dec 15, 2025',
        venue: 'Veterans Community Center',
        attendance: 32,
        minutes: 'Quarterly financial review presented by Treasurer Mary Williams. Total income for Q4 was \$8,500, with expenses of \$6,200. Net positive balance of \$2,300 for the quarter. Discussed allocation of funds for upcoming projects and initiatives. All financial reports were approved by attending members.',
        actionPoints: [
          'Prepare detailed expense report for membership',
          'Plan budget allocation for next quarter',
          'Review and update financial policies'
        ],
        fines: [
          Fine(memberName: 'Thomas Wilson', amount: 50.00, reason: 'Unexcused absence from previous meeting'),
          Fine(memberName: 'James Brown', amount: 25.00, reason: 'Late arrival'),
        ],
      ),
      Meeting(
        id: '5',
        title: 'Special Events Committee Meeting',
        date: 'Dec 1, 2025',
        venue: 'Online via Video Conference',
        attendance: 15,
        minutes: 'Special events committee met to plan holiday celebration and Veterans Day ceremony. Committee members volunteered for various roles including decorations, catering coordination, and program planning. Budget of \$1,500 approved for holiday event. Next committee meeting scheduled for early January.',
        actionPoints: [
          'Book venue for holiday celebration',
          'Confirm catering arrangements',
          'Create event program and agenda',
          'Send invitations to all members'
        ],
        fines: [],
      ),
    ];
  }
}
