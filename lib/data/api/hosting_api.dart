import 'api_client.dart';
import '../../models/hosting_schedule.dart';
import '../../models/member.dart';

class HostingApi {
  final ApiClient _client;

  HostingApi(this._client);

  /// Get current hosting schedule
  Future<HostingSchedule> getCurrentSchedule({String? organizationId}) async {
    try {
      final endpoint = organizationId != null
          ? '/hosting/current?organizationId=$organizationId'
          : '/hosting/current';
      final data = await _client.get(endpoint);
      return HostingSchedule.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      // For now, return mock data if API fails (development mode)
      return _getMockCurrentSchedule();
    }
  }

  /// Get next hosting schedule
  Future<HostingSchedule> getNextSchedule({String? organizationId}) async {
    try {
      final endpoint = organizationId != null
          ? '/hosting/next?organizationId=$organizationId'
          : '/hosting/next';
      final data = await _client.get(endpoint);
      return HostingSchedule.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      // For now, return mock data if API fails (development mode)
      return _getMockNextSchedule();
    }
  }

  /// Mock data for development
  HostingSchedule _getMockCurrentSchedule() {
    final now = DateTime.now();
    final referenceDate = DateTime(2024, 1, 1);
    final daysSinceReference = now.difference(referenceDate).inDays;
    final periodNumber = (daysSinceReference / 14).floor();
    final startDate = referenceDate.add(Duration(days: periodNumber * 14));
    final endDate = startDate.add(const Duration(days: 14));

    final allMembers = _getAllMembers();
    final hostIndices = [
      (periodNumber * 3) % allMembers.length,
      (periodNumber * 3 + 1) % allMembers.length,
      (periodNumber * 3 + 2) % allMembers.length,
    ];
    final hosts = hostIndices.map((i) => allMembers[i]).toList();

    return HostingSchedule(
      id: 'schedule_$periodNumber',
      startDate: startDate,
      endDate: endDate,
      hosts: hosts,
      allMembers: allMembers,
    );
  }

  HostingSchedule _getMockNextSchedule() {
    final current = _getMockCurrentSchedule();
    final nextStartDate = current.endDate;
    final nextEndDate = nextStartDate.add(const Duration(days: 14));

    final referenceDate = DateTime(2024, 1, 1);
    final daysSinceReference = nextStartDate.difference(referenceDate).inDays;
    final periodNumber = (daysSinceReference / 14).floor();

    final allMembers = _getAllMembers();
    final hostIndices = [
      (periodNumber * 3) % allMembers.length,
      (periodNumber * 3 + 1) % allMembers.length,
      (periodNumber * 3 + 2) % allMembers.length,
    ];
    final hosts = hostIndices.map((i) => allMembers[i]).toList();

    return HostingSchedule(
      id: 'schedule_$periodNumber',
      startDate: nextStartDate,
      endDate: nextEndDate,
      hosts: hosts,
      allMembers: allMembers,
    );
  }

  List<Member> _getAllMembers() {
    return const [
      Member(id: '1', name: 'John Doe', location: 'New York, NY', isPaid: true, role: 'President', service: 'Army'),
      Member(id: '2', name: 'Jane Smith', location: 'Los Angeles, CA', isPaid: true, role: 'Vice President', service: 'Navy'),
      Member(id: '3', name: 'Robert Johnson', location: 'Chicago, IL', isPaid: false, role: 'Secretary', service: 'Air Force'),
      Member(id: '4', name: 'Mary Williams', location: 'Houston, TX', isPaid: true, role: 'Treasurer', service: 'Marines'),
      Member(id: '5', name: 'James Brown', location: 'Phoenix, AZ', isPaid: false, role: 'Member', service: 'Coast Guard'),
      Member(id: '6', name: 'Patricia Garcia', location: 'Philadelphia, PA', isPaid: true, role: 'Member', service: 'Army'),
      Member(id: '7', name: 'Michael Davis', location: 'San Antonio, TX', isPaid: false, role: 'Member', service: 'Navy'),
      Member(id: '8', name: 'Linda Martinez', location: 'San Diego, CA', isPaid: true, role: 'Member', service: 'Air Force'),
    ];
  }
}
