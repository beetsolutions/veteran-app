import 'package:flutter/material.dart';
import '../models/news_item.dart';
import '../utils/responsive_utils.dart';

class NewsCard extends StatelessWidget {
  final NewsItem newsItem;
  final VoidCallback? onTap;

  const NewsCard({
    super.key,
    required this.newsItem,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final margin = ResponsiveUtils.getMargin(
      context,
      mobile: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tablet: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      desktop: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
    );
    final padding = ResponsiveUtils.getPadding(
      context,
      mobile: 16.0,
      tablet: 20.0,
      desktop: 24.0,
    );
    final categoryFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 12.0,
      tablet: 13.0,
      desktop: 14.0,
    );
    final dateFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 12.0,
      tablet: 13.0,
      desktop: 14.0,
    );
    final titleFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 18.0,
      tablet: 20.0,
      desktop: 22.0,
    );
    final descriptionFontSize = ResponsiveUtils.getFontSize(
      context,
      mobile: 14.0,
      tablet: 15.0,
      desktop: 16.0,
    );
    final spacing = ResponsiveUtils.getSpacing(
      context,
      mobile: 8.0,
      tablet: 10.0,
      desktop: 12.0,
    );

    return Card(
      elevation: 2,
      margin: margin,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spacing, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      newsItem.category,
                      style: TextStyle(
                        fontSize: categoryFontSize,
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    newsItem.date,
                    style: TextStyle(
                      fontSize: dateFontSize,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacing + 4),
              Text(
                newsItem.title,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spacing),
              Text(
                newsItem.description,
                style: TextStyle(
                  fontSize: descriptionFontSize,
                  color: Colors.grey,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
