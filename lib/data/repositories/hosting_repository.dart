import '../api/api_client.dart';
import '../api/hosting_api.dart';
import '../../models/hosting_schedule.dart';

class HostingRepository {
  final HostingApi _api;

  HostingRepository({HostingApi? api})
      : _api = api ?? HostingApi(ApiClient());

  /// Get current hosting schedule
  Future<HostingSchedule> getCurrentSchedule() async {
    return await _api.getCurrentSchedule();
  }

  /// Get next hosting schedule
  Future<HostingSchedule> getNextSchedule() async {
    return await _api.getNextSchedule();
  }
}
