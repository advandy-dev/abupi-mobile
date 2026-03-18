import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/main.dart';
import 'package:flutter/material.dart';

class OrganizationScreen extends StatelessWidget {
  const OrganizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.organization ?? 'Organisasi',
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
      body: ListView(
        children: [
          _buildMenuItem(
            context,
            icon: Icons.groups_outlined,
            title: l10n?.organizationStructure ?? 'Struktur Organisasi',
            onTap: () {
              Navigator.pushNamed(context, AbupiApp.boardOfDirectorsRoute);
            },
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            icon: Icons.location_on_outlined,
            title: l10n?.regionalCoordinator ?? 'Koordinator Wilayah',
            onTap: () {
              Navigator.pushNamed(context, AbupiApp.regionalBODRoute);
            },
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            icon: Icons.badge_outlined,
            title: l10n?.members ?? 'Anggota ABUPI',
            onTap: () {
              Navigator.pushNamed(context, AbupiApp.memberListRoute);
            },
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            icon: Icons.handshake_outlined,
            title: l10n?.strategicPartners ?? 'Mitra Strategis',
            onTap: () {
              Navigator.pushNamed(context, AbupiApp.strategicPartnersRoute);
            },
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            icon: Icons.business_outlined,
            title: l10n?.workPartners ?? 'Mitra Kerja',
            onTap: () {
              Navigator.pushNamed(context, AbupiApp.workPartnersRoute);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF2e2f7f),
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 60,
      color: Colors.grey.shade300
    );
  }
}
