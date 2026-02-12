import '../api/api_client.dart';
import '../api/constitution_api.dart';
import '../../models/constitution.dart';

class ConstitutionRepository {
  final ConstitutionApi _api;

  ConstitutionRepository({ConstitutionApi? api})
      : _api = api ?? ConstitutionApi(ApiClient());

  /// Get constitution for a specific organization
  Future<Constitution> getConstitution(String organizationId) async {
    return await _api.getConstitution(organizationId);
  }
}
