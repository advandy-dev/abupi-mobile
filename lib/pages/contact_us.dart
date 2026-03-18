import 'dart:math';

import 'package:abupi/util/launch_url.dart';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> _launchMaps(String address) async {
    const mapsURL = 'https://www.google.com/maps/search/?api=1&query=';
    final Uri mapsUri = Uri.parse(
      '$mapsURL${Uri.encodeComponent(address)}'
    );
    if (await canLaunchUrl(mapsUri)) {
      await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(description, style: const TextStyle(color: Colors.black)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFFE2642A)),
              ),
              onPressed: onPressed,
              child: Text(buttonText, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
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
          l10n?.contactUs ?? 'Hubungi Kami',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFE3E3E3),
          ),
          Image.asset('assets/images/office.png'),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 120, 16, 0),
            child: Column(
              children: [
                _buildCard(
                  icon: Icons.location_on,
                  title: l10n?.officeAddressValue ?? 'Alamat Kantor Kami',
                  description: 'Jl. Wijaya I No. 381i, Kebayoran Baru, Jakarta Selatan 12170',
                  buttonText: l10n?.openMap ?? 'Buka Map',
                  onPressed: () => _launchMaps('ASOSIASI BADAN USAHA PELABUHAN INDONESIA (ABUPI)'),
                ),
                const SizedBox(height: 16),
                _buildCard(
                  icon: Icons.phone,
                  title: l10n?.phoneNumber ?? 'Nomor Telepon',
                  description: '(021) 7206902',
                  buttonText: l10n?.contact ?? 'Hubungi',
                  onPressed: () => _launchPhone('0217206902'),
                ),
                const SizedBox(height: 16),
                _buildCard(
                  icon: Icons.phone,
                  title: 'Hotline',
                  description: '0813 8823 4109',
                  buttonText: l10n?.contact ?? 'Hubungi',
                  onPressed: () => _launchPhone('081388234109'),
                ),
                const SizedBox(height: 16),
                _buildCard(
                  icon: Icons.email,
                  title: l10n?.emailAddress ?? 'Alamat Email',
                  description: 'sekretariat@abupi.or.id',
                  buttonText: l10n?.sendEmail ?? 'Kirim Email',
                  onPressed: () => launchEmail(['sekretariat@abupi.or.id']),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
