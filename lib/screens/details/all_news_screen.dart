import 'package:flutter/material.dart';
import '../../models/news_item.dart';
import '../../widgets/news_card.dart';

class AllNewsScreen extends StatelessWidget {
  final List<NewsItem> newsItems;

  const AllNewsScreen({
    super.key,
    required this.newsItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All News'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: newsItems.length,
        itemBuilder: (context, index) {
          return NewsCard(
            newsItem: newsItems[index],
            onTap: () {
              // Handle news details navigation
            },
          );
        },
      ),
    );
  }
}
