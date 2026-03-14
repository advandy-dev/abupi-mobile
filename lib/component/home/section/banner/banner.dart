import 'dart:convert';
import 'dart:core';

import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

class Banner extends StatefulWidget {
  const Banner({super.key});

  @override
  State<Banner> createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  bool _isLoading = true;
  List<String> _imgList = [];
  String? _currentLanguage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context);
    final newLanguage = l10n?.locale.languageCode ?? 'id';

    if (_currentLanguage != newLanguage) {
      _currentLanguage = newLanguage;
      _loadBanner();
    }
  }

  String _getSlugForLanguage(String language) {
    return language == 'en' ? 'home' : 'beranda';
  }

  Future<void> _loadBanner() async {
    if (_currentLanguage == null) return;

    setState(() {
      _isLoading = true;
    });
    final slug = _getSlugForLanguage(_currentLanguage!);

    try {
      final response = await WordPressApi.getPages(slug);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isNotEmpty) {
          final data = jsonList.first as Map<String, dynamic>;

          setState(() {
            _isLoading = false;
            _imgList = List<String>.from(data['acf'].values);
          });
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (_isLoading) {
      return SizedBox(
        width: double.infinity,
        height: 200.0,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: double.infinity,
            height: 200.0,
            color: Colors.grey,
          ),
        ),
      );
    }

    return CarouselSlider(
      // basic
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1.0,
        padEnds: false,
      ),
      items: _imgList.map((item) => Center(
        child: Image.network(
          item,
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) => Container(
            color: colorScheme.surfaceContainerHighest,
          ),
        ),
      )).toList(),
    );
  }
}

