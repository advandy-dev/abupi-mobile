import 'dart:async';
import 'dart:convert';

import 'package:abupi/arguments/event_detail_args.dart';
import 'package:abupi/component/home/section/event/event_card.dart';
import 'package:abupi/helper/string.dart';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/main.dart';
import 'package:abupi/models/event.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

const maxPerPage = 12;

class _EventScreenState extends State<EventScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounceTimer;
  static const _debounceDuration = Duration(milliseconds: 400);
  int _page = 1;
  bool _isLastPage = false;
  String _keyword = '';

  List<Event> _eventList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData(_keyword);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Trigger when the user is 200 pixels from the bottom
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoading) {
        _loadData(_keyword);
      }
    }
  }

  Future<void> _loadData(String keyword) async {
    if (_isLastPage) {
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });
      final response = await WordPressApi.getEvents(_page, maxPerPage, keyword);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isNotEmpty) {
          try {
            var events = jsonList.map((item) {
              final acf = item['acf'] as Map<String, dynamic>? ?? {};
              return Event(
                id: _parseInt(item['id']),
                title: stringOrEmpty(acf['title']),
                description: stringOrEmpty(acf['description']),
                startDate: stringOrEmpty(acf['start_date']),
                endDate: stringOrEmpty(acf['end_date']),
                location: stringOrNull(acf['location']),
                imageUrl: stringOrNull(acf['image']),
              );
            }).toList();
            setState(() {
              _eventList = _eventList + events;
              _isLoading = false;
              _isLastPage = events.length < maxPerPage;
              _page = events.length < maxPerPage ? _page : (_page + 1);
            });
          } catch (e) {
            debugPrint('error event list $e');
            setState(() {
              _isLoading = false;
            });
          }
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      _page = 1;
      _eventList = [];
      _isLastPage = false;
    });
    _loadData(_keyword);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  static int _parseInt(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is String) return int.tryParse(v) ?? 0;
    return int.tryParse(v.toString()) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.event ?? 'Acara',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
            color: colorScheme.surface,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n?.searchEventPlaceholder ?? 'Masukkan nama acara',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: (value) {
                debugPrint('search $value');
                setState(() {
                  _keyword = value;
                  _page = 1;
                  _isLastPage = false;
                  _eventList = [];
                });
                _debounceTimer?.cancel();
                _debounceTimer = Timer(_debounceDuration, () => _loadData(value));
              },
            ),
          ),
          if (_isLoading && _page == 1) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: 4,
                itemBuilder: (context, imageIndex) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
          ]
          else if (!_isLoading && _eventList.isEmpty) ...[
            Expanded(
              child: Center(
                child: Text(l10n?.emptyEvent ?? 'Tidak ada acara'),
              ),
            )
          ]
          else
          // Scrollable grid
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
                          final event = _eventList[index];
                          return EventCard(
                            event: event,
                            compact: true,
                            onTap: () => {
                              Navigator.pushNamed(
                                context,
                                '${AbupiApp.eventRoute}/${event.id}',
                                arguments: EventDetailArguments(event: event),
                              ),
                            },
                          );
                        },
                        childCount: _eventList.length,
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
        ],
      ),
    );
  }
}
