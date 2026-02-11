import '../api/api_client.dart';
import '../api/news_api.dart';
import '../../models/news_item.dart';

class NewsRepository {
  final NewsApi _api;

  NewsRepository({NewsApi? api})
      : _api = api ?? NewsApi(ApiClient());

  /// Get all news items
  Future<List<NewsItem>> getNews() async {
    return await _api.getNews();
  }
}
