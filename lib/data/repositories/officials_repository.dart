import '../api/api_client.dart';
import '../api/officials_api.dart';
import '../../models/official.dart';

class OfficialsRepository {
  final OfficialsApi _api;

  OfficialsRepository({OfficialsApi? api})
      : _api = api ?? OfficialsApi(ApiClient());

  /// Get all officials
  Future<List<Official>> getOfficials() async {
    return await _api.getOfficials();
  }
}
