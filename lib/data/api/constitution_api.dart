import 'api_client.dart';
import '../../models/constitution.dart';

class ConstitutionApi {
  final ApiClient _client;

  ConstitutionApi(this._client);

  /// Get constitution for a specific organization
  Future<Constitution> getConstitution(String organizationId) async {
    try {
      final data = await _client.get('/constitution?organizationId=$organizationId');
      return Constitution.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      // For now, return mock data if API fails (development mode)
      return _getMockConstitution(organizationId);
    }
  }

  /// Mock data for development
  Constitution _getMockConstitution(String organizationId) {
    return Constitution(
      organizationId: organizationId,
      organizationName: 'Veterans Organization',
      articles: const [
        ConstitutionArticle(
          title: 'Article I: Name and Purpose',
          sections: [
            'Section 1: The name of this organization shall be the Veterans Organization.',
            'Section 2: The purpose of this organization is to support and advocate for veterans and their families, to promote camaraderie among veterans, to provide assistance and resources to those in need, and to preserve the memory and legacy of those who have served.',
            'Section 3: This organization shall be non-partisan and non-sectarian in nature.',
          ],
        ),
        ConstitutionArticle(
          title: 'Article II: Membership',
          sections: [
            'Section 1: Membership is open to all veterans who have served honorably in the armed forces of the United States.',
            'Section 2: Associate membership may be granted to family members of veterans and others who support the organization\'s mission.',
            'Section 3: All members in good standing shall have the right to vote on organizational matters.',
            'Section 4: Members who fail to pay dues or violate the code of conduct may have their membership suspended or revoked by a two-thirds vote of the Executive Board.',
          ],
        ),
      ],
      adoptedDate: 'January 15, 2020',
      lastAmended: 'March 10, 2024',
    );
  }
}
