import '../api/api_client.dart';
import '../api/meetings_api.dart';
import '../../models/meeting.dart';

class MeetingsRepository {
  final MeetingsApi _api;

  MeetingsRepository({MeetingsApi? api})
      : _api = api ?? MeetingsApi(ApiClient());

  /// Get all meetings
  Future<List<Meeting>> getMeetings() async {
    return await _api.getMeetings();
  }

  /// Get meeting by ID
  Future<Meeting> getMeetingById(String id) async {
    return await _api.getMeetingById(id);
  }
}
