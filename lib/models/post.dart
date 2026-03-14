/// Model class representing a WordPress post
class Post {
  final int id;
  final String title;
  final String content;
  final String excerpt;
  final String date;
  final String? featuredImageUrl;
  final String link;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.date,
    this.featuredImageUrl,
    required this.link,
  });

  /// Factory constructor to create a Post from WordPress REST API JSON
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? 0,
      title: _parseRenderedContent(json['title']),
      content: _parseRenderedContent(json['content']),
      excerpt: _parseRenderedContent(json['excerpt']),
      date: json['date'] ?? '',
      featuredImageUrl: json['_embedded']?['wp:featuredmedia']?[0]?['source_url'],
      link: json['link'] ?? '',
    );
  }

  /// Helper to parse WordPress rendered content (removes HTML wrapper)
  static String _parseRenderedContent(dynamic field) {
    if (field == null) return '';
    if (field is String) return field;
    if (field is Map && field['rendered'] != null) {
      return field['rendered'].toString();
    }
    return '';
  }

  /// Get formatted date string
  String get formattedDate {
    try {
      final dateTime = DateTime.parse(date);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (e) {
      return date;
    }
  }
}

