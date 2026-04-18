import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/models/bod.dart';
import 'package:abupi/models/regional_bod.dart';
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
    BoardOfDirector(
      name: 'Liana Trisnawati',
      position: 'KETUA UMUM',
      positionTranslate: 'CHAIRMAN',
      subordinate: [],
      imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Stuktur-Organisasi_Ketua-Umum_Liana-Trisnawati.png',
    ),
  ];

  final List<BoardOfDirector> _generalSecretary = [
    BoardOfDirector(
      name: 'Okke Permadhi',
      imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Sekretaris-Umum_Okke-Permadi.png',
      position: 'SEKRETARIS UMUM',
      positionTranslate: 'GENERAL SECRETARY',
      subordinate: [
        Subordinate(
          name: 'WAKIL SEKRETARIS UMUM',
          position: 'WAKIL SEKRETARIS UMUM',
          positionTranslate: 'VICE GENERAL SECRETARY',
          section: '',
          sectionTranslate: '',
          company: 'MSK',
        ),
      ],
    ),
  ];

  final List<BoardOfDirector> _generalTreasurer = [
    BoardOfDirector(
      name: 'Hikmatul Laila',
      position: 'BENDAHARA UMUM',
      positionTranslate: 'GENERAL TREASURER',
      imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Bendahara-Umum_Hikmatul-Laila.png',
      subordinate: [
        Subordinate(
          name: 'WAKIL BENDAHARA UMUM',
          position: 'WAKIL BENDAHARA UMUM',
          positionTranslate: 'VICE GENERAL TREASURER',
          section: '',
          sectionTranslate: '',
          company: 'EJP',
        ),
      ],
    ),
  ];

  final List<BoardOfDirector> _viceChairperson = [
    BoardOfDirector(
      name: 'Ariyanto Purboyo (STT)',
      imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_WKU-I_Ariyanto-Purboyo.png',
      position: 'WAKIL KETUA UMUM I',
      positionTranslate: 'VICE CHAIRMAN I',
      section: 'Bidang Akselerasi Kebijakan & Peraturan, Rantai Pasok & Biz. Dvlp.',
      sectionTranslate: 'Policy & Regulatory Acceleration, Supply Chain & Biz. Dvlp.',
      subordinate: [
        Subordinate(
          name: 'Widagdo Pradono Siwi',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-1_Widagdo-Pradono-Siwi.png',
          position: 'Kepala Bidang I',
          positionTranslate: 'Head of Division I',
          section: 'Aksesibilitas Perizinan',
          sectionTranslate: 'PERMISSION ACCESSIBILITY',
          company: 'Ter. Anugerah Indonesia',
        ),
        Subordinate(
          name: 'Dody Rachmady',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Wakil-Kepala-Bidang-1_Dody-Rachmady.png',
          position: 'Kepala Bidang I',
          positionTranslate: 'Head of Division I',
          section: 'Aksesibilitas Perizinan',
          sectionTranslate: 'PERMISSION ACCESSIBILITY',
          company: 'Ter. Anugerah Indonesia',
        ),
        Subordinate(
          name: 'M. Arif Widyoadi',
          position: 'Kepala Bidang II',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-2_M.-Arif-Widyoadi.png',
          positionTranslate: 'Head of Division II',
          section: 'Standarisasi Supply Chain dan Tarif Kepelabuhan',
          sectionTranslate: 'Standardization of Supply Chain and Port Tariff',
          company: 'Samudera Port',
        ),
        Subordinate(
          name: 'Pryonggo Sidharta',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-3_Pryonggo-Sidharta.png',
          position: 'Kepala Bidang III',
          positionTranslate: 'Head of Division III',
          section: 'Akses Permodalan & Investasi',
          sectionTranslate: 'Access to Capital & Investment',
          company: 'BLS',
        ),
        Subordinate(
          name: 'Gregorius Riyan',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Wakil-Kepala-Bidang-3_Gregorius-Riyan.png',
          position: 'Kepala Bidang III',
          positionTranslate: 'Head of Division III',
          section: 'Akses Permodalan & Investasi',
          sectionTranslate: 'Access to Capital & Investment',
          company: 'BLS',
        ),
        Subordinate(
          name: 'Imamudin Qusyairi',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-4_Imamudin-Qusyairi.png',
          position: 'Kepala Bidang IV',
          positionTranslate: 'Head of Division IV',
          section: 'Pengawasan Perizinan, Konsesi, dan Kerjasama Bentuk Lainnya',
          sectionTranslate: 'Supervision of Permits, Concessions, and Other Forms of Cooperation',
          company: 'SMP',
        ),
      ],
    ),
    BoardOfDirector(
      name: 'Muhammad Willy (PCM)',
      imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_WKU-II_Muhammad-Willy.png',
      position: 'WAKIL KETUA UMUM II',
      positionTranslate: 'VICE CHAIRMAN II',
      section: 'BIDANG PENGEMBANGAN ANGGOTA',
      sectionTranslate: 'DEVELOPMENT OF MEMBERS',
      subordinate: [
        Subordinate(
          name: 'Harry Buana Putra',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-5_Harry-Buana-Putra.png',
          position: 'Kepala Bidang V',
          positionTranslate: 'Head of Division V',
          section: 'Kolaborasi & Kemitraan',
          sectionTranslate: 'Collaboration & Partnership',
          company: 'LLL',
        ),
        Subordinate(
          name: 'Rusmin Abdulgani',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-6_Rusmin-Abdulgani.png',
          position: 'Kepala Bidang VI',
          positionTranslate: 'Head of Division VI',
          section: 'Sinergi Antar Pemangku Kepentingan',
          sectionTranslate: 'Inter-Stakeholder Synergy',
          company: 'Triple Eight',
        ),
        Subordinate(
          name: 'Yuni Elvina',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Wakil-Kepala-Bidang-6_Yuni-Elvina.png',
          position: 'Kepala Bidang VI',
          positionTranslate: 'Head of Division VI',
          section: 'Sinergi Antar Pemangku Kepentingan',
          sectionTranslate: 'Inter-Stakeholder Synergy',
          company: 'PBR',
        ),
        Subordinate(
          name: 'Christianne Kezia Lydia',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-7_Christianne-Kezia-Lydia.png',
          position: 'kepala bidang VII',
          positionTranslate: 'Head of Division VII',
          section: 'Kerjasama Internasional',
          sectionTranslate: 'International Cooperation',
          company: 'BKN',
        ),
        Subordinate(
          name: 'Indah Nugrohowati',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Wakil-Kepala-Bidang-7_Indah-Nugrohowati.png',
          position: 'kepala bidang VII',
          positionTranslate: 'Head of Division VII',
          section: 'Kerjasama Internasional',
          sectionTranslate: 'International Cooperation',
          company: 'TTI',
        ),
        Subordinate(
          name: 'Aghnia Nadhira',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Wakil-Kepala-Bidang-7_Aghnia-Nadhira.png',
          position: 'kepala bidang VII',
          positionTranslate: 'Head of Division VII',
          section: 'Kerjasama Internasional',
          sectionTranslate: 'International Cooperation',
        ),
        Subordinate(
          name: 'Tony Wijaya',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_ABUPI-Peduli-CSR_Tony-Wijaya.png',
          position: 'ABUPI Peduli',
          positionTranslate: 'ABUPI Care',
          section: '',
          sectionTranslate: '',
        ),
        Subordinate(
          name: 'Hendy Lubis',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_ABUPI-Golf_Hendy-Lubis.png',
          position: 'ABUPI Golf',
          positionTranslate: 'ABUPI Golf',
          section: '',
          sectionTranslate: '',
        ),
      ],
    ),
    BoardOfDirector(
      name: 'Sakiman (APN)',
      imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_WKU-III_Sakiman.png',
      position: 'WAKIL KETUA UMUM III',
      positionTranslate: 'VICE CHAIRMAN III',
      section: 'BIDANG PENGAMBANGAN SUMBER DAYA MANUSIA (SDM)',
      sectionTranslate: 'HUMAN RESOURCE DEVELOPMENT (HRD)',
      subordinate: [
        Subordinate(
            name: 'Rosita Septiani',
            imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-8_Rosita-Septiani.png',
            position: 'Kepala Bidang VIII',
            positionTranslate: 'Head of Division VIII',
            section: 'Peningkatan Kompetensi SDM',
            sectionTranslate: 'Competency Development',
            company: 'Maccahma'
        ),
        Subordinate(
            name: 'Abdulloh',
            imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-9_Abdulloh.png',
            position: 'Kepala Bidang IX',
            positionTranslate: 'Head of Division IX',
            section: 'Program Magang dan Pendampingan',
            sectionTranslate: 'Internship & Mentoring Program',
            company: 'KBS'
        ),
        Subordinate(
            name: 'Sadana Murti Nugroho',
            imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Wakil-Kepala-Bidang-9_Sadana-Murti-Nugroho.png',
            position: 'Kepala Bidang IX',
            positionTranslate: 'Head of Division IX',
            section: 'Program Magang dan Pendampingan',
            sectionTranslate: 'Internship & Mentoring Program',
            company: 'KBS'
        ),
        Subordinate(
            name: 'Pandu Dewantara',
            imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-10_Pandu-Dewantara.png',
            position: 'Kepala Bidang X',
            positionTranslate: 'Head of Division X',
            section: 'Pelatihan Soft Skill',
            sectionTranslate: 'Soft Skill Training',
            company: 'TIS'
        ),
        Subordinate(
          name: 'Azis Muttaqien',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-11_Azis-Muttaqien.png',
          position: 'Kepala Bidang XI',
          positionTranslate: 'Head of Division XI',
          section: 'Sertifikasi Standar Global Kepelabuhan',
          sectionTranslate: 'Global Standard Certification',
          company: 'SLUP',
        ),
        Subordinate(
          name: 'Andri Yansyah',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-11_Andri-Yansyah.png',
          position: 'Kepala Bidang XI',
          positionTranslate: 'Head of Division XI',
          section: 'Sertifikasi Standar Global Kepelabuhan',
          sectionTranslate: 'Global Standard Certification',
          company: 'LLL',
        ),
      ],
    ),
    BoardOfDirector(
      name: 'Adi Darma Shima (ILSS)',
      imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_WKU-IV_Adi-Darma-Shima.png',
      position: 'WAKIL KETUA UMUM IV',
      positionTranslate: 'VICE CHAIRMAN IV',
      section: 'BIDANG PENINGKATAN & PENGEMBANGAN DAYA SAING PELABUHAN',
      sectionTranslate: 'PORT COMPETITIVENESS & INNOVATION DEVELOPMENT',
      subordinate: [
        Subordinate(
          name: 'Kepala Bidang XII',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-12_Menunggu-PAW.png',
          position: 'Kepala Bidang XII',
          positionTranslate: 'Head of Division XII',
          section: 'Standarisasi Keamanan Pelabuhan (ISPS Code)',
          sectionTranslate: 'Standardization of Port Security (ISPS Code)',
          company: 'SCN',
        ),
        Subordinate(
          name: 'Dhany Yudha',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-13_Dhany-Yudha.png',
          position: 'Kepala Bidang XIII',
          positionTranslate: 'Head of Division XIII',
          section: 'Kabid Integrasi System Port to Port',
          sectionTranslate: 'Integration of Port to Port System',
          company: 'Samudera Port',
        ),
        Subordinate(
          name: 'Ashari Trisna',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-14_Ashari-Trisna.png',
          position: 'Kepala Bidang XIV',
          positionTranslate: 'Head of Division XIV',
          section: 'Inovasi Teknonolog Masa Depan',
          sectionTranslate: 'Future Technology Innovation',
          company: 'KBS',
        ),
        Subordinate(
          name: 'Wien Goerindro',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-15_Wien-Goerindro.png',
          position: 'Kepala Bidang XV',
          positionTranslate: 'Head of Division XV',
          section: 'Standarisasi Alat & Sistem Pelayanan',
          sectionTranslate: 'Standardization of Equipment & Service Systems',
          company: 'ILSS',
        ),
        Subordinate(
          name: 'Tri Andika Syam',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-16_Tri-Andika-Syam.png',
          position: 'Kepala Bidang XVI',
          positionTranslate: 'Head of Division XVI',
          section: 'Promotion & Branding (BUP)',
          sectionTranslate: 'Promotion & Branding (BUP)',
          company: 'AGP',
        ),
      ],
    ),
    BoardOfDirector(
      name: 'WAKIL KETUA UMUM V',
      imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_WKU-V_Agus-Salim.png',
      position: 'WAKIL KETUA UMUM V',
      positionTranslate: 'VICE CHAIRMAN V',
      section: 'BIDANG KEBERLANJUTAN PELABUHAN & INDUSTRI MANUFAKTUR',
      sectionTranslate: 'SUSTAINABILITY & MANUFACTURING INDUSTRY',
      subordinate: [
        Subordinate(
          name: 'Sony Sidjaja',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-17_Sonny-Sidjaja.png',
          position: 'Kepala Bidang XVII',
          positionTranslate: 'Head of Division XVII',
          section: 'Investasi Keberlanjutan',
          sectionTranslate: 'Sustainability Investment',
          company: 'IMPT',
        ),
        Subordinate(
          name: 'Joko Widatmoko',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Wakil-Kepala-Bidang-17_Joko-Widiatmoko.png',
          position: 'Kepala Bidang XVII',
          positionTranslate: 'Head of Division XVII',
          section: 'Investasi Keberlanjutan',
          sectionTranslate: 'Sustainability Investment',
          company: 'BBI',
        ),
        Subordinate(
          name: 'Donny Adolf',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-18_-Donny-Adolf.png',
          position: 'Kepala Bidang XVIII',
          positionTranslate: 'Head of Division XVIII',
          section: 'Komitmen Keberlanjutan BUP',
          sectionTranslate: 'Commitment to BUP Sustainability',
          company: 'CCP',
        ),
        Subordinate(
          name: 'Ilvy Wiliyanti',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Wakil-Kepala-Bidang-18_-Ilvy-Wiliyanti.png',
          position: 'Kepala Bidang XVIII',
          positionTranslate: 'Head of Division XVIII',
          section: 'Komitmen Keberlanjutan BUP',
          sectionTranslate: 'Commitment to BUP Sustainability',
          company: 'CPN',
        ),
        Subordinate(
          name: 'Adinda R.D.M',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Wakil-Kepala-Bidang-18_-Adinda-R.-D.-M.png',
          position: 'Kepala Bidang XVIII',
          positionTranslate: 'Head of Division XVIII',
          section: 'Komitmen Keberlanjutan BUP',
          sectionTranslate: 'Commitment to BUP Sustainability',
          company: '',
        ),
      ],
    ),
  ];

  final List<BoardOfDirector> _advisory = [
    BoardOfDirector(
      name: 'Carmelita Hartoto',
      imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Kepala-Bidang-12_Menunggu-PAW.png',
      position: 'Dewan Penasehat',
      positionTranslate: 'Advisory Board',
      subordinate: [],
    ),
    BoardOfDirector(
      name: 'M. Akbar Djohan',
      imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Dewan-Penasihat_M.-Akbar-Djohan.png',
      position: 'Dewan Penasehat',
      positionTranslate: 'Advisory Board',
      subordinate: [],
    ),
  ];

  final List<BoardOfDirector> _supervisory = [
    BoardOfDirector(
      name: 'Aulia Febrial Fatwa (PMN)',
      imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Ketua-Dewan-Pembina_Aulia-Febrial-Fatwa.png',
      position: 'Dewan Pembina',
      positionTranslate: 'Supervisory Board',
      subordinate: [],
    ),
    BoardOfDirector(
      name: 'Ayi Paryana (MSK)',
      imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Dewan-Pembina_Ayi-Paryana.png',
      position: 'Dewan Pembina',
      positionTranslate: 'Supervisory Board',
      subordinate: [],
    ),
    BoardOfDirector(
      name: 'David Rahadian (GE)',
      imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Dewan-Pembina_David-Rahadian.png',
      position: 'Dewan Pembina',
      positionTranslate: 'Supervisory Board',
      subordinate: [],
    ),
    BoardOfDirector(
      name: 'Edi Rivai (CAP)',
      imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Dewan-Pembina_Edi-Rivai.png',
      position: 'Dewan Pembina',
      positionTranslate: 'Supervisory Board',
      subordinate: [],
    ),
    BoardOfDirector(
      name: 'Mindo Herbert Sitorus (PRK)',
      imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Dewan-Pembina_Mindo-Herbert-Sitorus.png',
      position: 'Dewan Pembina',
      positionTranslate: 'Supervisory Board',
      subordinate: [],
    ),
  ];

  final List<BoardOfDirector> _exprtise = [
    BoardOfDirector(
      name: 'KEPELABUHANAN',
      position: 'KEPELABUHANAN',
      positionTranslate: 'MARITIME',
      subordinate: [
        Subordinate(
          name: 'Bay Mokhamad Hasani',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Dewan-Pakar-Kepelabuhanan_Bay-Mokhamad-Hasani.png',
          position: '',
          positionTranslate: '',
          section: '',
          sectionTranslate: '',
        ),
        Subordinate(
          name: 'Pasoroan Herman Harianja',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPC-Luwu-Timur_Ikal.png',
          position: '',
          positionTranslate: '',
          section: '',
          sectionTranslate: '',
        ),
      ],
    ),
    BoardOfDirector(
      name: 'Logistik & Rantai Pasok',
      position: 'Logistik & Rantai Pasok',
      positionTranslate: 'Logistics & Supply Chain',
      subordinate: [
        Subordinate(
          name: 'Prof. Saut Gurning',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Dewan-Pakar-Logistik-Rantai-Pasok_Saut-Gurning.png',
          position: '',
          positionTranslate: '',
          section: '',
          sectionTranslate: '',
        ),
        Subordinate(
          name: 'Dr. Nofrisel, SE, MM',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Dewan-Pakar-Logistik-Rantai-Pasok_Nofrisel.png',
          position: '',
          positionTranslate: '',
          section: '',
          sectionTranslate: '',
        ),
      ],
    ),
    BoardOfDirector(
      name: 'Hukum & Kelembagaan',
      position: 'Hukum & Kelembagaan',
      positionTranslate: 'Legal & Governance',
      subordinate: [
        Subordinate(
          name: 'Capt. Alioth Willem Belseran, MM, M.Mar',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Dewan-Pakar-Hukum-Kelembagaan_Capt.-Alioth-Willem-B.png',
          position: '',
          positionTranslate: '',
          section: '',
          sectionTranslate: '',
        ),
        Subordinate(
          name: 'Neneng Sofiati',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Dewan-Pakar-Hukum-Kelembagaan_Neneng-Sofiati.png',
          position: '',
          positionTranslate: '',
          section: '',
          sectionTranslate: '',
        ),
      ],
    ),
    BoardOfDirector(
      name: 'Sumber Daya Manusia',
      position: 'Sumber Daya Manusia',
      positionTranslate: 'Human Resources',
      subordinate: [
        Subordinate(
          name: 'Dr. Gugus Wijonarko, MM',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Dewan-Pakar-Sumber-Daya-Manusia_Gugus-Wijonarko.png',
          position: '',
          positionTranslate: '',
          section: '',
          sectionTranslate: '',
        ),
      ],
    ),
    BoardOfDirector(
      name: 'Keuangan & Investasi',
      position: 'Keuangan & Investasi',
      positionTranslate: 'Finance & Investment',
      subordinate: [
        Subordinate(
          name: 'Dr. Lucky Bayu Purnomo',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_Dewan-Pakar-Keuangan-Investasi_Lucky-Bayu-Purnomo.png',
          position: '',
          positionTranslate: '',
          section: '',
          sectionTranslate: '',
        ),
      ],
    ),
  ];

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
        RegionalBOD(
          name: 'Harun Gemilang',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPC-Samarinda_Harun-Gemilang.png',
          company: '(PSP)',
          position: 'DPC Samarinda',
          positionTranslate: 'Regional Coordinator of Samarinda',
          subordinate: [],
        ),
        RegionalBOD(
          name: 'DPD Kalimantan Barat',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPD-Kalimantan-Barat_Menunggu-PAW.png',
          company: '(PSP)',
          position: 'DPD Kalimantan Barat',
          positionTranslate: 'Regional Coordinator of West Kalimantan',
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
        RegionalBOD(
          name: 'Zainudin',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPD-Kalimantan-Barat_Menunggu-PAW.png',
          company: 'PBR',
          position: 'DPD Kalimantan Selatan',
          positionTranslate: 'Regional Coordinator of South Kalimantan',
          subordinate: [],
        ),
        RegionalBOD(
          name: 'Ikmal',
          imageURL: 'https://cms.abupi.or.id/wp-content/uploads/2026/04/Struktur-Organisasi_DPD-Kalimantan-Barat_Menunggu-PAW.png',
          company: 'PMI',
          position: 'DPC Luwu Timur',
          positionTranslate: 'Regional Coordinator of East Luwu',
          subordinate: [],
        ),
      ],
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

  void _showSubordinateRegionalBottomSheet(BuildContext context, RegionalBOD director) {
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
                      return _buildSubordinateRegionalRow(subordinate);
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

  Widget _buildSubordinateRegionalRow(RegionalBOD subordinate) {
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

  void _showSubordinateBottomSheet(BuildContext context, BoardOfDirector director) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final l10n = AppLocalizations.of(context);
        final language = l10n?.locale.languageCode ?? 'id';
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
    final language = l10n?.locale.languageCode ?? 'id';
    final position = language == 'id' ? subordinate.position : subordinate.positionTranslate;
    final section = language == 'id' ? subordinate.section : subordinate.sectionTranslate;

    String subtitle = position;

    subtitle += ' - $section';

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
                subtitle,
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
                        color: Colors.black,
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
            Tab(text: l10n?.supervisoryBoard ?? 'Dewan Pembina'),
            Tab(text: l10n?.advisoryBoard ?? 'Dewan Penasihat'),
            Tab(text: l10n?.expertAdvisoryBoard ?? 'Dewan Pakar'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBODGeneral(context),
          _buildSupervisoryBoard(context),
          _buildAdvisoryBoard(context),
          _buildExpertAdvisoryBoard(context),
        ],
      ),
    );
  }

  Widget _buildBODGeneral(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final language = l10n?.locale.languageCode ?? 'id';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            l10n?.generalChairman ?? 'Ketua Umum',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
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
                imageURL: director.imageURL ?? '',
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
              color: Colors.black,
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
                imageURL: director.imageURL ?? '',
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
              color: Colors.black,
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
                imageURL: director.imageURL ?? '',
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
              color: Colors.black,
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
                imageURL: director.imageURL ?? '',
                position: language == 'id' ? director.position : director.positionTranslate,
                isExpandable: director.subordinate.isNotEmpty,
                onTap: director.subordinate.isNotEmpty
                    ? () => _showSubordinateBottomSheet(context, director)
                    : null,
              );
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'DPW, DPD & DPC',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          ListView.separated(
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
                    ? () => _showSubordinateRegionalBottomSheet(context, director)
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
    final language = l10n?.locale.languageCode ?? 'id';

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
            imageURL: director.imageURL ?? '',
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
    final language = l10n?.locale.languageCode ?? 'id';

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
            imageURL: director.imageURL ?? '',
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
    final language = l10n?.locale.languageCode ?? 'id';

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
            name: language == 'id' ? director.position : director.positionTranslate,
            imageURL: director.imageURL ?? '',
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
