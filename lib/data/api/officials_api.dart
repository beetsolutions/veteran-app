import 'api_client.dart';
import '../../models/official.dart';

class OfficialsApi {
  final ApiClient _client;

  OfficialsApi(this._client);

  /// Get all officials
  Future<List<Official>> getOfficials() async {
    try {
      final data = await _client.get('/officials');
      return (data as List<dynamic>)
          .map((json) => Official.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // For now, return mock data if API fails (development mode)
      return _getMockOfficials();
    }
  }

  /// Mock data for development
  List<Official> _getMockOfficials() {
    return const [
      Official(name: 'John Doe', role: 'President', service: 'Army'),
      Official(name: 'Jane Smith', role: 'Vice President', service: 'Navy'),
      Official(name: 'Robert Johnson', role: 'Secretary', service: 'Air Force'),
      Official(name: 'Mary Williams', role: 'Treasurer', service: 'Marines'),
      Official(name: 'James Brown', role: 'Member', service: 'Coast Guard'),
      Official(name: 'Patricia Davis', role: 'Member', service: 'Army'),
      Official(name: 'Michael Miller', role: 'Member', service: 'Navy'),
    ];
  }
}
