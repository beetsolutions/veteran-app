import '../api/api_client.dart';
import '../api/members_api.dart';
import '../../models/member.dart';

class MembersRepository {
  final MembersApi _api;

  MembersRepository({MembersApi? api})
      : _api = api ?? MembersApi(ApiClient());

  /// Get all members
  Future<List<Member>> getMembers() async {
    return await _api.getMembers();
  }

  /// Get member by ID
  Future<Member> getMemberById(String id) async {
    return await _api.getMemberById(id);
  }
}
