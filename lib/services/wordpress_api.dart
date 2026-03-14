import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'dart:io';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:abupi/models/post.dart';

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
  /// [perPage] - Number of posts to fetch (default: 10)
  /// [page] - Page number for pagination (default: 1)
  static Future<List<Post>> getPosts({int perPage = 10, int page = 1}) async {
    final client = _createHttpClient();
    try {
      final uri = Uri.parse('$baseUrl/posts').replace(
        queryParameters: {
          'per_page': perPage.toString(),
          'page': page.toString(),
          '_embed': 'true', // Include featured images
        },
      );

      final response = await client.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    } finally {
      client.close();
    }
  }

  /// Fetch a single post by ID
  static Future<Post> getPost(int id) async {
    final client = _createHttpClient();
    try {
      final uri = Uri.parse('$baseUrl/posts/$id').replace(
        queryParameters: {
          '_embed': 'true',
        },
      );

      final response = await client.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return Post.fromJson(jsonData);
      } else {
        throw Exception('Failed to load post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching post: $e');
    } finally {
      client.close();
    }
  }

  /// Search posts by keyword
  static Future<List<Post>> searchPosts(String query, {int perPage = 10}) async {
    final client = _createHttpClient();
    try {
      final uri = Uri.parse('$baseUrl/posts').replace(
        queryParameters: {
          'search': query,
          'per_page': perPage.toString(),
          '_embed': 'true',
        },
      );

      final response = await client.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching posts: $e');
    } finally {
      client.close();
    }
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

  static Future<Response> getEvents(int page, int perPage, String? search) async {
    final client = _createHttpClient();
    try {
      var searchParam = '';
      if (search != null) {
        searchParam = '&search=$search';
      }
      final uri = Uri.parse('$baseUrl/wp/v2/events?page=$page&per_page=$perPage$searchParam');
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
}

