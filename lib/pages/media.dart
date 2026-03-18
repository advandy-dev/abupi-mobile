import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/main.dart';
import 'package:flutter/material.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: const Text(
          'Media',
          style: TextStyle(
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
            icon: Icons.photo_library_outlined,
            title: l10n?.gallery ?? 'Galeri',
            onTap: () {
              Navigator.pushNamed(context, AbupiApp.galeriRoute);
            },
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            icon: Icons.newspaper_outlined,
            title: l10n?.news ?? 'Berita',
            onTap: () {
              Navigator.pushNamed(context, AbupiApp.newsRoute);
            },
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            icon: Icons.markunread_mailbox,
            title: l10n?.newsletter ?? 'Buletin',
            onTap: () {
              // TODO newsletter page
            },
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            icon: Icons.my_library_books,
            title: l10n?.journal ?? 'Jurnal',
            onTap: () {
              // TODO journal page
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
                  fontWeight: FontWeight.bold,
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
      color: Colors.grey.shade300,
    );
  }
}
