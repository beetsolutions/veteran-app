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

  /// Parse the date string to DateTime for sorting purposes
  /// Expected format: "MMM dd, yyyy" (e.g., "Nov 11, 2024")
  DateTime? get parsedDate {
    try {
      // Parse date strings like "Nov 11, 2024"
      final months = {
        'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4,
        'May': 5, 'Jun': 6, 'Jul': 7, 'Aug': 8,
        'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12,
      };
      
      final parts = date.split(' ');
      if (parts.length != 3) return null;
      
      final month = months[parts[0]];
      final day = int.tryParse(parts[1].replaceAll(',', ''));
      final year = int.tryParse(parts[2]);
      
      if (month != null && day != null && year != null) {
        return DateTime(year, month, day);
      }
    } catch (e) {
      // If parsing fails, return null
    }
    return null;
  }
}
