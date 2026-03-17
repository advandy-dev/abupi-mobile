import 'dart:convert';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/main.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsSection extends StatefulWidget {
  const AboutUsSection({super.key});

  @override
  State<AboutUsSection> createState() => _AboutUsSectionState();
}

class _AboutUsSectionState extends State<AboutUsSection> {
  String? _errorMessage;
  Map<String, dynamic>? _pageData;
  String? _currentLanguage;
  String _videoThumbnailURL = '';
  String _youtubeURL = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context);
    final newLanguage = l10n?.locale.languageCode ?? 'id';

    if (_currentLanguage != newLanguage && mounted) {
      _currentLanguage = newLanguage;
      setState(() {
        _pageData = null;
        _errorMessage = null;
      });
      _loadData();
    }
  }

  String _getSlugForLanguage(String language) {
    return language == 'en' ? 'about-us' : 'tentang-kami';
  }

  String? extractVideoId(String videoUrl) {
    try {
      Uri uri = Uri.parse(videoUrl);

      // 1. Handle youtu.be/VIDEO_ID
      if (uri.host == 'youtu.be') {
        return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
      }

      // 2. Handle youtube.com variants
      if (uri.host.contains('youtube.com')) {
        // Standard: youtube.com/watch?v=VIDEO_ID
        if (uri.queryParameters.containsKey('v')) {
          return uri.queryParameters['v'];
        }
        // Embeds: youtube.com/embed/VIDEO_ID
        // Shorts: youtube.com/shorts/VIDEO_ID
        // Older: youtube.com/v/VIDEO_ID
        if (uri.pathSegments.isNotEmpty) {
          if (uri.pathSegments.contains('embed') ||
              uri.pathSegments.contains('shorts') ||
              uri.pathSegments.contains('v')) {
            return uri.pathSegments.last;
          }
        }
      }
    } catch (e) {
      debugPrint('Invalid URL: $e');
    }
    return null;
  }

  Future<void> _loadData() async {
    if (_currentLanguage == null) return;

    if (mounted) {
      setState(() {
        _errorMessage = null;
      });
    }

    final slug = _getSlugForLanguage(_currentLanguage!);

    try {
      final response = await WordPressApi.getPages(slug);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isNotEmpty) {
          final data = jsonList.first as Map<String, dynamic>;
          final videoUrl = data['acf']?['about_video'] as String?;

          String videoId = '';
          if (videoUrl != null && videoUrl.isNotEmpty) {
            videoId = extractVideoId(videoUrl) ?? '';
          }

          if (mounted) {
            setState(() {
              _pageData = data;
              _videoThumbnailURL =
              'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
              _youtubeURL = videoUrl ?? '';
            });
          }
        } else {
          if (mounted) {
            setState(() {
              _errorMessage = 'Page not found';
            });
          }
        }
      } else {
        if (mounted) {
          setState(() {
            _errorMessage = 'Failed to load: ${response.statusCode}';
          });
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Error: $e';
        });
      }
    }
  }

  Future<void> _openYouTube() async {
    final uri = Uri.parse(_youtubeURL);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (_errorMessage != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        alignment: Alignment.center,
        child: Text(
          _errorMessage!,
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      );
    }

    // Show loading until we have data for the current language
    if (_pageData == null) {
      return const SizedBox(
        height: 120,
        child: Center(
          child: CircularProgressIndicator(color: Color(0xFF632f9c)),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                color: const Color(0xFFF2C21A),
                width: 4,
                height: 40,
              ),
              const SizedBox(width: 8),
              Text(
                _pageData?['acf']?['about_title'] ?? '',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _pageData?['acf']?['about_description_home'] ?? '',
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.bottomLeft,
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color(0xFF2e2f7f)),
              ),
              onPressed: () => Navigator.pushNamed(context, AbupiApp.aboutUsRoute),
              child: Text(
                  l10n?.readMore ?? '',
                  style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _openYouTube,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12), // Optional: rounded corners
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // 1. The Thumbnail Image
                    Image.network(
                      _videoThumbnailURL,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      // Placeholder while loading
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(color: Colors.grey[300]);
                      },
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const Text('Image failed to load');
                      },
                    ),
                    // 2. A semi-transparent overlay to make the icon pop
                    Container(color: Colors.black26),
                    // 3. The Play Icon
                    const Icon(
                      Icons.play_circle_fill,
                      color: Colors.red,
                      size: 64,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}