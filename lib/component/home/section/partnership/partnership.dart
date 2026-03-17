import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/models/work_partners.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Partnership extends StatefulWidget {
  const Partnership({super.key});

  @override
  State<Partnership> createState() => _PartnershipState();
}

class _PartnershipState extends State<Partnership> {
  final List<WorkPartners> _partnerURL = [
    WorkPartners(
      website: 'https://www.bki.academy/id',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/BKI-1.png',
    ),
    WorkPartners(
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/e-port.jpg',
    ),
    WorkPartners(
      website: 'https://www.lsppelabuhan.com/',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/LSP-Pelabuhan.jpg',
    ),
    WorkPartners(
      website: 'https://www.edustri.com/port-academy/',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PORT-ACADEMY.jpg',
    ),
    WorkPartners(
      website: 'https://www.ccccindonesia.co.id/',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/CCCEI-Logo-3.png',
    ),
    WorkPartners(
      website: 'https://fyfeindonesia.com/en/',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PT-FYFE-FIBRWRAP-INDONESIA.png',
    ),
    WorkPartners(
      website: 'https://www.primus.co.id/#home',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/primuss.png',
    ),
    WorkPartners(
      website: 'https://www.bki.academy/id',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/BKI-1.png',
    ),
    WorkPartners(
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/e-port.jpg',
    ),
    WorkPartners(
      website: 'https://www.lsppelabuhan.com/',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/LSP-Pelabuhan.jpg',
    ),
    WorkPartners(
      website: 'https://www.edustri.com/port-academy/',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PORT-ACADEMY.jpg',
    ),
    WorkPartners(
      website: 'https://www.ccccindonesia.co.id/',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/CCCEI-Logo-3.png',
    ),
    WorkPartners(
      website: 'https://fyfeindonesia.com/en/',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PT-FYFE-FIBRWRAP-INDONESIA.png',
    ),
    WorkPartners(
      website: 'https://www.primus.co.id/#home',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/primuss.png',
    ),
  ];

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Column(
      children: [
        Text(
          '${l10n?.workPartners ?? 'Mitra Kerja'}:',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
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
                  color: colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Image.network(partner.imageURL, width: 60),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}