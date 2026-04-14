import 'dart:convert';

import 'package:abupi/services/wordpress_api.dart';
import 'package:abupi/util/launch_url.dart';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/models/member_list.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MemberListScreen extends StatefulWidget {

  const MemberListScreen();

  @override
  _MemberListScreen createState() => _MemberListScreen();
}

class _MemberListScreen extends State<MemberListScreen> {

  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  List<MemberList> _memberList = [];
  int _page = 1;
  bool _isLastPage = false;

  @override
  void initState() {
    super.initState();
    _loadData();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Trigger when the user is 200 pixels from the bottom
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoading) {
        _loadData();
      }
    }
  }

  Future<void> _loadData() async {
    if (_isLastPage == true) {
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });
      final response = await WordPressApi.getMembers(_page);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isNotEmpty) {
          try {
            var members = jsonList.map((item) {
              final acf = item['acf'];
              return MemberList(
                name: acf['member_name'],
                address: acf['member_address'],
                website: acf['member_website'],
                imageURL: acf['member_logo'],
              );
            }).toList();

            setState(() {
              _memberList = _memberList + members;
              _isLoading = false;
              _page += 1;
              _isLastPage = members.length < 10;
            });
          } catch (e) {
            debugPrint('error galleries list $e');
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

  Widget _buildExpandableCapsule(
      BuildContext context, {
        required String title,
        required List<Widget> children,
      }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(2, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Color(0xFF333333),
              ),
            ),
            iconColor: const Color.fromRGBO(145, 179, 236, 1.0),
            collapsedIconColor: Colors.grey,
            backgroundColor: Colors.white,
            collapsedBackgroundColor: Colors.white,
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: children,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final media = MediaQuery.of(context);
    // SingleChildScrollView gives the Column unbounded height; avoid Expanded.
    // Approximate body height below AppBar for centered loading/empty states.
    final centeredPlaceholderHeight = media.size.height -
        media.padding.vertical -
        kToolbarHeight -
        32;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.listOfMember ?? 'Daftar Anggota',
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
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            if (_isLoading && _page == 1) ...[
              SizedBox(
                height: centeredPlaceholderHeight,
                child: const Center(
                  child: CircularProgressIndicator(color: Color(0xFF2e2f7f)),
                ),
              ),
            ]
            else if (!_isLoading && _memberList.isEmpty) ...[
              SizedBox(
                height: centeredPlaceholderHeight,
                child: Center(
                  child: Text(l10n?.emptyData ?? 'Tidak ada data'),
                ),
              ),
            ]
            else ...[
              ..._memberList.map((member) => _buildExpandableCapsule(
              context,
              title: member.name,
              children: [
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (member.imageURL != null) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              member.imageURL!,
                              width: 64,
                              height: 64,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 64,
                                height: 64,
                                color: Colors.grey[300],
                                child: const Icon(Icons.image_not_supported),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Expanded(
                          child: Text(
                            member.address ?? '-',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (member.website != null && member.website!.isNotEmpty)
                    ...[
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.open_in_new),
                          label: Text(l10n?.visitWebsite ?? 'Kunjungi Website'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE2642A),
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            final url = member.website!;
                            final validUrl =
                                (url.startsWith("http://") || url.startsWith("https://"))
                                    ? url
                                    : "https://$url";
                            launchWebsite(validUrl);
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            )).toList(),
              if (_isLastPage == false) ...[
                const SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    height: 52,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
              ],
            ]
          ],
        ),
      ),
    );
  }
}
