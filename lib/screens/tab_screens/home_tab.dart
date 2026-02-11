import 'package:flutter/material.dart';
import '../../models/official.dart';
import '../../models/news_item.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/official_card.dart';
import '../../widgets/news_card.dart';
import '../../widgets/section_header.dart';
import '../details/all_officials_screen.dart';
import '../details/all_news_screen.dart';
import '../../data/repositories/officials_repository.dart';
import '../../data/repositories/news_repository.dart';

class HomeTab extends StatefulWidget {
  final OfficialsRepository? officialsRepository;
  final NewsRepository? newsRepository;

  const HomeTab({
    super.key,
    this.officialsRepository,
    this.newsRepository,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final OfficialsRepository _officialsRepository;
  late final NewsRepository _newsRepository;
  
  List<Official> _allOfficials = [];
  List<NewsItem> _allNews = [];
  bool _isLoading = true;
  String? _errorMessage;

  // Sample data - in a real app, this would come from a backend/state management
  static const int _totalMembers = 150; // Total organization members

  @override
  void initState() {
    super.initState();
    _officialsRepository = widget.officialsRepository ?? OfficialsRepository();
    _newsRepository = widget.newsRepository ?? NewsRepository();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final officials = await _officialsRepository.getOfficials();
      final news = await _newsRepository.getNews();

      setState(() {
        _allOfficials = officials;
        _allNews = news;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load data: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Take only the first 4 officials for the home screen
    final displayedOfficials = _allOfficials.take(4).toList();
    // Take only the first 3 news items for the home screen
    final displayedNews = _allNews.take(3).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_errorMessage!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadData,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      // Statistics Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: StatCard(
                                title: 'Total Members',
                                value: '$_totalMembers',
                                icon: Icons.people,
                                iconColor: Colors.blue,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: StatCard(
                                title: 'Account Balance',
                                value: '\$25,000',
                                icon: Icons.account_balance_wallet,
                                iconColor: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Officials Section
                      SectionHeader(
                        title: 'Officials',
                        onShowAllPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllOfficialsScreen(
                                officials: _allOfficials,
                              ),
                            ),
                          );
                        },
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: displayedOfficials.length,
                        itemBuilder: (context, index) {
                          return OfficialCard(
                            official: displayedOfficials[index],
                            onTap: () {
                              // Handle official details navigation
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      
                      // News Section
                      SectionHeader(
                        title: 'Latest News',
                        onShowAllPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllNewsScreen(
                                newsItems: _allNews,
                              ),
                            ),
                          );
                        },
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: displayedNews.length,
                        itemBuilder: (context, index) {
                          return NewsCard(
                            newsItem: displayedNews[index],
                            onTap: () {
                              // Handle news details navigation
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
    );
  }
}
