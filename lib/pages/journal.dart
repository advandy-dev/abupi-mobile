import 'dart:async';
import 'dart:convert';

import 'package:abupi/arguments/pdf_args.dart';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/main.dart';
import 'package:abupi/models/journal.dart';
import 'package:abupi/models/journal_category.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:flutter/material.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounceTimer;
  static const _debounceDuration = Duration(milliseconds: 400);
  int _page = 1;
  bool _isLastPage = false;
  String? _keyword;

  bool _isLoading = false;
  List<JournalCategory> _categories = [];
  int _selectedCategory = 0;
  List<Journal> _journalList = [];

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
        _loadData(context, _keyword, false, _selectedCategory == 0 ? null : _selectedCategory);
      }
    }
  }

  Future<void> _loadData(
    BuildContext context,
    String? keyword,
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

      List<dynamic> results = await Future.wait([
        WordPressApi.getJournals(_page, keyword, selectedCategory),
        shouldFetchCategory ? WordPressApi.getJournalCategory() : Future.value(null),
      ]);

      if (results[0]?.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(results[0]?.body);
        if (jsonList.isNotEmpty) {
          try {
            var journals = jsonList.map((item) {
              final acf = item['acf'];
              return Journal(
                title: acf['title'],
                journal: acf['journal'],
                abstract: '${acf['abstract']}',
                author: acf['author'].toString().isEmpty ? 'ABUPI' : acf['author'].toString(),
              );
            }).toList();

            setState(() {
              _journalList = _journalList + journals;
              _isLastPage = journals.length < 10;
              _page = journals.length < 10 ? _page : (_page + 1);
              _isLoading = shouldFetchCategory;
            });
          } catch (e) {
            debugPrint('error journal list $e');
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
      }

      if (results[1]?.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(results[1]?.body);
        if (jsonList.isNotEmpty) {
          try {
            var categories = jsonList.map((item) {
              return JournalCategory(
                id: item['id'],
                name: item['name'],
              );
            }).toList();

            setState(() {
              _categories = [
                JournalCategory(id: 0, name: language == 'id' ? 'Semua' : 'All')
              ] + categories;
              _selectedCategory = 0;
              _isLoading = false;
            });
          } catch (e) {
            debugPrint('error journal list $e');
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
      _journalList = [];
      _isLastPage = false;
    });
    _loadData(context, _keyword, false, _selectedCategory == 0 ? null : _selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.journal ?? 'Jurnal',
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Sticky search bar
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            color: Colors.white,
            child: Column(
              children: [
                TextField(
                  style: const TextStyle(color: Colors.black),
                  controller: _searchController,
                  cursorColor: const Color(0xFF2e2f7f),
                  decoration: InputDecoration(
                    hintText: l10n?.searchJournalPlaceholder ?? 'Masukkan nama jurnal',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF2e2f7f)), // Focused color
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
                      _journalList = [];
                    });
                    _debounceTimer?.cancel();
                    _debounceTimer = Timer(_debounceDuration, () => _loadData(context, value, false, _selectedCategory == 0 ? null : _selectedCategory));
                  },
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: _categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category.id;
                              _page = 1;
                              _isLastPage = false;
                              _journalList = [];
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
          else if (!_isLoading && _journalList.isEmpty) ...[
            Expanded(
              child: Center(
                child: Text(
                  l10n?.emptyData ?? 'Tidak ada data',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            )
          ]
          else
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 16),
              itemCount: _journalList.length,
              itemBuilder: (context, index) {
                final journal = _journalList[index];
                return JournalMenuItem(journal: journal);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 2);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 100,
        shape: const StadiumBorder(),
        onPressed: () {
          Navigator.pushNamed(context, AbupiApp.formJournalRoute);
        },
        backgroundColor: const Color(0xFF632f9c),
        label: Text(l10n?.sendJournal ?? 'Kirim Jurnal', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class JournalMenuItem extends StatefulWidget {
  final Journal journal;

  const JournalMenuItem({
    super.key,
    required this.journal,
  });

  @override
  State<JournalMenuItem> createState() => _JournalMenuItemState();
}

class _JournalMenuItemState extends State<JournalMenuItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        // Manage state change to trigger rotation
        onExpansionChanged: (bool expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        // Remove default borders
        shape: const Border(),
        collapsedShape: const Border(),

        title: Text(
          widget.journal.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Penulis: ${widget.journal.author}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            Text(
              'Kategori: ',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),

        // Custom Trailing with Manual Rotation
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.visibility_outlined,
                color: Color(0xFF2e2f7f),
                size: 22,
              ),
              onPressed: () {
                Navigator.pushNamed(context, AbupiApp.pdfRoute, arguments: PDFScreenArguments(url: widget.journal.journal));
              },
            ),
            // This replaces the broken default rotation
            AnimatedRotation(
              turns: _isExpanded ? 0.5 : 0, // 0.5 turns = 180 degrees
              duration: const Duration(milliseconds: 200),
              child: const Icon(Icons.expand_more),
            ),
          ],
        ),

        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                const SizedBox(height: 8),
                Text(
                  l10n?.abstract ?? 'Abstrak',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.journal.abstract.isEmpty
                      ? 'Abstrak belum tersedia'
                      : widget.journal.abstract,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}