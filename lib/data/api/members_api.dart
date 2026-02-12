import 'api_client.dart';
import '../../models/member.dart';

class MembersApi {
  final ApiClient _client;

  MembersApi(this._client);

  /// Get all members
  Future<List<Member>> getMembers({String? organizationId}) async {
    try {
      final endpoint = organizationId != null 
          ? '/members?organizationId=$organizationId'
          : '/members';
      final data = await _client.get(endpoint);
      return (data as List<dynamic>)
          .map((json) => Member.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // For now, return mock data if API fails (development mode)
      return _getMockMembers();
    }
  }

  /// Get member by ID
  Future<Member> getMemberById(String id, {String? organizationId}) async {
    try {
      final endpoint = organizationId != null
          ? '/members/$id?organizationId=$organizationId'
          : '/members/$id';
      final data = await _client.get(endpoint);
      return Member.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      // Return first matching mock member
      return _getMockMembers().firstWhere((m) => m.id == id);
    }
  }

  /// Mock data for development
  List<Member> _getMockMembers() {
    return const [
      Member(id: '1', name: 'John Doe', location: 'New York, NY', isPaid: true, status: MemberStatus.active, role: 'President', service: 'Army'),
      Member(id: '2', name: 'Jane Smith', location: 'Los Angeles, CA', isPaid: true, status: MemberStatus.active, role: 'Vice President', service: 'Navy'),
      Member(id: '3', name: 'Robert Johnson', location: 'Chicago, IL', isPaid: false, status: MemberStatus.active, role: 'Secretary', service: 'Air Force'),
      Member(id: '4', name: 'Mary Williams', location: 'Houston, TX', isPaid: true, status: MemberStatus.active, role: 'Treasurer', service: 'Marines'),
      Member(id: '5', name: 'James Brown', location: 'Phoenix, AZ', isPaid: false, status: MemberStatus.active, role: 'Member', service: 'Coast Guard'),
      Member(id: '6', name: 'Patricia Garcia', location: 'Philadelphia, PA', isPaid: true, status: MemberStatus.suspended, role: 'Member', service: 'Army'),
      Member(id: '7', name: 'Michael Davis', location: 'San Antonio, TX', isPaid: false, status: MemberStatus.suspended, role: 'Member', service: 'Navy'),
      Member(id: '8', name: 'Linda Martinez', location: 'San Diego, CA', isPaid: true, status: MemberStatus.active, role: 'Member', service: 'Air Force'),
      Member(id: '9', name: 'Thomas Wilson', location: 'Dallas, TX', isPaid: false, status: MemberStatus.dismissed, role: 'Member', service: 'Air Force'),
      Member(id: '10', name: 'Jennifer Martinez', location: 'San Jose, CA', isPaid: false, status: MemberStatus.dismissed, role: 'Member', service: 'Marines'),
    ];
  }
}
