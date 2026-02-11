import 'package:flutter/material.dart';
import '../../models/official.dart';
import '../../models/news_item.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/official_card.dart';
import '../../widgets/news_card.dart';
import '../../widgets/section_header.dart';
import '../details/all_officials_screen.dart';
import '../details/all_news_screen.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  // Sample data - in a real app, this would come from a backend/state management
  static const int _totalMembers = 150; // Total organization members
  
  static const List<Official> _allOfficials = [
    Official(name: 'John Doe', role: 'President', service: 'Army'),
    Official(name: 'Jane Smith', role: 'Vice President', service: 'Navy'),
    Official(name: 'Robert Johnson', role: 'Secretary', service: 'Air Force'),
    Official(name: 'Mary Williams', role: 'Treasurer', service: 'Marines'),
    Official(name: 'James Brown', role: 'Member', service: 'Coast Guard'),
    Official(name: 'Patricia Davis', role: 'Member', service: 'Army'),
    Official(name: 'Michael Miller', role: 'Member', service: 'Navy'),
  ];

  static const List<NewsItem> _allNews = [
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
      body: SingleChildScrollView(
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
                    builder: (context) => const AllOfficialsScreen(
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
                    builder: (context) => const AllNewsScreen(
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
