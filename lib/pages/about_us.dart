import 'dart:convert';

import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:abupi/util/youtube_helper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  Map<String, dynamic>? _pageData;
  String? _currentLanguage;
  String _youtubeURL = '';
  String _videoThumbnailURL = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context);
    final newLanguage = l10n?.locale.languageCode ?? 'id';

    if (_currentLanguage != newLanguage) {
      _currentLanguage = newLanguage;
      _loadData();
    }
  }

  String _getSlugForLanguage(String language) {
    return language == 'en' ? 'about-us' : 'tentang-kami';
  }

  Future<void> _loadData() async {
    if (_currentLanguage == null) return;

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
          
          setState(() {
            _pageData = data;
            _youtubeURL = videoUrl ?? '';
            _videoThumbnailURL = 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
          });
        }
      } else {
      }
    } catch (e) {
      debugPrint('Error: $e');
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

    final missionDescriptions = [
      l10n?.missionDescription1 ?? '',
      l10n?.missionDescription2 ?? '',
      l10n?.missionDescription3 ?? '',
      l10n?.missionDescription4 ?? '',
      l10n?.missionDescription5 ?? '',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.aboutUs ?? 'Tentang Kami',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(height: 8),
                Text(
                  _pageData?['acf']?['about_description'] ?? '',
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 4),
                const SizedBox(height: 16),
                if (_youtubeURL.isNotEmpty) ...[GestureDetector(
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
                )],
              ],
            ),
            const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n?.ourVision ?? 'Visi Kami',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n?.visionDescription ?? '',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      l10n?.ourMission ?? 'Misi Kami',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    const SizedBox(height: 4),
                    ...missionDescriptions.map((description) =>
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFfcf9fa),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              color: Colors.deepPurple,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                description,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}