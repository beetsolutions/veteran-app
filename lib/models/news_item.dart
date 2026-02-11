class NewsItem {
  final String title;
  final String description;
  final String date;
  final String? imageUrl;
  final String category;

  const NewsItem({
    required this.title,
    required this.description,
    required this.date,
    this.imageUrl,
    required this.category,
  });
}
