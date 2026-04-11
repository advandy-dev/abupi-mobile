import 'dart:convert';

import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/models/stakeholder_category.dart';
import 'package:abupi/models/stakeholders.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:flutter/material.dart';
import 'package:abupi/util/launch_url.dart';
import 'package:shimmer/shimmer.dart';

class StakeholderScreen extends StatefulWidget {
  const StakeholderScreen({super.key});

  @override
  _StakeholderScreen createState() => _StakeholderScreen();
}

class _StakeholderScreen extends State<StakeholderScreen> {
  final ScrollController _scrollController = ScrollController();

  List<Stakeholders> _stakeholderList = [];
  List<StakeholderCategory> _stakeholderCategories = [];
  int _stakeholderCategory = 0;
  bool _isLoadingCategory = false;
  bool _isLoadingStakeholder = false;
  bool _isLastPage = false;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This code runs AFTER the widget is rendered
      _loadData(context);
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Trigger when the user is 200 pixels from the bottom
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoadingCategory) {
        _loadStakeholder(_stakeholderCategory);
      }
    }
  }

  Future<void> _loadData(BuildContext context) async {
    if (_isLastPage) {
      return;
    }

    final l10n = AppLocalizations.of(context);
    final language = l10n?.locale.languageCode ?? 'id';

    try {
      setState(() {
        _isLoadingCategory = true;
      });
      final response = await WordPressApi.getStakeholderCategory(language);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isNotEmpty) {
          try {
            var categories = jsonList.map((item) {
              return StakeholderCategory(id: item['id'], name: item['name']);
            }).toList();

            int firstCategory = categories[0].id;

            setState(() {
              _stakeholderCategory = firstCategory;
              _stakeholderCategories = categories;
              _isLoadingCategory = false;
            });

            _loadStakeholder(firstCategory);
          } catch (e) {
            debugPrint('error stakeholder list $e');
            setState(() {
              _isLoadingCategory = false;
            });
          }
        } else {
          setState(() {
            _isLoadingCategory = false;
          });
        }
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> _loadStakeholder(int category) async {
    if (_isLastPage) {
      return;
    }

    try {
      setState(() {
        _isLoadingStakeholder = true;
      });
      final response = await WordPressApi.getStakeholder(category, _page);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isNotEmpty) {
          try {
            var stakeholder = jsonList.map((item) {
              final acf = item['acf'];
              return Stakeholders(
                name: acf['partner_name'],
                imageURL: acf['partner_logo'],
                address: acf['partner_address'],
                phone: acf['phone_number'],
                email: acf['email_address'],
                website: acf['website'],
              );
            }).toList();

            setState(() {
              _stakeholderList = _stakeholderList + stakeholder;
              _isLoadingStakeholder = false;
              _page += 1;
              _isLastPage = stakeholder.length < 5;
            });
          } catch (e) {
            debugPrint('error stakeholder list $e');
            setState(() {
              _isLoadingStakeholder = false;
            });
          }
        } else {
          setState(() {
            _isLoadingStakeholder = false;
          });
        }
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  void _showSubordinateBottomSheet(BuildContext context,) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final l10n = AppLocalizations.of(context);

        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    l10n?.category ?? 'Kategori',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2e2f7f),
                    ),
                  ),
                ),
                Divider(color: Colors.grey.shade400),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _stakeholderCategories.length,
                    itemBuilder: (context, index) {
                      final category = _stakeholderCategories[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _stakeholderCategory = category.id;
                            _stakeholderList = [];
                            _isLastPage = false;
                            _page = 1;
                          });
                          _loadStakeholder(category.id);
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                category.name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              if (_stakeholderCategory == category.id)
                                const Icon(
                                  Icons.check,
                                  color: Color(0xFF2e2f7f),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.strategicPartners ?? 'Mitra Strategis',
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
      body: Column(
        children: [
          InkWell(
            onTap: () => _showSubordinateBottomSheet(context),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _stakeholderCategories.firstWhere((element) =>
                      element.id == _stakeholderCategory,
                      orElse: () => StakeholderCategory(
                        id: 0,
                        name:l10n?.chooseCategory ?? '',
                      ),
                    ).name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
          if (_isLoadingStakeholder && _page == 1) ...[
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(color: Color(0xFF2e2f7f)),
              ),
            ),
          ]
          else if (!_isLoadingStakeholder && _stakeholderList.isEmpty) ...[
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
          // Scrollable grid
            Expanded(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    sliver: SliverList.builder(
                      itemCount: _stakeholderList.length,
                      itemBuilder: (context, index) {
                        return _buildStakeholderItem(context, _stakeholderList[index]);
                      },
                    ),
                  ),
                  if (!_isLastPage)
                    SizedBox(
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
                    ),
                ],
              ),
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
    return Container();
  }

  Widget _buildStakeholderItem(BuildContext context, Stakeholders partner) {
    final l10n = AppLocalizations.of(context);
    var phoneFaxText = '';

    phoneFaxText = '${l10n?.phoneShort ?? 'Telp'}: ${partner.phone}';
    if (partner.fax != null && partner.fax!.isNotEmpty) {
      phoneFaxText = '$phoneFaxText - Fax. ${partner.fax}';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Name/Title
              Text(
                partner.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo/Image
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: partner.imageURL.isNotEmpty ?
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        partner.imageURL,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.business,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
                    ) : const Icon(
                      Icons.business,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Address
                        Text(
                          partner.address ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF555555),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Phone and Fax
                        Text(
                          phoneFaxText,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF555555),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Email & Website buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => launchEmail([partner.email ?? '']),
                      icon: const Icon(Icons.email_outlined, size: 18),
                      label: const Text('Email'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE2642A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => launchWebsite(partner.website ?? ''),
                      icon: const Icon(Icons.language, size: 18),
                      label: const Text('Website'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE2642A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }
}