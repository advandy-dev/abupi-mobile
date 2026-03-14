import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/models/region_member.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MapsSection extends StatefulWidget {

  const MapsSection({super.key});

  @override
  State<MapsSection> createState() => _MapsSectionState();
}

class _MapsSectionState extends State<MapsSection> {
  final mapImage = 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/indonesian-map.png';
  final List<RegionMember> _members = [
    RegionMember(
      region: 'Aceh',
      regionTranslate: 'Aceh',
      colorHex: 0xFF01EAC4,
      totalBUP: 2,
    ),
    RegionMember(
      region: 'Sumatera Utara',
      regionTranslate: 'North Sumatera',
      colorHex: 0xFF00E268,
      totalBUP: 2,
    ),
    RegionMember(
      region: 'Riau',
      regionTranslate: 'Riau',
      colorHex: 0xFFD66B92,
      totalBUP: 4,
    ),
    RegionMember(
      region: 'Kepri & Batam',
      regionTranslate: 'Kepri & Batam',
      colorHex: 0xFFADF376,
      totalBUP: 13,
    ),
    RegionMember(
      region: 'Sumatera Selatan',
      regionTranslate: 'South Sumatera',
      colorHex: 0xFFF3D62C,
      totalBUP: 7,
    ),
    RegionMember(
      region: 'Lampung',
      regionTranslate: 'Lampung',
      colorHex: 0xFF4AE778,
      totalBUP: 2,
      totalTERSUS: 0,
    ),
    RegionMember(
      region: 'Banten',
      regionTranslate: 'Banten',
      colorHex: 0xFFEB3BE7,
      totalBUP: 7,
      totalTUKS: 1,
    ),
    RegionMember(
      region: 'DKI Jakarta & Jawa Barat',
      regionTranslate: 'Jakarta & West Java',
      colorHex: 0xFFEB3BE7,
      totalBUP: 33,
    ),
    RegionMember(
      region: 'Jawa Tengah',
      regionTranslate: 'Central Java',
      colorHex: 0xFFAC39E1,
      totalBUP: 3,
    ),
    RegionMember(
      region: 'Jawa Timur',
      regionTranslate: 'East Java',
      colorHex: 0xFFE0AE74,
      totalBUP: 8,
    ),
    RegionMember(
      region: 'Kalimantan Barat',
      regionTranslate: 'West Kalimantan',
      colorHex: 0xFF7CD475,
      totalBUP: 3,
      totalTERSUS: 1,
    ),
    RegionMember(
      region: 'Kalimantan Timur',
      regionTranslate: 'East Kalimantan',
      colorHex: 0xFFF095C3,
      totalBUP: 22,
      totalTUKS: 1,
    ),
    RegionMember(
      region: 'Kalimantan Tengah',
      regionTranslate: 'Central Kalimantan',
      colorHex: 0xFFE7E79B,
      totalBUP: 5,
      totalTUKS: 1,
    ),
    RegionMember(
      region: 'Kalimantan Selatan',
      regionTranslate: 'South Kalimantan',
      colorHex: 0xFFC3DC49,
      totalBUP: 10,
      totalTUKS: 1,
    ),
    RegionMember(
      region: 'Sulawesi Utara',
      regionTranslate: 'North Sulawesi',
      colorHex: 0xFF4FCFD9,
      totalBUP: 1,
    ),
    RegionMember(
      region: 'Sulawesi Tengah',
      regionTranslate: 'Central Sulawesi',
      colorHex: 0xFFF17378,
      totalBUP: 2,
    ),
    RegionMember(
      region: 'Sulawesi Tenggara',
      regionTranslate: 'South East Sulawesi',
      colorHex: 0xFF8EE76E,
      totalBUP: 3,
    ),
    RegionMember(
      region: 'Sulawesi Selatan',
      regionTranslate: 'South Sulawesi',
      colorHex: 0xFF4DC2D4,
      totalBUP: 2,
    ),
    RegionMember(
      region: 'Nusa Tenggara Barat',
      regionTranslate: 'West Nusa Tenggara',
      colorHex: 0xFF01A2E3,
      totalBUP: 1,
    ),
    RegionMember(
      region: 'Papua Barat',
      regionTranslate: 'West Papua',
      colorHex: 0xFFCF59E2,
      totalBUP: 0,
      totalTUKS: 1,
    ),
    RegionMember(
      region: 'Papua Tengah',
      regionTranslate: 'Central Papua',
      colorHex: 0xFFE76681,
      totalBUP: 1,
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
        builder: (context) => RegionPopup(member: member),
      );
    }

    return SizedBox(
      child: Container(
        color: const Color(0xFF2E2F7F),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(vertical: 4),
                itemCount: _members.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final member = _members[index];
                  final name = l10n?.language == 'id' ?
                    member.region :
                    member.regionTranslate;
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => showRegionPopup(member),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Color(member.colorHex),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          name,
                          style: TextStyle(
                            color: _contrastColor(member.colorHex),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
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

class RegionPopup extends StatelessWidget {
  final RegionMember member;
  const RegionPopup({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final language = l10n?.language;

    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        language == 'id' ? member.region : member.regionTranslate,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(Icons.close, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.3),
                ),
                const SizedBox(height: 8),
                _buildItem('BUP', member.totalBUP ?? 0),
                _buildItem('TUKS', member.totalTUKS ?? 0),
                _buildItem('TERSUS', member.totalTERSUS ?? 0),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 80), // Space for the bottom nav bar
        ],
      ),
    );
  }

  Widget _buildItem(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Text('$label: $value', style: const TextStyle(fontSize: 16)),
    );
  }
}
