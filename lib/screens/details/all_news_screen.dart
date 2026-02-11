import 'package:flutter/material.dart';
import '../../models/news_item.dart';
import '../../widgets/news_card.dart';

enum DateSortOrder { ascending, descending }

class AllNewsScreen extends StatefulWidget {
  final List<NewsItem> newsItems;

  const AllNewsScreen({
    super.key,
    required this.newsItems,
  });

  @override
  State<AllNewsScreen> createState() => _AllNewsScreenState();
}

class _AllNewsScreenState extends State<AllNewsScreen> {
  DateSortOrder _sortOrder = DateSortOrder.descending;

  List<NewsItem> get _sortedNewsItems {
    final items = List<NewsItem>.from(widget.newsItems);
    
    items.sort((a, b) {
      final dateA = a.parsedDate;
      final dateB = b.parsedDate;
      
      // Handle null dates by placing them at the end
      if (dateA == null && dateB == null) return 0;
      if (dateA == null) return 1;
      if (dateB == null) return -1;
      
      // Sort based on selected order
      if (_sortOrder == DateSortOrder.ascending) {
        return dateA.compareTo(dateB);
      } else {
        return dateB.compareTo(dateA);
      }
    });
    
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final sortedItems = _sortedNewsItems;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('All News'),
        actions: [
          PopupMenuButton<DateSortOrder>(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort by date',
            onSelected: (DateSortOrder order) {
              setState(() {
                _sortOrder = order;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<DateSortOrder>>[
              PopupMenuItem<DateSortOrder>(
                value: DateSortOrder.descending,
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_downward,
                      size: 20,
                      color: _sortOrder == DateSortOrder.descending 
                          ? Theme.of(context).primaryColor 
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Newest First',
                      style: TextStyle(
                        fontWeight: _sortOrder == DateSortOrder.descending 
                            ? FontWeight.bold 
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<DateSortOrder>(
                value: DateSortOrder.ascending,
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      size: 20,
                      color: _sortOrder == DateSortOrder.ascending 
                          ? Theme.of(context).primaryColor 
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Oldest First',
                      style: TextStyle(
                        fontWeight: _sortOrder == DateSortOrder.ascending 
                            ? FontWeight.bold 
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: sortedItems.length,
        itemBuilder: (context, index) {
          return NewsCard(
            newsItem: sortedItems[index],
            onTap: () {
              // Handle news details navigation
            },
          );
        },
      ),
    );
  }
}
