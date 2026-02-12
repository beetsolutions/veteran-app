/// Model representing an organization's constitution
class Constitution {
  final String organizationId;
  final String organizationName;
  final List<ConstitutionArticle> articles;
  final String adoptedDate;
  final String lastAmended;

  const Constitution({
    required this.organizationId,
    required this.organizationName,
    required this.articles,
    required this.adoptedDate,
    required this.lastAmended,
  });

  factory Constitution.fromJson(Map<String, dynamic> json) {
    return Constitution(
      organizationId: json['organizationId'] as String,
      organizationName: json['organizationName'] as String,
      articles: (json['articles'] as List<dynamic>)
          .map((article) => ConstitutionArticle.fromJson(article as Map<String, dynamic>))
          .toList(),
      adoptedDate: json['adoptedDate'] as String,
      lastAmended: json['lastAmended'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'organizationId': organizationId,
      'organizationName': organizationName,
      'articles': articles.map((article) => article.toJson()).toList(),
      'adoptedDate': adoptedDate,
      'lastAmended': lastAmended,
    };
  }
}

/// Model representing a single article in a constitution
class ConstitutionArticle {
  final String title;
  final List<String> sections;

  const ConstitutionArticle({
    required this.title,
    required this.sections,
  });

  factory ConstitutionArticle.fromJson(Map<String, dynamic> json) {
    return ConstitutionArticle(
      title: json['title'] as String,
      sections: List<String>.from(json['sections'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'sections': sections,
    };
  }
}
