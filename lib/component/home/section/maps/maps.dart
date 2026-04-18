import 'dart:convert';

import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/models/member_list.dart';
import 'package:abupi/models/region_member.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MapsSection extends StatefulWidget {

  const MapsSection({super.key});

  @override
  State<MapsSection> createState() => _MapsSectionState();
}

class _MapsSectionState extends State<MapsSection> {
  final mapImage = 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/04/Regional-Map-Mobile-App.png';
  final List<RegionMember> _members = [
    RegionMember(
      region: 'Region 1',
      regionTranslate: 'Region 1',
      colorHex: 0xFFffcec1,
      categoryID: 40,
    ),
    RegionMember(
      region: 'Region 2',
      regionTranslate: 'Region 2',
      colorHex: 0xFFf2e1b6,
      categoryID: 41,
    ),
    RegionMember(
      region: 'Region 3',
      regionTranslate: 'Region 3',
      colorHex: 0xFFd0e9c2,
      categoryID: 42,
    ),
    RegionMember(
      region: 'Region 4',
      regionTranslate: 'Region 4',
      colorHex: 0xFFb1e5f2,
      categoryID: 43,
    ),
  ];

  Color _contrastColor(int colorHex) {
    final color = Color(colorHex);
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black87 : Colors.white;
  }

  void _showImageOverlay(BuildContext context, String imageUrl) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black87,
        pageBuilder: (context, animation, secondaryAnimation) {
          return _ImageOverlay(imageUrl: imageUrl);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    void showRegionPopup(RegionMember member) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => InfiniteScrollSheet(
          regionalName: member.region,
          regionID: member.categoryID,
        ),
      );
    }

    return SizedBox(
      child: Container(
        color: const Color(0xFF1fa2b1),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            Text(
              l10n?.regionalOperationSectionTitle ?? "Wilayah Operasi Regional ABUPI",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(vertical: 4),
                itemCount: _members.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final member = _members[index];
                  final name = l10n?.locale.languageCode == 'id' ?
                    member.region :
                    member.regionTranslate;
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => showRegionPopup(member),
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
                            color: Color(member.colorHex),
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
                              name,
                              textAlign: TextAlign.center,
                              softWrap: false, // Prevents text from trying to wrap to a second line
                              overflow: TextOverflow.visible, // Ensures text isn't clipped by the engine
                              style: TextStyle(
                                color: _contrastColor(member.colorHex),
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
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _showImageOverlay(context, mapImage),
              child: Image.network(
                mapImage,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFF2E2F7F),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageOverlay extends StatelessWidget {
  final String imageUrl;

  const _ImageOverlay({required this.imageUrl});

  Future<void> _downloadImage(BuildContext context) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final uri = Uri.parse(imageUrl);
      final fileName = uri.pathSegments.isNotEmpty
          ? uri.pathSegments.last
          : 'event_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savePath = '${dir.path}/$fileName';

      await Dio().download(imageUrl, savePath);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image saved to $savePath'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Download failed: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.95),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 3.0,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.error, color: Colors.red, size: 48),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.download, color: Colors.white, size: 28),
                    onPressed: () => _downloadImage(context),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 30),
                    onPressed: () => Navigator.of(context).pop(),
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

class InfiniteScrollSheet extends StatefulWidget {
  final String regionalName;
  final int regionID;

  const InfiniteScrollSheet({
    super.key,
    required this.regionalName,
    required this.regionID,
  });

  @override
  State<InfiniteScrollSheet> createState() => _InfiniteScrollSheetState();
}

class _InfiniteScrollSheetState extends State<InfiniteScrollSheet> {
  final ScrollController _scrollController = ScrollController();
  List<MemberList> _items = [];
  int _page = 1;
  bool _isLoading = false;
  bool _isLastPage = false;

  @override
  void initState() {
    super.initState();
    _fetchPage(); // Initial fetch
    _scrollController.addListener(_onScroll);
  }

  Future<void> _fetchPage() async {
    if (_isLoading || _isLastPage) return;

    setState(() => _isLoading = true);

    // Replace this with your actual API call
    // Example: var response = await api.getData(page: _page);
    final response = await WordPressApi.getMembers(_page, widget.regionID);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      if (jsonList.isNotEmpty) {
        try {
          var members = jsonList.map((item) {
            final acf = item['acf'] as Map<String, dynamic>? ?? {};
            return MemberList(
              name: acf['member_name'],
              address: acf['member_address'],
              imageURL: acf['member_logo'],
              website: acf['member_website'],
            );
          }).toList();
          setState(() {
            _items = _items + members;
            _isLastPage = members.length < 15;
            _page = members.length < 15 ? _page : (_page + 1);
            _isLoading = false;
          });
        } catch (e) {
          debugPrint('error event list $e');
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _items = [];
          _isLastPage = true;
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

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _fetchPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        color: Colors.white,
      ),
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.regionalName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 32, color: Colors.black),
                ),
              ],
            ),
          ),
          const Divider(),
          if (_isLoading && _page == 1) ...[
            const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ),
            ),
          ]
          else if (!_isLoading && _items.isEmpty) ...[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  l10n?.emptyData ?? 'Tidak ada data',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ]
          else
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              itemCount: _items.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
              itemBuilder: (context, index) {
                final member = _items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Set your desired radius here
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // 1. The Image (Base layer)
                        Image.network(
                          member.imageURL ?? '',
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.fitWidth,
                        ),
                        // 2. The Overlay (Matching the image size exactly)
                        Positioned.fill(
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            color: Colors.grey.withOpacity(0.7), // Semi-transparent grey
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    member.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    widget.regionalName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                if (member.website != null) ...[
                                  TextButton(
                                    onPressed: () {
                                      launchUrlString(member.website ?? '');
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.launch,
                                          size: 18,
                                          color: Color(0xFFE2642A),
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'Visit Website',
                                          style: TextStyle(
                                            color: Color(0xFFE2642A),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
