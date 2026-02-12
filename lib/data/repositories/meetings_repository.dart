import '../api/api_client.dart';
import '../api/meetings_api.dart';
import '../../models/meeting.dart';

class MeetingsRepository {
  final MeetingsApi _api;

  MeetingsRepository({MeetingsApi? api})
      : _api = api ?? MeetingsApi(ApiClient());

  /// Get all meetings
  Future<List<Meeting>> getMeetings({String? organizationId}) async {
    return await _api.getMeetings(organizationId: organizationId);
  }

  /// Get meeting by ID
  Future<Meeting> getMeetingById(String id, {String? organizationId}) async {
    return await _api.getMeetingById(id, organizationId: organizationId);
  }
}
