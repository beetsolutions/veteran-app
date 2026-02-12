import '../api/api_client.dart';
import '../api/hosting_api.dart';
import '../../models/hosting_schedule.dart';
import '../../models/member.dart';

class HostingRepository {
  final HostingApi _api;

  HostingRepository({HostingApi? api})
      : _api = api ?? HostingApi(ApiClient());

  /// Get current hosting schedule
  Future<HostingSchedule> getCurrentSchedule({String? organizationId}) async {
    return await _api.getCurrentSchedule(organizationId: organizationId);
  }

  /// Get next hosting schedule
  Future<HostingSchedule> getNextSchedule({String? organizationId}) async {
    return await _api.getNextSchedule(organizationId: organizationId);
  }

  /// Mark payment for hosting
  /// Only allowed for members who are in the hosting list
  Future<Member> markPayment({
    required String memberId,
    required String scheduleId,
    required bool isPaid,
  }) async {
    return await _api.markPayment(
      memberId: memberId,
      scheduleId: scheduleId,
      isPaid: isPaid,
    );
  }
}
