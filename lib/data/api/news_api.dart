import 'api_client.dart';
import '../../models/news_item.dart';

class NewsApi {
  final ApiClient _client;

  NewsApi(this._client);

  /// Get all news items
  Future<List<NewsItem>> getNews({String? organizationId}) async {
    try {
      final endpoint = organizationId != null
          ? '/news?organizationId=$organizationId'
          : '/news';
      final data = await _client.get(endpoint);
      return (data as List<dynamic>)
          .map((json) => NewsItem.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // For now, return mock data if API fails (development mode)
      return _getMockNews();
    }
  }

  /// Mock data for development
  List<NewsItem> _getMockNews() {
    return const [
      NewsItem(
        title: 'Annual Veterans Day Ceremony',
        description: 'Join us for our annual Veterans Day ceremony honoring all who have served. The event will feature guest speakers, a memorial service, and community gathering.',
        date: 'Nov 11, 2024',
        category: 'Events',
      ),
      NewsItem(
        title: 'New Healthcare Benefits Available',
        description: 'We are pleased to announce new healthcare benefits for all members. Visit our office to learn more about the expanded coverage options.',
        date: 'Nov 5, 2024',
        category: 'Benefits',
      ),
      NewsItem(
        title: 'Community Outreach Program Success',
        description: 'Our recent community outreach program was a great success! Over 200 veterans received assistance with job placement and career counseling.',
        date: 'Oct 28, 2024',
        category: 'News',
      ),
      NewsItem(
        title: 'Monthly Member Meeting Scheduled',
        description: 'Our monthly member meeting is scheduled for the first Friday of next month. All members are encouraged to attend and participate.',
        date: 'Oct 15, 2024',
        category: 'Events',
      ),
      NewsItem(
        title: 'Scholarship Opportunities',
        description: 'Multiple scholarship opportunities are now available for veterans and their families. Applications are being accepted through the end of the year.',
        date: 'Oct 10, 2024',
        category: 'Education',
      ),
    ];
  }
}
