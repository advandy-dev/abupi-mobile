import 'package:abupi/models/post.dart';

class PostDetailArguments {
  final Post post;
  final String Function(String) stripHtml;

  PostDetailArguments({
    required this.post,
    required this.stripHtml,
  });
}