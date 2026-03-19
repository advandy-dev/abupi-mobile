import 'dart:convert';

import 'package:abupi/arguments/event_detail_args.dart';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/main.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:flutter/material.dart';
import 'package:abupi/component/home/section/event/event_card.dart';
import 'package:abupi/models/event.dart';

class EventSection extends StatefulWidget {
  const EventSection({super.key});

  @override
  State<EventSection> createState() => _EventSectionState();
}

class _EventSectionState extends State<EventSection> {
  List<Event> _eventList = [];
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

  static int _parseInt(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is String) return int.tryParse(v) ?? 0;
    return int.tryParse(v.toString()) ?? 0;
  }

  static String _str(dynamic v) => v?.toString() ?? '';

  static String? _strOrNull(dynamic v) => v == null ? null : v.toString();

  void _updateScrollButtons() {
    if (!_scrollController.hasClients) return;
    
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    
    final canLeft = currentScroll > 0;
    final canRight = currentScroll < maxScroll - 1; // small threshold to handle floating point
    
    if (_canScrollLeft != canLeft || _canScrollRight != canRight) {
      setState(() {
        _canScrollLeft = canLeft;
        _canScrollRight = canRight;
      });
    }
  }

  Future<void> _loadData() async {
    try {
      final response = await WordPressApi.getEvents(1, 3, null);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isNotEmpty) {
          var events = jsonList.map((item) {
            final acf = item['acf'] as Map<String, dynamic>? ?? {};
            return Event(
              id: _parseInt(item['id']),
              title: _str(acf['title']),
              description: _str(acf['description']),
              startDate: _str(acf['start_date']),
              endDate: _str(acf['end_date']),
              location: _strOrNull(acf['location']),
              imageUrl: _strOrNull(acf['image']),
            );
          }).toList();

          if (mounted) {
            setState(() {
              _eventList = events;
            });
          }
        }
      }
      // Check scroll buttons after frame is rendered
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateScrollButtons();
      });
    } catch (e) {
      debugPrint('$e');
    } finally {
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

  void _openEventDetail(Event event) {
    Navigator.pushNamed(
      context,
      '${AbupiApp.eventRoute}/${event.id}',
      arguments: EventDetailArguments(event: event),
    );
  }

  void _viewAllEvents() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AbupiApp.homeRoute,
      (route) => false,
      arguments: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container();
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
              l10n?.event ?? 'Acara',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: _viewAllEvents,
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

    if (_eventList.isEmpty) {
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
            itemCount: _eventList.length,
            itemBuilder: (context, index) {
              final event = _eventList[index];
              return EventCard(
                event: event,
                onTap: () => _openEventDetail(event),
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
