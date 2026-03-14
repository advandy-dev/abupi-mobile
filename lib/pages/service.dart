import 'dart:io';

import 'package:abupi/helper/launch_url.dart';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/main.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceScreen extends StatefulWidget {

  const ServiceScreen();

  @override
  _ServiceScreen createState() => _ServiceScreen();
}

class _ServiceScreen extends State<ServiceScreen> {
  bool _isDownloading = false;
  double _downloadProgress = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        return true;
      }
      // For Android 11+ (API 30+), use manage external storage or app-specific directory
      final manageStatus = await Permission.manageExternalStorage.request();
      return manageStatus.isGranted;
    }
    return true; // iOS doesn't need explicit permission for app documents
  }

  Widget _buildExpandableCapsule(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(145, 179, 236, 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color.fromRGBO(145, 179, 236, 1.0),
            ),
          ),
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

  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: const Color.fromRGBO(145, 179, 236, 1.0),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmailItem(BuildContext context, List<String> emails) {
    final l10n = AppLocalizations.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.email,
          size: 20,
          color: Color.fromRGBO(145, 179, 236, 1.0),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Email',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              ...emails.map((email) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  email,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF333333),
                  ),
                ),
              )),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => launchEmail(emails),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2e2f7f),
                    side: const BorderSide(
                      color: Color(0xFF2e2f7f),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.send, size: 18),
                  label: Text(l10n?.sendEmail ?? 'Kirim Email'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneItem(BuildContext context, String phone) {
    final l10n = AppLocalizations.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.phone,
          size: 20,
          color: Color.fromRGBO(145, 179, 236, 1.0),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n?.phone ?? 'Telepon',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                phone,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _launchPhone(phone),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2e2f7f),
                    side: const BorderSide(
                      color: Color(0xFF2e2f7f),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.call, size: 18),
                  label: Text(l10n?.contact ?? 'Hubungi'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _launchPhone(String phone) async {
    final cleanPhone = phone.replaceAll(' ', '');
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: cleanPhone,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.service ?? 'Layanan',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            _buildExpandableCapsule(
              context,
              title: l10n?.consultationService ?? 'Konsultasi BUP/Tersus/TUKS',
              icon: Icons.support_agent,
              children: [
                const SizedBox(height: 8),
                _buildContactItem(
                  icon: Icons.location_on,
                  label: l10n?.address ?? 'Alamat',
                  value: 'Jl. Boulevard Raya Blok QJ 1 No. 20\nKelapa Gading, Jakarta Utara 14240',
                ),
                const SizedBox(height: 12),
                _buildEmailItem(
                  context,
                  ['sekretariat@abupi.or.id', 'abupi.sekretariat@gmail.com'],
                ),
                const SizedBox(height: 12),
                _buildPhoneItem(context, '0813 8823 4109'),
              ],
            ),
            const SizedBox(height: 12),
            _buildExpandableCapsule(
              context,
              title: l10n?.educationAndTraining ?? 'Pendidikan & Pelatihan',
              icon: Icons.school,
              children: [
                const SizedBox(height: 8),
                _buildContactItem(
                  icon: Icons.category,
                  label: l10n?.trainingType ?? 'Tipe Pelatihan',
                  value: 'Public Training\nIn-House Training',
                ),
                const SizedBox(height: 12),
                _buildContactItem(
                  icon: Icons.location_on,
                  label: l10n?.address ?? 'Alamat',
                  value: 'Jl. Boulevard Raya Blok QJ 1 No. 20\nKelapa Gading, Jakarta Utara 14240',
                ),
                const SizedBox(height: 12),
                _buildEmailItem(
                  context,
                  ['sekretariat@abupi.or.id', 'abupi.sekretariat@gmail.com'],
                ),
                const SizedBox(height: 12),
                _buildPhoneItem(context, '0813 8823 4109'),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFF632f9c)),
                  minimumSize: WidgetStatePropertyAll<Size>(
                      Size(double.infinity, 42)
                  ),
                ),
                onPressed: () => Navigator.pushNamed(context, AbupiApp.registrationRoute),
                child: const Text(
                  'Join ABUPI',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
