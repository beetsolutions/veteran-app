import 'api_client.dart';
import '../../models/member.dart';

class MembersApi {
  final ApiClient _client;

  MembersApi(this._client);

  /// Get all members
  Future<List<Member>> getMembers() async {
    try {
      final data = await _client.get('/members');
      return (data as List<dynamic>)
          .map((json) => Member.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // For now, return mock data if API fails (development mode)
      return _getMockMembers();
    }
  }

  /// Get member by ID
  Future<Member> getMemberById(String id) async {
    try {
      final data = await _client.get('/members/$id');
      return Member.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      // Return first matching mock member
      return _getMockMembers().firstWhere((m) => m.id == id);
    }
  }

  /// Mock data for development
  List<Member> _getMockMembers() {
    return const [
      Member(id: '1', name: 'John Doe', location: 'New York, NY', isPaid: true, status: MemberStatus.active),
      Member(id: '2', name: 'Jane Smith', location: 'Los Angeles, CA', isPaid: true, status: MemberStatus.active),
      Member(id: '3', name: 'Robert Johnson', location: 'Chicago, IL', isPaid: false, status: MemberStatus.active),
      Member(id: '4', name: 'Mary Williams', location: 'Houston, TX', isPaid: true, status: MemberStatus.active),
      Member(id: '5', name: 'James Brown', location: 'Phoenix, AZ', isPaid: false, status: MemberStatus.active),
      Member(id: '6', name: 'Patricia Garcia', location: 'Philadelphia, PA', isPaid: true, status: MemberStatus.suspended),
      Member(id: '7', name: 'Michael Davis', location: 'San Antonio, TX', isPaid: false, status: MemberStatus.suspended),
      Member(id: '8', name: 'Linda Martinez', location: 'San Diego, CA', isPaid: true, status: MemberStatus.active),
      Member(id: '9', name: 'Thomas Wilson', location: 'Dallas, TX', isPaid: false, status: MemberStatus.dismissed),
      Member(id: '10', name: 'Jennifer Martinez', location: 'San Jose, CA', isPaid: false, status: MemberStatus.dismissed),
    ];
  }
}
