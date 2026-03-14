import 'dart:convert';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/main.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AboutUsSection extends StatefulWidget {
  const AboutUsSection({super.key});

  @override
  State<AboutUsSection> createState() => _AboutUsSectionState();
}

class _AboutUsSectionState extends State<AboutUsSection> {
  String? _errorMessage;
  Map<String, dynamic>? _pageData;
  String? _currentLanguage;
  String _videoId = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context);
    final newLanguage = l10n?.locale.languageCode ?? 'id';

    if (_currentLanguage != newLanguage) {
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

  Future<void> _loadData() async {
    if (_currentLanguage == null) return;

    setState(() {
      _errorMessage = null;
    });

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
            // _initializeVideoPlayer(videoUrl);
            try {
              Uri uri = Uri.parse(videoUrl);
              if (uri.host == 'www.youtube.com' || uri.host == 'youtube.com') {
                // For standard URLs like https://www.youtube.com
                videoId = uri.queryParameters['v'] ?? '';
              } else if (uri.host == 'youtu.be') {
                // For shortened URLs like https://youtu.be/dQw4w9WgXcQ
                videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : '';
              }
            } catch (e) {
              // Handle invalid URLs
            }
          }
          
          setState(() {
            _pageData = data;
            _videoId = videoId;
          });
        } else {
          setState(() {
            _errorMessage = 'Page not found';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Failed to load: ${response.statusCode}';
        });
      }
    } catch (e) {
      debugPrint('Error: $e');
      setState(() {
        _errorMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    if (_errorMessage != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        alignment: Alignment.center,
        child: Text(
          _errorMessage!,
          style: TextStyle(color: colorScheme.error),
          textAlign: TextAlign.center,
        ),
      );
    }

    // Show loading until we have data for the current language
    if (_pageData == null) {
      return SizedBox(
        height: 120,
        child: Center(
          child: CircularProgressIndicator(color: colorScheme.primary),
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
          Text(_pageData?['acf']?['about_description_home'] ?? ''),
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
          AspectRatio(
            aspectRatio: 16 / 9,
            child: InAppWebView(
              initialSettings: InAppWebViewSettings(
                mediaPlaybackRequiresUserGesture: false,
                allowsInlineMediaPlayback: true,
                javaScriptEnabled: true,
              ),
    // src="https://www.youtube.com/embed/$_videoURL?playsinline=1&rel=0&modestbranding=1&enablejsapi=1"
              initialData: InAppWebViewInitialData(
                data: """
                <html>
                <body style="margin:0">
                  <iframe
                    width="100%"
                    height="100%"
                    src="https://www.youtube-nocookie.com/embed/M7lc1UVf-VE?playsinline=1&rel=0&modestbranding=1&enablejsapi=1"
                    title="YouTube video player"
                    frameborder="0"
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                    allowfullscreen>
                  </iframe>
                </body>
                </html>
                """,
              ),
            ),
          ),
        ],
      ),
    );
  }
}