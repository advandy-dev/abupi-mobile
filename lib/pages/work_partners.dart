import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/models/work_partners.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkPartnersScreen extends StatefulWidget {
  const WorkPartnersScreen();

  @override
  _WorkPartnersScreen createState() => _WorkPartnersScreen();
}

class _WorkPartnersScreen extends State<WorkPartnersScreen> {
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
  ];

  @override
  void initState() {
    super.initState();
  }

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

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.workPartners ?? 'Mitra Kerja',
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
      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid.count(
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              crossAxisCount: 2,
              children: _partnerURL.map((partner) =>
                InkWell(
                  onTap: () => {
                    if (partner.website != null) {
                      _launchURL(partner.website ?? '')
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
                    child: Image.network(partner.imageURL, width: 150),
                  ),
                ),
              ).toList(),
            ),
          ),
        ],
      )
    );
  }
}
