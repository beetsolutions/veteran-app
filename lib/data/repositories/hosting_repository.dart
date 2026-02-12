import '../api/api_client.dart';
import '../api/hosting_api.dart';
import '../../models/hosting_schedule.dart';

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
}
