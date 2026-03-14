import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/models/bod.dart';
import 'package:flutter/material.dart';

class BoardOfDirectorsScreen extends StatefulWidget {

  const BoardOfDirectorsScreen();

  @override
  _BoardOfDirectorsScreen createState() => _BoardOfDirectorsScreen();
}

class _BoardOfDirectorsScreen extends State<BoardOfDirectorsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<BoardOfDirector> _chairperson = [
    BoardOfDirector(name: 'Liana Trisnawati', position: 'KETUA UMUM', positionTranslate: 'CHAIRMAN', subordinate: []),
  ];

  final List<BoardOfDirector> _generalSecretary = [
    BoardOfDirector(
      name: 'Okke Permadhi',
      position: 'SEKRETARIS UMUM',
      positionTranslate: 'GENERAL SECRETARY',
      subordinate: [
        Subordinate(
          name: 'Devina',
          position: 'WAKIL SEKERTARIS UMUM',
          positionTranslate: 'VICE GENERAL SECRETARY',
          section: '',
          sectionTranslate: '',
          company: 'MSK',
        ),
        Subordinate(
          name: 'Adinda R. D. M.',
          position: 'HUMAS',
          positionTranslate: 'PUBLIC RELATIONS',
          section: '',
          sectionTranslate: '',
          company: 'CCP',
        ),
      ],
    ),
    BoardOfDirector(
      name: 'Adinda R. D. M.',
      position: 'HUMAS',
      positionTranslate: 'PUBLIC RELATIONS',
      subordinate: [
        Subordinate(
          name: 'Hendy Lubis',
          position: 'ABUPI GOLF',
          positionTranslate: 'ABUPI GOLF',
          section: '',
          sectionTranslate: '',
        ),
      ],
    ),
  ];

  final List<BoardOfDirector> _generalTreasurer = [
    BoardOfDirector(
      name: 'Hikmatul Laila',
      position: 'BENDAHARA UMUM',
      positionTranslate: 'GENERAL TREASURER',
      subordinate: [
        Subordinate(
          name: 'Imay Dyna Redra',
          position: 'WAKIL BENDAHARA UMUM',
          positionTranslate: 'VICE GENERAL TREASURER',
          section: '',
          sectionTranslate: '',
          company: 'EJP',
        ),
      ],
    ),
    BoardOfDirector(
      name: 'Imay Dyna Redra',
      position: 'WAKIL BENDAHARA UMUM',
      positionTranslate: 'VICE GENERAL TREASURER',
      subordinate: [
        Subordinate(
          name: 'Tony Wijaya',
          position: 'ABUPI CSR',
          positionTranslate: 'ABUPI CSR',
          section: '',
          sectionTranslate: '',
          company: 'PCNI',
        ),
      ],
    ),
  ];

  final List<BoardOfDirector> _viceChairperson = [
    BoardOfDirector(
      name: 'Ariyanto Purboyo',
      position: 'WAKIL KETUA UMUM I',
      positionTranslate: 'VICE CHAIRMAN I',
      section: 'BIDANG AKSELERASI KEBIJAKAN & BISNIS DEVELOPMENT',
      sectionTranslate: 'BUSINESS DEVELOPMENT & POLICY ACCELERATION',
      subordinate: [
        Subordinate(
          name: 'Widagdo Pradono Siwi',
          position: 'Kepala Bidang 1',
          positionTranslate: 'Head of Division 1',
          section: 'Aksesibilitas Perizinan',
          sectionTranslate: 'PERMISSION ACCESSIBILITY',
          company: 'Ter. Anugerah Indonesia',
        ),
        Subordinate(
          name: 'M. Arif Widyoadi',
          position: 'Kepala Bidang 2',
          positionTranslate: 'Head of Division 2',
          section: 'Standarisasi Supply Chain dan Tarif Kepelabuhan',
          sectionTranslate: 'Standardization of Supply Chain and Port Tariff',
          company: 'Samudera Port',
        ),
        Subordinate(
          name: 'Priyonggo Sidharta',
          position: 'Kepala Bidang 3',
          positionTranslate: 'Head of Division 3',
          section: 'Akses Permodalan & Investasi',
          sectionTranslate: 'Access to Capital & Investment',
          company: 'BLS',
        ),
        Subordinate(
          name: 'Imamudin Qusyairi',
          position: 'Kepala Bidang 4',
          positionTranslate: 'Head of Division 4',
          section: 'Pengawasan Perizinan, Konsesi, dan Kerjasama Bentuk Lainnya',
          sectionTranslate: 'Supervision of Permits, Concessions, and Other Forms of Cooperation',
          company: 'SMP',
        ),
      ],
    ),
    BoardOfDirector(
      name: 'Muhammad Willy',
      position: 'WAKIL KETUA UMUM II',
      positionTranslate: 'VICE CHAIRMAN II',
      section: 'BIDANG PENGEMBANGAN ANGGOTA',
      sectionTranslate: 'DEVELOPMENT OF MEMBERS',
      subordinate: [
        Subordinate(
          name: 'Harry Buana Putra',
          position: 'Kepala Bidang 5',
          positionTranslate: 'Head of Division 5',
          section: 'Kolaborasi & Kemitraan',
          sectionTranslate: 'Collaboration & Partnership',
          company: 'LLL',
        ),
        Subordinate(
          name: 'Rusmin Abdulgani',
          position: 'Kepala Bidang 6',
          positionTranslate: 'Head of Division 6',
          section: 'Sinergi Antar Pemangku Kepentingan',
          sectionTranslate: 'Inter-Stakeholder Synergy',
          company: 'Triple Eight',
        ),
        Subordinate(
          name: 'Yuni Elvina',
          position: 'Kepala Bidang 6',
          positionTranslate: 'Head of Division 6',
          section: 'Sinergi Antar Pemangku Kepentingan',
          sectionTranslate: 'Inter-Stakeholder Synergy',
          company: 'PBR',
        ),
        Subordinate(
          name: 'Christianne Kezia Lydia',
          position: 'Kepala Bidang 7',
          positionTranslate: 'Head of Division 7',
          section: 'Kerjasama Internasional',
          sectionTranslate: 'International Cooperation',
          company: 'BKN',
        ),
        Subordinate(
          name: 'Indah Nugrohowati',
          position: 'Kepala Bidang 7',
          positionTranslate: 'Head of Division 7',
          section: 'Kerjasama Internasional',
          sectionTranslate: 'International Cooperation',
          company: 'TTI',
        ),
        Subordinate(
          name: 'Aghnia Nadhira',
          position: 'Kepala Bidang 7',
          positionTranslate: 'Head of Division 7',
          section: 'Kerjasama Internasional',
          sectionTranslate: 'International Cooperation',
        ),
      ],
    ),
    BoardOfDirector(
      name: 'Sakiman',
      position: 'WAKIL KETUA UMUM III',
      positionTranslate: 'VICE CHAIRMAN III',
      section: 'BIDANG PENGAMBANGAN SUMBER DAYA MANUSIA (SDM)',
      sectionTranslate: 'HUMAN RESOURCE DEVELOPMENT (HRD)',
      subordinate: [
        Subordinate(
            name: 'Rosita Septiani',
            position: 'Kepala Bidang 8',
            positionTranslate: 'Head of Division 8',
            section: 'Peningkatan Kompetensi SDM',
            sectionTranslate: 'Competency Development',
            company: 'Maccahma'
        ),
        Subordinate(
            name: 'Abdulloh',
            position: 'Kepala Bidang 9',
            positionTranslate: 'Head of Division 9',
            section: 'Program Magang dan Pendampingan',
            sectionTranslate: 'Internship & Mentoring Program',
            company: 'KBS'
        ),
        Subordinate(
            name: 'Sadana Murti Nugroho',
            position: 'Kepala Bidang 9',
            positionTranslate: 'Head of Division 9',
            section: 'Program Magang dan Pendampingan',
            sectionTranslate: 'Internship & Mentoring Program',
            company: 'KBS'
        ),
        Subordinate(
            name: 'Pandu Dewantara',
            position: 'Kepala Bidang 10',
            positionTranslate: 'Head of Division 10',
            section: 'Pelatihan Soft Skill',
            sectionTranslate: 'Soft Skill Training',
            company: 'TIS'
        ),
        Subordinate(
          name: 'Azis Muttaqien',
          position: 'Kepala Bidang 11',
          positionTranslate: 'Head of Division 11',
          section: 'Sertifikasi Standar Global Kepelabuhan',
          sectionTranslate: 'Global Standard Certification',
          company: 'SLUP',
        ),
        Subordinate(
          name: 'Andri Yansyah',
          position: 'Kepala Bidang 11',
          positionTranslate: 'Head of Division 11',
          section: 'Sertifikasi Standar Global Kepelabuhan',
          sectionTranslate: 'Global Standard Certification',
          company: 'LLL',
        ),
      ],
    ),
    BoardOfDirector(
      name: 'Adi Darma Shima',
      position: 'WAKIL KETUA UMUM IV',
      positionTranslate: 'VICE CHAIRMAN IV',
      section: 'BIDANG PENINGKATAN & PENGEMBANGAN DAYA SAING PELABUHAN',
      sectionTranslate: 'PORT COMPETITIVENESS & INNOVATION DEVELOPMENT',
      subordinate: [
        Subordinate(
          name: 'Jalmo Jagat',
          position: 'Kepala Bidang 12',
          positionTranslate: 'Head of Division 12',
          section: 'Standarisasi Keamanan Pelabuhan (ISPS Code)',
          sectionTranslate: 'Standardization of Port Security (ISPS Code)',
          company: 'SCN',
        ),
        Subordinate(
          name: 'Dhany Yudha',
          position: 'Kepala Bidang 13',
          positionTranslate: 'Head of Division 13',
          section: 'Kabid Integrasi System Port to Port',
          sectionTranslate: 'Integration of Port to Port System',
          company: 'Samudera Port',
        ),
        Subordinate(
          name: 'Ashari Trisna',
          position: 'Kepala Bidang 14',
          positionTranslate: 'Head of Division 14',
          section: 'Inovasi Teknonolog Masa Depan',
          sectionTranslate: 'Future Technology Innovation',
          company: 'KBS',
        ),
        Subordinate(
          name: 'Wien Goerindro',
          position: 'Kepala Bidang 15',
          positionTranslate: 'Head of Division 15',
          section: 'Standarisasi Alat & Sistem Pelayanan',
          sectionTranslate: 'Standardization of Equipment & Service Systems',
          company: 'ILSS',
        ),
        Subordinate(
          name: 'Tri Andika Syam',
          position: 'Kepala Bidang 16',
          positionTranslate: 'Head of Division 16',
          section: 'Promotion & Branding (BUP)',
          sectionTranslate: 'Promotion & Branding (BUP)',
          company: 'AGP',
        ),
      ],
    ),
    BoardOfDirector(
      name: 'Iwan Wiranto',
      position: 'WAKIL KETUA UMUM V',
      positionTranslate: 'VICE CHAIRMAN V',
      section: 'BIDANG KEBERLANJUTAN PELABUHAN & INDUSTRI MANUFAKTUR',
      sectionTranslate: 'SUSTAINABILITY & MANUFACTURING INDUSTRY',
      subordinate: [
        Subordinate(
          name: 'Sony Sidjaja',
          position: 'Kepala Bidang 17',
          positionTranslate: 'Head of Division 17',
          section: 'Investasi Keberlanjutan',
          sectionTranslate: 'Sustainability Investment',
          company: 'IMPT',
        ),
        Subordinate(
          name: 'Joko Widatmoko',
          position: 'Kepala Bidang 17',
          positionTranslate: 'Head of Division 17',
          section: 'Investasi Keberlanjutan',
          sectionTranslate: 'Sustainability Investment',
          company: 'BBI',
        ),
        Subordinate(
          name: 'Donny Adolf',
          position: 'Kepala Bidang 18',
          positionTranslate: 'Head of Division 18',
          section: 'Komitmen Keberlanjutan BUP',
          sectionTranslate: 'Commitment to BUP Sustainability',
          company: 'CCP',
        ),
        Subordinate(
          name: 'Ilvy Wiliyanti',
          position: 'Kepala Bidang 18',
          positionTranslate: 'Head of Division 18',
          section: 'Komitmen Keberlanjutan BUP',
          sectionTranslate: 'Commitment to BUP Sustainability',
          company: 'CPN',
        ),
      ],
    ),
  ];

  final List<BoardOfDirector> _advisory = [
    BoardOfDirector(
      name: 'Carmelita Hartoto',
      position: 'Dewan Penasehat',
      positionTranslate: 'Advisory Board',
      subordinate: [],
    ),
    BoardOfDirector(
      name: 'M. Akbar Djohan',
      position: 'Dewan Penasehat',
      positionTranslate: 'Advisory Board',
      subordinate: [],
    ),
  ];

  final List<BoardOfDirector> _supervisory = [
    BoardOfDirector(
      name: 'Aulia Febrial Fatwa (PMN)',
      position: 'Dewan Pembina',
      positionTranslate: 'Supervisory Board',
      subordinate: [],
    ),
    BoardOfDirector(
      name: 'Ayi Paryana (MSK)',
      position: 'Dewan Pembina',
      positionTranslate: 'Supervisory Board',
      subordinate: [],
    ),
    BoardOfDirector(
      name: 'David Rahadian (GE)',
      position: 'Dewan Pembina',
      positionTranslate: 'Supervisory Board',
      subordinate: [],
    ),
    BoardOfDirector(
      name: 'Edi Rivai (CAP)',
      position: 'Dewan Pembina',
      positionTranslate: 'Supervisory Board',
      subordinate: [],
    ),
    BoardOfDirector(
      name: 'Mindo Herbert Sitorus (PRK)',
      position: 'Dewan Pembina',
      positionTranslate: 'Supervisory Board',
      subordinate: [],
    ),
  ];

  final List<BoardOfDirector> _exprtise = [
    BoardOfDirector(
      name: 'Bay Mokhamad Hasani',
      position: 'KEPELABUHANAN',
      positionTranslate: 'MARITIME',
      subordinate: [],
    ),
    BoardOfDirector(
      name: 'Pasoroan Herman Harianja',
      position: 'KEPELABUHANAN',
      positionTranslate: 'MARITIME',
      subordinate: [],
    ),
    BoardOfDirector(
      name: 'Prof. Saut Gurning',
      position: 'Logistik & Rantai Pasok',
      positionTranslate: 'Logistics & Supply Chain',
      subordinate: [],
    ),
    BoardOfDirector(
      name: 'Dr. Nofrisel, SE, MM.',
      position: 'Logistik & Rantai Pasok',
      positionTranslate: 'Logistics & Supply Chain',
      subordinate: [],
    ),
    BoardOfDirector(
      name: 'Capt. Alioth Willem Belseran, MM, M.Mar',
      position: 'Hukum & Kelembagaan',
      positionTranslate: 'Legal & Governance',
      subordinate: [],
    ),
    BoardOfDirector(
      name: 'Neneng Sofiati',
      position: 'Hukum & Kelembagaan',
      positionTranslate: 'Legal & Governance',
      subordinate: [],
    ),
    BoardOfDirector(
      name: 'Dr. Gugus Wijonarko, MM',
      position: 'Sumber Daya Manusia',
      positionTranslate: 'Human Resources',
      subordinate: [],
    ),
    BoardOfDirector(
      name: 'Dr. Lucky Bayu Purnomo',
      position: 'Keuangan & Investasi',
      positionTranslate: 'Finance & Investment',
      subordinate: [],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showSubordinateBottomSheet(BuildContext context, BoardOfDirector director) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final l10n = AppLocalizations.of(context);
        final language = l10n?.language;
        final section = language == 'id' ? director.section : director.sectionTranslate;
        final position = language == 'id' ? director.position : director.positionTranslate;

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
                    section ?? position,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(145, 179, 236, 1.0),
                    ),
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: director.subordinate.length,
                    separatorBuilder: (context, index) => const Divider(height: 24),
                    itemBuilder: (context, index) {
                      final subordinate = director.subordinate[index];
                      return _buildSubordinateRow(context, subordinate);
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

  Widget _buildSubordinateRow(BuildContext context, Subordinate subordinate) {
    final l10n = AppLocalizations.of(context);
    final language = l10n?.language;
    final position = language == 'id' ? subordinate.position : subordinate.positionTranslate;

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
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subordinate.company != null
                    ? '${position} (${subordinate.company})'
                    : position,
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
      color: Color.fromRGBO(145, 179, 236, 1.0),
    );
  }

  Widget _buildDirectorCard({
    required String name,
    required String position,
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
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
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
                      ),
                    ),
                  ],
                ),
              ),
              if (isExpandable)
                const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
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
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.organizationStructure ?? 'Struktur Organisasi',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          padding: EdgeInsets.zero,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          tabs: [
            Tab(text: l10n?.boardOfDirectors ?? 'Dewan Pengurus'),
            Tab(text: l10n?.advisoryBoard ?? 'Dewan Penasihat'),
            Tab(text: l10n?.supervisoryBoard ?? 'Dewan Pembina'),
            Tab(text: l10n?.expertAdvisoryBoard ?? 'Dewan Pakar'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBODGeneral(context),
          _buildAdvisoryBoard(context),
          _buildSupervisoryBoard(context),
          _buildExpertAdvisoryBoard(context),
        ],
      ),
    );
  }

  Widget _buildBODGeneral(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final language = l10n?.language;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            l10n?.generalChairman ?? 'Ketua Umum',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _chairperson.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final director = _chairperson[index];
              return _buildDirectorCard(
                name: director.name,
                position: language == 'id' ?
                  director.position :
                  director.positionTranslate,
                isExpandable: director.subordinate.isNotEmpty,
                onTap: director.subordinate.isNotEmpty
                    ? () => _showSubordinateBottomSheet(context, director)
                    : null,
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            l10n?.generalSecretary ?? 'Sekretaris Umum',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _generalSecretary.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final director = _generalSecretary[index];
              return _buildDirectorCard(
                name: director.name,
                position: language == 'id' ? director.position : director.positionTranslate,
                isExpandable: director.subordinate.isNotEmpty,
                onTap: director.subordinate.isNotEmpty
                    ? () => _showSubordinateBottomSheet(context, director)
                    : null,
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            l10n?.generalSecretary ?? 'Bendahara Umum',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _generalTreasurer.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final director = _generalTreasurer[index];
              return _buildDirectorCard(
                name: director.name,
                position: language == 'id' ? director.position : director.positionTranslate,
                isExpandable: director.subordinate.isNotEmpty,
                onTap: director.subordinate.isNotEmpty
                    ? () => _showSubordinateBottomSheet(context, director)
                    : null,
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            l10n?.viceChairman ?? 'Wakil Ketua Umum',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _viceChairperson.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final director = _viceChairperson[index];
              return _buildDirectorCard(
                name: director.name,
                position: language == 'id' ? director.position : director.positionTranslate,
                isExpandable: director.subordinate.isNotEmpty,
                onTap: director.subordinate.isNotEmpty
                    ? () => _showSubordinateBottomSheet(context, director)
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdvisoryBoard(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final language = l10n?.language;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _advisory.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final director = _advisory[index];
          return _buildDirectorCard(
            name: director.name,
            position: language == 'id' ? director.position : director.positionTranslate,
            isExpandable: director.subordinate.isNotEmpty,
            onTap: director.subordinate.isNotEmpty
                ? () => _showSubordinateBottomSheet(context, director)
                : null,
          );
        },
      ),
    );
  }

  Widget _buildSupervisoryBoard(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final language = l10n?.language;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _supervisory.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final director = _supervisory[index];
          return _buildDirectorCard(
            name: director.name,
            position: language == 'id' ? director.position : director.positionTranslate,
            isExpandable: director.subordinate.isNotEmpty,
            onTap: director.subordinate.isNotEmpty
                ? () => _showSubordinateBottomSheet(context, director)
                : null,
          );
        },
      ),
    );
  }

  Widget _buildExpertAdvisoryBoard(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final language = l10n?.language;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _exprtise.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final director = _exprtise[index];
          return _buildDirectorCard(
            name: director.name,
            position: language == 'id' ? director.position : director.positionTranslate,
            isExpandable: director.subordinate.isNotEmpty,
            onTap: director.subordinate.isNotEmpty
                ? () => _showSubordinateBottomSheet(context, director)
                : null,
          );
        },
      ),
    );
  }
}
