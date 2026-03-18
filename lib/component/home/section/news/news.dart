import 'dart:convert';

import 'package:abupi/component/home/section/news/news_card.dart';
import 'package:abupi/util/launch_url.dart';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/models/news.dart';
import 'package:flutter/material.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:abupi/main.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsSection extends StatefulWidget {
  const NewsSection({super.key});

  @override
  State<NewsSection> createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  List<News> _newsList = [];
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();
  bool _canScrollLeft = false;
  bool _canScrollRight = true;

  @override
  void initState() {
    super.initState();
    _loadData();
    _scrollController.addListener(_updateScrollButtons);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollButtons);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateScrollButtons() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    final canLeft = currentScroll > 0;
    final canRight = currentScroll < maxScroll - 1; // small threshold to handle floating point

    if (mounted && (_canScrollLeft != canLeft || _canScrollRight != canRight)) {
      setState(() {
        _canScrollLeft = canLeft;
        _canScrollRight = canRight;
      });
    }
  }

  Future<void> _loadData() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await WordPressApi.getNews(1, 3, null);
      if (!mounted) return;
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isNotEmpty) {
          final news = await Future.wait(jsonList.map((item) async {
            final acf = item['acf'] as Map<String, dynamic>? ?? {};
            final metadata = await WordPressApi.getMetadataFromUrl(acf['link']);

            return News(
              title: metadata['og:title'] ?? acf['title'],
              description: metadata['og:description'] ?? acf['description'],
              imageURL: metadata['og:image'] ?? acf['featured_image'],
              link: acf['link'],
            );
          }));

          if (!mounted) return;
          setState(() {
            _newsList = news;
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      debugPrint('error news $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 300,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 300,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _viewAllNews() {
    Navigator.pushNamed(context, AbupiApp.newsRoute);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        width: double.infinity,
        height: 150.0,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            width: double.infinity,
            height: 150.0,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 12),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              l10n?.news ?? 'Berita',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: _viewAllNews,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n?.seeAll ?? 'Lihat Semua',
                style: const TextStyle(
                  color: Color(0xFF2e2f7f),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: Color(0xFF2e2f7f),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (_newsList.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text(l10n?.emptyEvent ?? 'Tidak ada acara'),
        ),
      );
    }

    return SizedBox(
      height: 280,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Card list
          ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: _newsList.length,
            itemBuilder: (context, index) {
              final news = _newsList[index];
              return NewsCard(
                news: news,
                onTap: () => launchWebsite(news.link),
              );
            },
          ),
          // Left navigation button
          if (_canScrollLeft)
            Positioned(
              left: -8,
              bottom: 100,
              child: IconButton(
                onPressed: _scrollLeft,
                icon: const Icon(
                  Icons.chevron_left_rounded,
                  color: Colors.black,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                ),
                iconSize: 24,
                constraints: const BoxConstraints(
                  minWidth: 36,
                  minHeight: 36,
                ),
                padding: EdgeInsets.zero,
              ),
            ),
          // Right navigation button
          if (_canScrollRight)
            Positioned(
              right: 0,
              bottom: 100,
              child: IconButton(
                onPressed: _scrollRight,
                icon: const Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.black,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                ),
                iconSize: 24,
                constraints: const BoxConstraints(
                  minWidth: 36,
                  minHeight: 36,
                ),
                padding: EdgeInsets.zero,
              ),
            ),
        ],
      ),
    );
  }
}
