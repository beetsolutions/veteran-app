import '../api/api_client.dart';
import '../api/soccer_api.dart';
import '../../models/soccer_match.dart';

class SoccerRepository {
  final SoccerApi _api;

  SoccerRepository({SoccerApi? api})
      : _api = api ?? SoccerApi(ApiClient());

  /// Get current soccer match
  Future<SoccerMatch> getCurrentMatch() async {
    return await _api.getCurrentMatch();
  }

  /// Get soccer match history
  Future<List<SoccerMatch>> getMatchHistory() async {
    return await _api.getMatchHistory();
  }
}
