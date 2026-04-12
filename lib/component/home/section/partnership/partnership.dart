import 'dart:convert';

import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/main.dart';
import 'package:abupi/models/stakeholder_category.dart';
import 'package:abupi/models/work_partners.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Partnership extends StatefulWidget {
  const Partnership({super.key});

  @override
  State<Partnership> createState() => _PartnershipState();
}

class _PartnershipState extends State<Partnership> {

  List<WorkPartners> _partnerURL = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This code runs AFTER the widget is rendered
      _loadData(context);
    });
  }

  Future<void> _loadData(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final language = l10n?.locale.languageCode ?? 'id';

    try {
      final response = await WordPressApi.getStakeholderCategory(language);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isNotEmpty) {
          try {
            var categories = jsonList.map((item) {
              return StakeholderCategory(id: item['id'], name: item['name']);
            }).toList();
            _loadStakeholder(categories);
          } catch (e) {
            debugPrint('error stakeholder list $e');
          }
        }
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> _loadStakeholder(List<StakeholderCategory> categories) async {
    try {
      List<int> categoryIds = categories.map((category) {
        return category.id;
      }).toList();
      final response = await WordPressApi.getStakeholder(categoryIds, null);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isNotEmpty) {
          try {
            var stakeholder = jsonList.map((item) {
              final acf = item['acf'];
              return WorkPartners(
                imageURL: acf['partner_logo'],
                website: acf['website'],
              );
            }).toList();

            setState(() {
              _partnerURL = stakeholder;
            });
          } catch (e) {
            debugPrint('error stakeholder list $e');
          }
        }
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      color: Colors.grey.shade200,
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n?.companiesThatTrustABUPI ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: _partnerURL.map((partner) {
              return InkWell(
                onTap: () {
                  if (partner.website != null) {
                    _launchURL(partner.website ?? '');
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 8,
                        offset: const Offset(1, 5),
                      ),
                    ],
                  ),
                  child: Image.network(partner.imageURL, width: 60),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          IntrinsicWidth(
            child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                ),
                onPressed: () => Navigator.pushNamed(context, AbupiApp.stakeholderRoute),
                child: Row(
                  children: [
                    Text(
                      l10n?.seeAll ?? 'Lihat semua',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.arrow_circle_right_rounded,
                      color: Color(0xFF2e2f7f),
                    )
                  ],
                )
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}