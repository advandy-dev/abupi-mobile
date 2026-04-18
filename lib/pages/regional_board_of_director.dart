import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/models/regional_bod.dart';
import 'package:flutter/material.dart';

class RegionalBoardOfDirectorsScreen extends StatefulWidget {

  const RegionalBoardOfDirectorsScreen();

  @override
  _RegionalBoardOfDirectorsScreen createState() => _RegionalBoardOfDirectorsScreen();
}

class _RegionalBoardOfDirectorsScreen extends State<RegionalBoardOfDirectorsScreen> {

  final List<RegionalBOD> _boardOfDirector = [
    RegionalBOD(
      name: 'Ahmad Jauhari',
      imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi-DPW-Sumatera_Ahmad-Jauhari.png',
      company: 'Maccahma',
      position: 'DPW Sumatera',
      positionTranslate: 'Regional Coordinator of Sumatera',
      subordinate: [
        RegionalBOD(
          name: 'Teuku Ali Devi',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPD-Aceh_Teuku-Ali-Devi.png',
          company: 'SPI',
          position: 'DPD Aceh',
          positionTranslate: 'Regional Coordinator of Aceh',
          subordinate: [],
        ),
        RegionalBOD(
          name: 'Capt. Awaluddin',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPD-Kepulauan-Riau-Batam_Capt.-Awaluddin.png',
          company: 'PelKepri',
          position: 'DPD Kepri & Batam',
          positionTranslate: 'Regional Coordinator of Kepri & Batam',
          subordinate: [],
        ),
        RegionalBOD(
          name: 'F. Saragih',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPD-Sumatera-Selatan_F.-Saragih.png',
          company: 'PIT',
          position: 'DPD Sumatera Selatan',
          positionTranslate: 'Regional Coordinator of South Sumatera',
          subordinate: [],
        ),
        RegionalBOD(
          name: 'Susmartono',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPD-Lampung_Susmartono.png',
          company: 'SLUP',
          position: 'DPD Lampung',
          positionTranslate: 'Regional Coordinator of Lampung',
          subordinate: [],
        ),
      ],
    ),
    RegionalBOD(
      name: 'Aep Dedi Laksana',
      imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPW-Jawa-Bali-Nusa-Tenggara_Aep-Dedi-Laksana.png',
      company: 'KBS',
      position: 'DPW Jawa, Bali, & Nusa Tenggara',
      positionTranslate: 'Regional Coordinator of Jawa, Bali, & Nusa Tenggara',
      subordinate: [
        RegionalBOD(
          name: 'Mohamad Rondhi',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPD-Jawa-Tengah_Mohamad-Rondhi.png',
          company: 'ATU',
          position: 'DPD Jawa Tengah',
          positionTranslate: 'Regional Coordinator of Jawa Tengah',
          subordinate: [],
        ),
        RegionalBOD(
          name: 'Eko Didik Harnoko',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPD-Banten_Eko-Didik-Harnoko.png',
          company: 'PCM',
          position: 'DPD Banten',
          positionTranslate: 'Regional Coordinator of Banten',
          subordinate: [],
        ),
        RegionalBOD(
          name: 'Eky Kurniawan',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPD-DKI-Jakarta-Jawa-Barat_Eky-Kurniawan.png',
          position: 'DPD Daerah Khusus Jakarta & Jawa Barat',
          positionTranslate: 'Regional Coordinator of Special Region of Jakarta & West Java',
          subordinate: [],
        ),
        RegionalBOD(
          name: 'Marianus Oei',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPD-Jawa-Timur_Marianus-Oei.png',
          company: 'SMP',
          position: 'DPD Jawa Timur',
          positionTranslate: 'Regional Coordinator of Jawa Timur',
          subordinate: [],
        ),
        RegionalBOD(
          name: 'Sudarta',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPC-Lembar_Sudarta.png',
          company: 'PLS',
          position: 'DPD Lembar',
          positionTranslate: 'Regional Coordinator of Lembar',
          subordinate: [],
        ),
      ],
    ),
    RegionalBOD(
      name: 'Nurcahyo Adi Putranto',
      imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPW-Kalimantan_Nurcahyo-Adi-Putranto.png',
      company: 'TIA',
      position: 'DPW Kalimantan',
      positionTranslate: 'Regional Coordinator of Kalimantan',
      subordinate: [
        RegionalBOD(
          name: 'Ahmad Zabidi',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPD-Kalimantan-Tengah_Ahmad-Zabidi.png',
          company: 'AMS',
          position: 'DPD Kalimantan Tengah',
          positionTranslate: 'Regional Coordinator of Kalimantan Tengah',
          subordinate: [],
        ),
        RegionalBOD(
          name: 'Kamaruddin Abtami',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPD-Kalimantan-Timur_Kamaruddin-Abtami.png',
          company: 'PTB',
          position: 'DPD Kalimantan Timur',
          positionTranslate: 'Regional Coordinator of Kalimantan Timur',
          subordinate: [],
        ),
        RegionalBOD(
          name: 'Slamet Riyadi',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPC-Tanjung-Redeb_Slamet-Riyadi.png',
          company: 'GAN',
          position: 'DPC Tj. Redeb',
          positionTranslate: 'Regional Coordinator of Tj. Redeb',
          subordinate: [],
        ),
        RegionalBOD(
          name: 'Rinaldy Perdana',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPC-Balikpapan_Rinaldy-Perdana.png',
          company: 'HNJ',
          position: 'DPC Balikpapan',
          positionTranslate: 'Regional Coordinator of Balikpapan',
          subordinate: [],
        ),
      ],
    ),
    RegionalBOD(
      name: 'Salman Dianda Anwar',
      imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPW-Sulawesi_Salman-Dianda-Anwar.png',
      company: 'BBI',
      position: 'DPW Sulawesi',
      positionTranslate: 'Regional Coordinator of Sulawesi',
      subordinate: [
        RegionalBOD(
          name: 'Agung Wibisono',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPD-Sulawesi-Selatan_Agung-Wibisono.png',
          company: 'BBI',
          position: 'DPD Sulawesi Selatan',
          positionTranslate: 'Regional Coordinator of Sulawesi Selatan',
          subordinate: [],
        ),
        RegionalBOD(
          name: 'Felix Febrian',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPD-Sulawesi-Tenggara_Felix-Febrian.png',
          company: 'APN',
          position: 'DPD Sulawesi Tenggara',
          positionTranslate: 'Regional Coordinator of Sulawesi Tenggara',
          subordinate: [],
        ),
        RegionalBOD(
          name: 'Mohamad Guruh',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPC-Kendari_Mohamad-Guruh.png',
          company: 'APN',
          position: 'DPD Kendari',
          positionTranslate: 'Regional Coordinator of Kendari',
          subordinate: [],
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _showSubordinateBottomSheet(BuildContext context, RegionalBOD director) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
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
                    director.position,
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
                  child: ListView.separated(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: director.subordinate.length,
                    separatorBuilder: (context, index) =>
                      Divider(height: 24, color: Colors.grey.shade400),
                    itemBuilder: (context, index) {
                      final subordinate = director.subordinate[index];
                      return _buildSubordinateRow(subordinate);
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

  Widget _buildSubordinateRow(RegionalBOD subordinate) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
            image: subordinate.imageURL != null
                ? DecorationImage(
              image: NetworkImage(subordinate.imageURL!),
              fit: BoxFit.cover,
            )
                : null,
          ),
          child: subordinate.imageURL == null
              ? const Icon(Icons.person, color: Colors.grey, size: 32)
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subordinate.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subordinate.company != null || (subordinate.company?.isNotEmpty ?? false)
                    ? '${subordinate.position} (${subordinate.company})'
                    : subordinate.position,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      // indent: 60,
      color: Color.fromRGBO(145, 179, 236, 1.0),
    );
  }

  Widget _buildDirectorCard({
    required String name,
    required String position,
    required String imageURL,
    bool isExpandable = false,
    VoidCallback? onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(2), // Border width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [
            Colors.lightBlue,
            Colors.blue,
            Colors.indigo,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.4),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (imageURL.isNotEmpty) ...[
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(imageURL),
                  ),
                ],
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDivider(context),
                      const SizedBox(height: 8),
                      Text(
                        position,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isExpandable)
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey.shade400,
                    size: 32,
                  ),
              ],
            ),
          ),
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
          l10n?.regionalCoordinator ?? 'Koordinator Wilayah',
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
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _boardOfDirector.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final director = _boardOfDirector[index];
            return _buildDirectorCard(
              name: director.name,
              position: director.position,
              imageURL: director.imageURL ?? '',
              isExpandable: director.subordinate.isNotEmpty,
              onTap: director.subordinate.isNotEmpty
                  ? () => _showSubordinateBottomSheet(context, director)
                  : null,
            );
          },
        ),
      ),
    );
  }
}
