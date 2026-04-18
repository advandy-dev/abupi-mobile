import 'dart:async';
import 'dart:convert';

import 'package:abupi/component/home/section/news/news_card.dart';
import 'package:abupi/models/news_category.dart';
import 'package:abupi/util/launch_url.dart';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/models/news.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

const maxPerPage = 12;

class _NewsListScreenState extends State<NewsListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounceTimer;
  static const _debounceDuration = Duration(milliseconds: 400);
  int _page = 1;
  bool _isLastPage = false;
  String _keyword = '';

  List<News> _newsList = [];
  List<NewsCategory> _newsCategories = [];
  int _selectedCategory = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This code runs AFTER the widget is rendered
      _loadData(context, _keyword, true, null);
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Trigger when the user is 200 pixels from the bottom
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoading) {
        _loadData(context, _keyword, false, _selectedCategory);
      }
    }
  }

  Future<void> _loadData(
    BuildContext context,
    String keyword,
    bool shouldFetchCategory,
    int? selectedCategory,
  ) async {
    if (_isLastPage) {
      return;
    }

    try {
      final l10n = AppLocalizations.of(context);
      final language = l10n?.locale.languageCode ?? 'id';

      setState(() {
        _isLoading = true;
      });
      List<dynamic> response = await Future.wait([
        WordPressApi.getNews(_page, maxPerPage, keyword, selectedCategory),
        shouldFetchCategory ? WordPressApi.getNewsCategory() : Future.value(null),
      ]);

      if (response[0].statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response[0].body);
        if (jsonList.isNotEmpty) {
          try {
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

            setState(() {
              _newsList = _newsList + news;
              _isLoading = shouldFetchCategory;
              _isLastPage = news.length < maxPerPage;
              _page = news.length < maxPerPage ? _page : (_page + 1);
            });
          } catch (e) {
            debugPrint('error news list $e');
            setState(() {
              _isLoading = false;
            });
          }
        } else {
          setState(() {
            _isLastPage = true;
            _isLoading = false;
          });
        }
      } else {
        _isLastPage = true;
        _isLoading = false;
      }

      if (response[1]?.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response[1]?.body);
        if (jsonList.isNotEmpty) {
          try {
            var categories = jsonList.map((item) {
              return NewsCategory(
                id: item['id'],
                name: item['name'],
              );
            }).toList();
            setState(() {
              _newsCategories = [NewsCategory(
                id: 0,
                name: language == 'id' ? 'Semua' : 'All',
              )] + categories;
              _selectedCategory = 0;
              _isLoading = false;
            });
          } catch (e) {
            debugPrint('error event list $e');
            setState(() {
              _isLoading = false;
            });
          }
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      _page = 1;
      _newsList = [];
      _isLastPage = false;
      _selectedCategory = 0;
    });
    _loadData(context, _keyword, true, _selectedCategory);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.news ?? 'Berita',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () => _onRefresh(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Sticky search bar
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            color: Colors.white,
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: l10n?.searchNewsPlaceholder ?? 'Masukkan nama berita',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _keyword = value;
                      _page = 1;
                      _isLastPage = false;
                      _newsList = [];
                    });
                    _debounceTimer?.cancel();
                    _debounceTimer = Timer(_debounceDuration, () => _loadData(context, value, false, _selectedCategory));
                  },
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: _newsCategories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = _newsCategories[index];
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category.id;
                              _page = 1;
                              _isLastPage = false;
                              _newsList = [];
                            });
                            _loadData(context, _keyword, false, category.id == 0 ? null : category.id);
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: IntrinsicWidth( // Ensures the pill only takes required width
                            child: Container(
                              constraints: const BoxConstraints(
                                minHeight: 32,
                                minWidth: 50, // Reduced minWidth to let smaller words fit
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: _selectedCategory == category.id ? const Color(0xFF2e2f7f) : Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              // Simplified centering: child is just the text
                              child: Center(
                                child: Text(
                                  category.name,
                                  textAlign: TextAlign.center,
                                  softWrap: false, // Prevents text from trying to wrap to a second line
                                  overflow: TextOverflow.visible, // Ensures text isn't clipped by the engine
                                  style: TextStyle(
                                    color: _selectedCategory == category.id ? Colors.white : Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading && _page == 1) ...[
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(color: Color(0xFF2e2f7f)),
              ),
            ),
          ]
          else if (!_isLoading && _newsList.isEmpty) ...[
            Expanded(
              child: Center(
                child: Text(
                  l10n?.emptyNews ?? 'Tidak ada berita',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ]
          else
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.72,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final news = _newsList[index];
                        return NewsCard(
                          news: news,
                          compact: true,
                          onTap: () => launchWebsite(news.link),
                        );
                      },
                      childCount: _newsList.length,
                    ),
                  ),
                ),
                if (!_isLastPage)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.72,
                    ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return SizedBox(
                        width: double.infinity,
                        height: 88,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            width: double.infinity,
                            height: 88,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                    childCount: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}