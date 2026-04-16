import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'dart:io';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/io_client.dart';

/// Service class for WordPress REST API calls
class WordPressApi {
  // Using WordPress.org as the test API endpoint
  // You can change this to any WordPress site's REST API
  static const String baseUrl = 'https://floralwhite-mallard-731111.hostingersite.com/wp-json';

  /// Create an HTTP client that bypasses certificate verification (DEV ONLY)
  static http.Client _createHttpClient() {
    final httpClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return IOClient(httpClient);
  }

  /// Fetch posts from WordPress
  /// [slug] - slug of the pages
  static Future<Response> getPages(String slug) async {
    final client = _createHttpClient();
    try {
      final uri = Uri.parse('$baseUrl/wp/v2/pages').replace(
        queryParameters: {
          'slug': slug,
        },
      );

      final response = await client.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      );

      return response;
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    } finally {
      client.close();
    }
  }

  static Future<Response> getEvents(int page, int perPage, String? search, int? category) async {
    final client = _createHttpClient();
    try {
      String searchParam = '';
      if (search != null) {
        searchParam = '&search=$search';
      }
      String categoryParam = '';
      if (category != null) {
        categoryParam = '&event_category=$category';
      }
      final uri = Uri.parse('$baseUrl/wp/v2/events?page=$page&per_page=$perPage$categoryParam$searchParam');
      final response = await client.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      );

      return response;
    } catch (e) {
      throw Exception('Error fetching events: $e');
    } finally {
      client.close();
    }
  }

  static Future<Response> getEventCategory() async {
    final client = _createHttpClient();
    try {
      final uri = Uri.parse('$baseUrl/wp/v2/event_category');
      final response = await client.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      );

      return response;
    } catch (e) {
      throw Exception('Error fetching events: $e');
    } finally {
      client.close();
    }
  }

  static Future<Response> getNews(int page, int perPage, String? search) async {
    final client = _createHttpClient();
    try {
      var searchParam = '';
      if (search != null) {
        searchParam = '&search=$search';
      }
      final uri = Uri.parse('$baseUrl/wp/v2/news?page=$page&per_page=$perPage$searchParam');
      final response = await client.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      );

      return response;
    } catch (e) {
      throw Exception('Error fetching events: $e');
    } finally {
      client.close();
    }
  }

  static Future<Map<String, String>> getMetadataFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Document document = parse(response.body);
        final Map<String, String> metadata = {};

        // Extract standard meta tags
        final metaTags = document.querySelectorAll('meta');
        for (var tag in metaTags) {
          final String name = tag.attributes['name'] ?? tag.attributes['property'] ?? '';
          final String content = tag.attributes['content'] ?? '';
          if (name.isNotEmpty && content.isNotEmpty) {
            metadata[name] = content;
          }
        }

        // Extract title and potentially Open Graph specific tags
        final titleTag = document.querySelector('title');
        if (titleTag != null) {
          metadata['title'] = titleTag.text;
        }

        // Specifically target Open Graph (og:) properties for better link previews
        final ogTitle = document.querySelector('meta[property="og:title"]')?.attributes['content'];
        if (ogTitle != null) metadata['og:title'] = ogTitle;

        final ogDescription = document.querySelector('meta[property="og:description"]')?.attributes['content'];
        if (ogDescription != null) metadata['og:description'] = ogDescription;

        final ogImage = document.querySelector('meta[property="og:image"]')?.attributes['content'];
        if (ogImage != null) metadata['og:image'] = ogImage;

        return metadata;

      } else {
        print('Failed to load URL: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Error fetching metadata: $e');
      return {};
    }
  }

  static Future<Response> getStakeholderCategory(String language) async {
    final client = _createHttpClient();
    try {
      final uri = Uri.parse('$baseUrl/wp/v2/stakeholder_category?lang=$language');
      final response = await client.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      );

      return response;
    } catch (e) {
      throw Exception('Error fetching events: $e');
    } finally {
      client.close();
    }
  }

  static Future<Response> getStakeholder(List<int> categories, int? page) async {
    final client = _createHttpClient();
    try {
      String categoryParam = '';
      for (var category in categories) {
        categoryParam += '$category,';
      }
      String pageParam = '';
      if (page != null) {
        pageParam = '&per_page=5&page=$page';
      }
      final uri = Uri.parse('$baseUrl/wp/v2/stakeholder?stakeholder_category=$categoryParam$pageParam');
      final response = await client.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      );

      return response;
    } catch (e) {
      throw Exception('Error fetching events: $e');
    } finally {
      client.close();
    }
  }

  static Future<Response> getNewsletter(int? perPage) async {
    final client = _createHttpClient();
    try {
      String perPageParam = '';
      if (perPage != null) {
        perPageParam = '?per_page=$perPage';
      }
      final uri = Uri.parse('$baseUrl/wp/v2/newsletter$perPageParam');
      final response = await client.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      );

      return response;
    } catch (e) {
      throw Exception('Error fetching events: $e');
    } finally {
      client.close();
    }
  }

  static Future<Response> getGalleries() async {
    final client = _createHttpClient();
    try {
      final uri = Uri.parse('$baseUrl/wp/v2/galleries');
      final response = await client.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      );

      return response;
    } catch (e) {
      throw Exception('Error fetching events: $e');
    } finally {
      client.close();
    }
  }

  static Future<Response> getJournals(int page, String? search, int? category) async {
    final client = _createHttpClient();
    try {
      String searchParam = '';
      if (search != null) {
        searchParam = '&search=$search';
      }
      String categoryParam = '';
      if (category != null) {
        categoryParam = '&journal_category=$category';
      }
      debugPrint('$baseUrl/wp/v2/journal?per_page=10&page=$page$searchParam$categoryParam');
      final uri = Uri.parse('$baseUrl/wp/v2/journal?per_page=10&page=$page$searchParam$categoryParam');
      final response = await client.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      );

      return response;
    } catch (e) {
      throw Exception('Error fetching events: $e');
    } finally {
      client.close();
    }
  }

  static Future<Response> getJournalCategory() async {
    final client = _createHttpClient();
    try {
      final uri = Uri.parse('$baseUrl/wp/v2/journal_category');
      final response = await client.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      );

      return response;
    } catch (e) {
      throw Exception('Error fetching events: $e');
    } finally {
      client.close();
    }
  }

  static Future<Response> getPressRelease() async {
    final client = _createHttpClient();
    try {
      final uri = Uri.parse('$baseUrl/wp/v2/press_release');
      final response = await client.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      );

      return response;
    } catch (e) {
      throw Exception('Error fetching events: $e');
    } finally {
      client.close();
    }
  }

  static Future<Response> getMembers(int page) async {
    final client = _createHttpClient();
    try {
      final uri = Uri.parse('$baseUrl/wp/v2/member?per_page=15&page=$page');
      final response = await client.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      );

      return response;
    } catch (e) {
      throw Exception('Error fetching events: $e');
    } finally {
      client.close();
    }
  }
}

