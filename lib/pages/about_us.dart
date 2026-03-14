import 'dart:convert';

import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  Map<String, dynamic>? _pageData;
  String? _currentLanguage;
  String _videoId = '';

  static const _primaryColor = Color.fromRGBO(145, 179, 236, 1.0);
  static const _textColor = Color(0xFF333333);
  static const _textStyle = TextStyle(fontSize: 14, color: _textColor);

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
        }
      } else {
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•', style: _textStyle),
          const SizedBox(width: 4),
          Expanded(child: Text(text, style: _textStyle)),
        ],
      ),
    );
  }

  Widget _buildExpandableCapsule({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ExpansionTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: _primaryColor),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: _textColor,
            ),
          ),
          iconColor: _primaryColor,
          collapsedIconColor: Colors.grey,
          shape: const Border(),
          collapsedShape: const Border(),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: children,
        ),
      ),
    );
  }

  Widget _buildTextSection(List<String> paragraphs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs
          .map((p) => Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(p, style: _textStyle),
              ))
          .toList(),
    );
  }

  Widget _buildBulletSection(List<String> items) {
    return Column(children: items.map(_buildBulletPoint).toList());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
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
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Text(_pageData?['acf']?['about_description'] ?? ''),
                  const SizedBox(height: 4),
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
            ),
            const SizedBox(height: 12),

            _buildExpandableCapsule(
              title: l10n?.basisFoundationABUPI ?? 'Dasar Pendirian',
              icon: Icons.foundation,
              children: [
                _buildTextSection([
                  l10n?.basisFoundationDescriptionABUPI ?? 'Dasar pendirian ABUPI adalah untuk mendukung program reformasi pelabuhan seperti yang diamanatkan pada Undang-undang No. 17 Tahun 2008 tentang Pelayaran dan Peraturan Pemerintah No. 61 Tahun 2009 tentang Kepelabuhanan.',
                ]),
              ],
            ),
            const SizedBox(height: 12),
            _buildExpandableCapsule(
              title: l10n?.deedEstablishmentABUPI ?? 'Akta Pendirian ABUPI',
              icon: Icons.assignment,
              children: [
                _buildTextSection([
                  l10n?.deedEstablishmentDescriptionABUPI ?? 'ABUPI didirikan dengan akte pendirian No. 010 tanggal 16 Februari 2015 di hadapan Notaris Elly Rustam SH dan dikukuhkan dengan pengesahan dari Kementrian Hukum dan Hak Asasi Manusia Republik Indonesia No. AHU-001650.AH.01, Tahun 2015.',
                ]),
              ],
            ),
            const SizedBox(height: 12),
            _buildExpandableCapsule(
              title: l10n?.vision ?? 'Visi',
              icon: Icons.visibility,
              children: [
                _buildTextSection([
                  l10n?.visionDescription ?? 'Sebagai badan usaha yang mengedepankan kerjasama antara Badan Usaha Pelabuhan (BUP), Terminal Untuk Kepentingan Sendiri (TUKS) dan Terminal Khusus (TerSus) dalam mendukung pembangunan sektor maritim di Indonesia.',
                ]),
              ],
            ),
            const SizedBox(height: 12),
            _buildExpandableCapsule(
              title: l10n?.mission ?? 'Misi',
              icon: Icons.flag,
              children: [
                _buildBulletSection([
                  l10n?.missionDescription1 ?? 'Menghimpun, membina dan mengembangkan usaha para anggotanya untuk dapat lebih berperan serta di dalam meningkatkan pembangunan perekonomian nasional.',
                  l10n?.missionDescription2 ?? 'Melindungi kepentingan kegiatan Jasa Kepelabuhanan dengan menjunjung tinggi etika dan professionalisme para anggota dalam mengantisipasi perkembangan yang terjadi, baik secara Nasional maupun Internasional.',
                  l10n?.missionDescription3 ?? 'Melindungi kepentingan anggota dan mencegah timbulnya persaingan usaha yang tidak sehat dalam dunia usaha Jasa Kepelabuhanan.',
                  l10n?.missionDescription4 ?? 'Meningkatkan kemampuan serta pengetahuan sember daya manusia (SDM) para anggota di bidang Jasa Kepelabuhanan sejalan dengan kemajuan teknologi di berbagai bidang.',
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}