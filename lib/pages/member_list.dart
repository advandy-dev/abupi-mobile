import 'package:abupi/util/launch_url.dart';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/models/member_list.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberListScreen extends StatefulWidget {

  const MemberListScreen();

  @override
  _MemberListScreen createState() => _MemberListScreen();
}

class _MemberListScreen extends State<MemberListScreen> {

  static final List<MemberList> _memberList = [
    MemberList(
      name: 'PT. ADHI GUNA PUTERA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Adi-Guna-Putera.jpg',
      address: 'Jl. Kartini VII No. 2 RT 010/004, Kel. Kartini kec. Sawah Besar, Jakarta Pusat 10750',
      website: 'https://www.adhigunaputera.com/profile/',
    ),
    MemberList(
      name: 'PT. ADHIGUNA GLOBAL MANDIRI',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Adiguna-Global-Mandiri.jpg',
      address: 'Rukan Pesona View Blok A No. 5, Lt. 3, JL IR H Juanda Mekarjaya, Sukmajaya, Depok - Jawa Barat 16411',
      website: 'https://www.adhigm.com/',
    ),
    MemberList(
      name: 'PT. AGUNG PRIMA NUSANTARA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PT-AGUNG-PRIMA-NUSANTARA.jpg',
      address: 'Jl Bungur Besar Raya no 85 A, Kemayoran - Jakarta Pusat',
      website: 'https://www.apnhms.com/'
    ),
    MemberList(
      name: 'PT. ALUR MENTAYA SEJAHTERA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Screenshot-2025-03-03-084144.png',
      address: 'Jl. Pelita No. 87, Kel. MB. Hilir, Kec. MB. Ketapang, Sampit, Kalimantan Tengah'
    ),
    MemberList(
      name: 'PT. AMBANG BARITO NUSAPERSADA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Ambang-Barito-Persada.jpg',
      address: 'Jl. Yos Sudarso No. 6 RT 034 RW 002, Telaga Biru, Banjarmasin Barat, Kalimantan Selatan 70119',
      website: 'https://www.ambapers.com/'
    ),
    MemberList(
      name: 'PT. ANDHIKA ANDALANTAMA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Andika-Andalan-Tama.jpg',
      address: 'Jl. Kebon Bawang V No. 8, Tanjung Priok, Jakarta 14320',
      website: 'http://www.andalantama.com/'
    ),
    MemberList(
      name: 'PT. AQUILA TRANSINDO UTAMA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/QQUILA.jpg',
      address: 'Jl. Pramuka Asem Batur 8, Mlati Kidul – Kudus, Jawa Tengah',
      website: 'https://www.aquilatrans.co.id/'
    ),
    MemberList(
      name: 'PT. BAHTERA KAPUAS NUSANTARA',
      address: 'Metropolitan Tower Lt. 12 Unit C TB Simatupang Jl. RA Kartini, RT 010/RW 004 Cilandak Barat - Jakarta Selatan'
    ),
    MemberList(
      name: 'PT. BANDAR BAKAU JAYA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Bandar-Bakau-Jaya.jpg',
      address: 'Jl. Lintas Timur Piluk, Desa Bakauheni, Lampung Selatan'
    ),
    MemberList(
      name: 'PT. BANDAR TEGUH ABADI',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Bandar-Teguh-Abadi.jpg',
      address: 'Jl. Tanjung Datuk 276 ABC, Pekan Baru - Sumatera, Komp. Ruko Mitra Bahari 2 Blok F No. 28, Jl. Pakin, Penjaringan, Jakarta Utara 14440'
    ),
    MemberList(
      name: 'PT. BATU ALAM MAKMUR',
      address: 'Kp. Lumalang Desa Bojonegara, Kec. Bojonegara, Serang Banten 42454'
    ),
    MemberList(
      name: 'PT. BERLIAN MANYAR SEJAHTERA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Berlian-Manyar-Sejahtera.jpg',
      address: 'Gedung Gapura Surya Nusantara Lt.2, Jl. Perak Timur 620, Surabaya, Jawa Timur 60164',
      website: 'www.jiipe.com'
    ),
    MemberList(
      name: 'PT. BERLIAN PEMANDUAN INDONESIA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Berlian-Pemanduan-Indonesia.jpg',
      address: 'Equity Tower Lantai 35, Jl. Jend. Sudirman Kav. 52 – 53 SCBD, Jakarta Selatan'
    ),
    MemberList(
      name: 'PT. BIAS DELTA PRATAMA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Bias-Delta-Pratama.jpg',
      address: 'Komplek Sentosa Purnama Jaya. Blok B No 9-11, Jl. Yos Sudarso, Batu Ampar - Batam 29432',
      website: 'https://biasdeltapratama.id/'
    ),
    MemberList(
      name: 'PT. BINA INDO RAYA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/LOGO-PT-BIR.png',
      address: 'Desa Bunati, Kecamatan Angsana, Kabupaten Tanah Bumbu, Kalimantan Selatan',
      website: 'https://binaindoraya.com/'
    ),
    MemberList(
      name: 'PT. BIRU ARNAWAMA TIMUR',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/LOGO-BAT.jpg',
      address: 'Jalan Soekarno Hatta RT. 043 RW. 005, Kelurahan Swarga Bara Kecamatan Sangatta Utara, Kabupaten Kutai Timur Provinsi Kalimantan Timur'
    ),
    MemberList(
      name: 'PT. BOSOWA BANDAR INDONESIA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Bosowa.jpg',
      address: 'Gedung Menara Karya Lt. 16, Jl. HR. Rasuna Said Blok X5 Kav. 1-2, Jakarta Selatan 12950',
      website: 'https://www.bosowa.co.id/'
    ),
    MemberList(
      name: 'PT. BUANA ARMADA LESTARI',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/BAL.jpg',
      address: 'Atria @Sudirman Lt. 4, Jl. Jend. Sudirman Kav. 33A, Jakarta Pusat – 10220'
    ),
    MemberList(
      name: 'PT. CHANDRA ASRI PACIFIC TBK',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Candra-Sari.jpg',
      address: 'Wisma Barito Pacific Tower A Lt. 7, Jl. Letjen S. Parman Kav. 62-63, Jakarta Barat',
      website: 'https://www.chandra-asri.com/',
    ),
    MemberList(
      name: 'PT. CHANDRA CILEGON PORT',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/chandra-cilegon-port.jpg',
      address: 'Wisma Barito Pacific Tower A Lt. 7, Jl. Letjen S. Parman Kav. 62-63, Jakarta Barat',
      website: 'https://www.chandra-asri.com/'
    ),
    MemberList(
      name: 'PT. CHANDRA PELABUHAN NUSANTARA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/chandra-pelabuhan-nusantara.jpg',
      address: 'Wisma Barito Pacific Tower A Lt. 7, Jl. Letjen S. Parman Kav. 62-63, Jakarta Barat',
      website: 'https://www.chandra-asri.com/'
    ),
    MemberList(
      name: 'PT. CIKARANG INLAND PORT',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Cikarang-Dry-Port-v2.jpg',
      address: 'Jl. Dry Port Raya, Tanjung Sari, Kota Jababeka Cikarang, Bekasi 17550',
      website: 'https://https//cikarangdryport.com/'
    ),
    MemberList(
      name: 'PT. CITRA PELABUHAN MELAYU INDONESIA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Screenshot-2025-03-03-085928.jpg',
      address: 'Jl. Srikandi, Gang Ontorejo, Kampung Sumber Rejo No. 32'
    ),
    MemberList(
      name: 'PT. DELTA ARTHA BAHARI NUSANTARA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Delta-Arta.jpg',
      address: 'Jl. Ibrahim Zahier No. 181-183, Gresik - Jawa Timur 62111',
      website: 'https://dabn.co.id/'
    ),
    MemberList(
      name: 'PT. DERMAGA EMAS NUSANTARA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PT-DERMAGA-EMAS-NUSANTARA.png',
      address: 'Rukan Mutiara Marina Kav. 31-32, Jl. RE Martadinata, Semarang - Jawa Tengah 50144',
      website: 'https://pualamemasgroup.co.id/'
    ),
    MemberList(
      name: 'PT. DIRE PRATAMA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Dire-Pratama.jpg',
      address: 'Bakrie Tower 8th Floor, Rasuna Epicentrum Complex, Jl. HR Rasuna Said, Jakarta Selatan 12940'
    ),
    MemberList(
      name: 'PT. EKA NURI',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PT-Ekanuri.jpg',
      address: 'Jl. Hayam Wuruk No.2EE, Gambir, Jakarta Pusat,'
    ),
    MemberList(
      name: 'PT. GARYBER LINK GROUP',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Garyber-Link-Group.jpg',
      address: 'Jl. Ketapang – Siduk KM. 8, Sungai Awan Kanan, Muara Pawan, Ketapang, Kalimantan Barat'
    ),
    MemberList(
      name: 'PT. GANDASARI ENERGI',
      address: 'Jl. Radio Dalam Raya No.9A RT.10/RW.13 Gandaria Utara Kec. Kebayoran Baru - Jak Selatan'
    ),
    MemberList(
      name: 'PT. GEMA SAMUDERA SARANA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Logo-PT-Gema-SS.jpg',
      address: 'Jl. Duyung Complex Orchid Centre Blok B-26, Sungai Jodoh – Batu Ampar, Batam',
      website: 'https://gemasamuderasarana.com/'
    ),
    MemberList(
      name: 'PT. HADJI DINI PERKASA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PT-HADJI-DINI-PERKASA-e1677142794275.jpg',
      address: 'Jl. Tebet Barat XIII No. 7, Tebet - Jakarta Selatan',
      website: 'http://www.hadjidiniperkasa.com/'
    ),
    MemberList(
      name: 'PT. HASNUR RESOURCES TERMINAL',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Hasnur-Group.jpg',
      address: 'Gedung Office 8 Lantai 7, Jl. Senopati Raya No.8 (SCBD Lot 28), Jakarta Selatan',
      website: 'https://www.hasnurgroup.com/'
    ),
    MemberList(
      name: 'PT. INDIKA LOGISTIC & SUPPORT SERVICES',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Indika-Logistik.jpg',
      address: 'Gedung Mitra Lantai 6, Jl. Jend. Gatot Subroto Kav. 21, Jakarta 12930'
    ),
    MemberList(
      name: 'PT. INDO KONTAINER SARANA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Icon-Sarana.jpg',
      address: 'Jl. Bisma Raya Blok C2 No. 1 Lt. 2, Papanggo, Tanjung Priok, Jakarta Utara 14340'
    ),
    MemberList(
      name: 'PT. INDONESIA MULTI PURPOSE TERMINAL',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Logo-Indonesia-MPT.jpg',
      address: 'Jl. Kapt Piere Tendean No. 180 RT 17, Banjarmasin 70231 - Kalimantan Selatan'
    ),
    MemberList(
      name: 'PT. INDONESIAN AIR & MARINE SUPPLY',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Indonesia-Air-Marine-Supply.jpg',
      address: 'Jl. Cilincing Raya No. 33, Cilincing - Jakarta Utara 14110',
      website: 'http://www.airin.co.id/'
    ),
    MemberList(
      name: 'PT. INTIPRATAMA BANDAR KARIANGAU',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Inti-Pratama-Group.jpg',
      address: 'Jl. Mayjend. Sutoyo No. 42/47 (SPBU Gunung Malang), Balikpapan - Kalimantan Timur 76113',
      website: 'https://intipratamagroup.co.id/halaman/detail/intipratama-bandar-kariangau'
    ),
    MemberList(
      name: 'PT. JABAL NOR',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Jabal-Nor.jpg',
      address: 'Soho Pancoran Noble 1108, Jl. MT Haryono Kav. 2-3, Jakarta Selatan'
    ),
    MemberList(
      name: 'PT. JALATAMA DUTA MANDIRI',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/WhatsApp-Image-2025-03-03-at-09.02.00_07bd5a2e.jpg',
      address: 'One Pacific Place, Jl. Jenderal Sudirman Kav. 52-53, Jakarta',
      website: 'https://jalatamadutamaritim.com/'
    ),
    MemberList(
      name: 'PT. JAKARTA INTERNATIONAL CONTAINER TERMINAL',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Jakarta-International-Container-Terminal.jpg',
      address: 'Jl. Sulawesi Ujung No. 1, Tanjung Priok, Jakarta Utara 14460',
      website: 'https://www.jict.co.id/',
    ),
    MemberList(
      name: 'PT. JAYA INVESTAMA TERMINAL',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Jaya-Investa-Terminal.jpg',
      address: 'Kokan Permata Kelapa Gading Blok B.34, Jl. Boulevard Bukit Gading Raya, Jakarta 14240'
    ),
    MemberList(
      name: 'PT. KAPUAS PRIMA COAL TBK',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Kapuas-Prima-Coal.jpg',
      address: 'Ruko Elang Laut Boulevard Blok A 32 & 33, Jl. Pantai Indah Selatan I RT 002 RW 003, Jakarta Utara 14460',
      website: 'https://kapuasprima.co.id/'
    ),
    MemberList(
      name: 'PT. KARYA CITRA NUSANTARA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Karya-Citra-Nusantara.jpg',
      address: 'Jl. Jaya Pura No. 1 KBN Marunda, Jakarta Utara',
      website: 'https://kcnportmarunda.com/',
    ),
    MemberList(
      name: 'PT. KARYA TERMINAL INDONESIA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/LOGO-PT.KTI_.png',
      address: 'KMO BUILDINGS LANTAI 5, SUITE 510, JL.KYAI MAJA NOMOR 1, Desa/Kelurahan Gunung, Kota Adm. Jakarta Selatan, Provinsi DKI Jakarta, 14410'
    ),
    MemberList(
      name: 'PT. KAWASAN BERIKAT NUSANTARA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PT-KAWASAN-BERIKAT-NUSANTARA.jpg',
      address: 'Jl. Raya Cakung Cilincing, Tanjung Priok, Jakarta Utara DKI Jakarta 14140 Indonesia',
      website: 'http://kbn.co.id/',
    ),
    MemberList(
      name: 'PT. PELABUHAN KARIMUN (PERSERODA)',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/logo-pelabuhan-karimunn.jpg',
      address: 'Jl. Pelabuhan Kargo dan Roro Parit Rempak, Kel. Parit Benut, Kec. Meral, Karimun',
      website: 'https://www.bupkarimun.co.id/'
    ),
    MemberList(
      name: 'PT. KRAKATAU BANDAR SAMUDERA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/New-Logo-KBS-Full-Color-Primary-scaled.png',
      address: 'Jl. MayJend. S Parman KM 13, Cigading, Cilegon - Banten',
      website: 'https://www.krakatauinternationalport.co.id/'
    ),
    MemberList(
      name: 'PT. LAMONGAN INTEGRATED SHOREBASE',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Lamongan-Shorebase.jpg',
      address: 'Jl. Sunan Drajat No. 114, Lamongan, Jawa Timur',
      website: 'http://lamonganshorebase.com/'
    ),
    MemberList(
      name: 'PT. LINTAS INTERNASIONAL BERKARYA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/logo-LIB-scaled.png',
      address: 'Jl. Komp. Balikpapan Baru Pesona San Fransisco Blok FD-09, Balikpapan, Kalimantan Timur'
    ),
    MemberList(
      name: 'PT. LANGLANG LAJU LAYANG',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Lang-Lang-Laju-Layang.jpg',
      address: 'Puri Marina Townhouse Tahap 2 No. 7, Jl Pelabuhan Ratu Raya, RT 009 RW 0011 Ancol Pademangan, Jakarta Utara 14430',
      website: 'https://langlanglaju.com/'
    ),
    MemberList(
      name: 'PT. MACCAHMA DHINA HARTIENDSPIN',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/MACCAHMA-DHINA-HARTIENDSPIN.jpg',
      address: 'Town House Cipta Land Blok Tulip No. 33A, Batam',
      website: 'https://www.haswarpingroup.co.id/'
    ),
    MemberList(
      name: 'PT. MASTER SEGARA PRIMA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/HORIZONTAL-LIGHT-scaled-1.jpg',
      address: 'BIZ Hotel Lt. 5, Komplek Nagoya Newtown Blok T/No. 15, Lubuk Baja Kota, Nagoya, Batam 29444, Batam',
      website: 'https://www.mastersegaraprima.co.id/'
    ),
    MemberList(
      name: 'PT. MEGA AGUNG LIONG NUSANTARA',
      address: 'Jl. Marunda Timur No. 8, Segara Makmur Kec. Tarumajaya Kab. Bekasi - Jawa Barat',
    ),
    MemberList(
      name: 'PT. MERAH PUTIH MANDIRI',
      address: 'Jl. Yos Sudarso No. 11 RT 002 Kel. Karang Mumus Kec. Samarinda Kota',
    ),
    MemberList(
      name: 'PT. MITRA RAMA SAMUDERA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Mitra-Rama-Samudera.jpg',
      address: 'Jl. M. Ridwan Rais no 53, Beji - Depok',
      website: 'https://ptmrs.com/',
    ),
    MemberList(
      name: 'PT. MITRA SAMUDERA KREASI',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Logo-Mitra-Samudera-Kreasi.jpg',
      address: 'Komplek Pertokoan Grand Panglima Polim, Jl. Panglima Polim No. 65-66 Unit 83, Kebayoran Baru - Jakarta Selatan',
    ),
    MemberList(
      name: 'PT. MUARA LAJU LANCAR',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/LOGO-MUARA-LAJU-LANCAR-FIX-4-2.png',
      address: 'Jl. Pelabuhan Ratu, Komplek Marina Town House Tahap II, No.7 Lt.4 RT.009/RW.011, Kel. Ancol, Kec. Pademangan, Jakarta Utara - DKI Jakarta',
      website: 'https://muaralaju.com/',
    ),
    MemberList(
      name: 'PT. MULTI SARANA PELABUHAN INDONESIA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/WhatsApp-Image-2025-03-19-at-11.01.33_02711008.jpg',
      address: 'Jl. Aloon-Aloon Priok No. 27, Perak Barat, Krembangan, Surabaya, Jawa Timur'
    ),
    MemberList(
      name: 'PT. MULTI SARANA TERMINAL',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/VUBA.jpg',
      address: 'The Villas Cluster Bandung A2 No.8, Jln. DI Panjaitan Wundudopi - Baruga, Kota Kendari 93117',
      website: 'https://multisaranaterminal.com/'
    ),
    MemberList(
      name: 'PT. PELABUHAN BUANA REJA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Pelabuhan-Buana-Reja.jpg',
      address: 'Gedung TMT 1, 7th Floor Suite 701, Jl. Cilandak KKO No. 1, Jakarta 12560',
      website: 'https://www.ckb.co.id/id/ckb-logistics-group/detail/pelabuhan-buana-reja',
    ),
    MemberList(
      name: 'PT. PELABUHAN BUKIT PRIMA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/pbp.png',
      address: 'Gedung Terpadu PT Bukit Asam Tbk, Unit Pelabuhan Tarahan Lantai 4, Jalan Soekarno Hatta Km 15, Bandar Lampung',
      website: 'https://pelabuhanbukitprima.co.id/'
    ),
    MemberList(
      name: 'PT. PELABUHAN CILEGON MANDIRI',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PELABUHAN-CITRA-MANDIRI-1.jpg',
      address: 'Jl. RE Martadinata Link.Gerem Raya RT03/04, Kel. Gerem Kec. Gerogol Kota Cilegon - Banten, Kode Pos 42438',
      website: 'https://www.cilegonport.com/',
    ),
    MemberList(
      name: 'PT. PELABUHAN LEMBAR SEJAHTERA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Pelabuhan-Lembar.jpg',
      address: 'Jl. Kedaro Segenter (Belakang SDN 1 Lembar), Lembar Selatan KP Lombok Barat, Nusa Tenggara Barat 83364'
    ),
    MemberList(
      name: 'PT. PELABUHAN PENAJAM BANUA TAKA EASTKAL',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Astra-Infra-Port.jpg',
      address: 'Menara Astra, 11th Floor, Jl. Jenderal Sudirman Kav 5-6, Jakarta 10220 – Indonesia',
      website: 'https://astrainfraport.co.id/',
    ),
    MemberList(
      name: 'PT. PELABUHAN REMBANG KENCANA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Pelabuhan-Rembang-Kencana.jpg',
      address: 'Jl. P. Sudirman No. 75 Ds. Kabongan Kidul, Kabupaten Rembang, Jawa Tengah'
    ),
    MemberList(
      name: 'PT. PELABUHAN SAMUDERA PALARAN',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Samudera-Indonesia.jpg',
      address: 'Jl. P. Diponegoro RT 08, Kel. Bukuan, Kec. Palaran, Samarinda – Kalimantan Timur',
      website: 'https://www.samudera.id/psp/id'
    ),
    MemberList(
      name: 'PT. PELABUHAN SEGARA INDONESIA',
      address: 'Jl. Raya KSU KP. Parung Serab No 82RT 004 RW 005 Tirtajaya Sukmajaya Kota Depok Jawa Barat'
    ),
    MemberList(
      name: 'PT. PELABUHAN SWANGI INDAH',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Pelabuhan-Swangi-Indah.jpg',
      address: 'Jl. Cempaka Besar No. 23 RT 002 / RW 001, Kertak Baru Ilir, Banjarmasin - Kalimantan Selatan 70111'
    ),
    MemberList(
      name: 'PT. PELABUHAN TALENTA BUMI',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PT-TALENTA-BUMI.jpg',
      address: 'Jalan A.Yani km 21.5 Jurusan Pleihari No.16, RT.12, RW.03, Landasan Ulin Selatan,Liang Anggang, Banjarbaru (70722),Kalimantan Selatan',
      website: 'https://www.talentabumi.co.id/'
    ),
    MemberList(
      name: 'PT. PELABUHAN TEGAR INDONESIA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/mct-logo.png',
      address: 'Kawasan Industri & Pergudangan Marunda Centre, Jl. Marunda Makmur No. 21, Tarumajaya, Bekasi – Jawa Barat',
      website: 'https://www.mctport.com/'
    ),
    MemberList(
      name: 'PT. PELABUHAN TIGA BERSAUDARA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Pelabuhan-Tiga-Bersaudara.jpg',
      address: 'Kirana Boutique Office Blok E3-3, Jl. Boulevard Raya 1, Kelapa Gading - Jakarta 14240',
      website: 'https://ptb.co.id/in/'
    ),
    MemberList(
      name: 'PT. PELAYARAN INDOPROF SETIA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Pelayaran-Indonesia-Setia.jpg',
      address: 'Ruko The Summer Blok B1 No. 15, Teluk Tering, Batam Kota, Batam, Kepulauan Riau',
      website: 'https://indoprofsetia.com/'
    ),
    MemberList(
      name: 'PT. PERMUTAN PORT AND LOGISTICS',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Peteka-Karya-Samudra.jpg',
      address: 'Gedung PT. Pertamina Trans Kontinental, Jl. Raya Pelabuhan – Kabil, Batang – Riau',
      website: 'https://pekaes-bup.com/'
    ),
    MemberList(
      name: 'PT. PRIMA MULTI TERMINAL',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PMT.png',
      address: 'JL. PELABUHAN NO.1, Desa/Kelurahan Kuala Tanjung, Kec. Sei Suka, Kab. Batu Bara, Provinsi Sumatera Utara, Kode Pos: 21257',
      website: 'https://www.primamultiterminal.co.id/'
    ),
    MemberList(
      name: 'PT. SALAM NUSANTARA SERVIS',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PT.-SALAM-NUSANTARA-SERVIS.jpg',
      address: 'Jl. H. Syahrin 1-A, Gandaria Utara, Kebayoran Baru, Jakarta Selatan'
    ),
    MemberList(
      name: 'PT. SAMUDRA NUSANTARA BARRU (Perseroda)',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/WhatsApp-Image-2025-03-03-at-09.03.47_c8a9ea08.jpg',
      address: 'Gedung UPTD Pel. Ferry Garongkong, Jl. Mayjend. A. Mattalatta Baru'
    ),
    MemberList(
      name: 'PT. SAMUDERA SIAK',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Logo-Samudera-Siak.jpg',
      address: 'Jl. Raja Kecik, Kp. Rempak, Siak, Kabupaten Siak, Riau 28773',
      website: 'https://bup-samuderasiak.co.id/'
    ),
    MemberList(
      name: 'PT. SARANA ABADI LESTARI',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Sarana-Abadi-Lestari.jpg',
      address: 'Graha Niaga, Jl. Rapak Indah No 168, Samarinda 75125',
      website: 'https://salpalaran.com/'
    ),
    MemberList(
      name: 'PT. SARANA CITRANUSA KABIL',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Ciranusa-Kabil.jpg',
      address: 'Jl. Hang Kesturi I Kav. C4, Kawasan Industri Terpadu Kabil, Nongsa Batam - Kepulauan Riau',
      website: 'https://www.scnlogisticgroup.com/id/profil/'
    ),
    MemberList(
      name: 'PT. SARANA MITRA GLOBAL NUSANTARA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Sarana-Mitra-Global.jpg',
      address: 'Ruko Gading Bukit Indah Lt. 3, Jl. Gading Bukit Raya Blok H/5, Kelapa Gading Barat - Jakarta Utara'
    ),
    MemberList(
      name: 'PT. SEBAMBAN TERMINAL UMUM',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PT-Sebamban-Terminal-Umum-1.png',
      address: 'Jl. Raya Batulicin No. 1 RT 011 RW 003, Batulicin Tanah Bumbu, Kalimantan Selatan',
      website: 'https://sebambanterminalumum.com/'
    ),
    MemberList(
      name: 'PT. SEI MANGKEI NUSANTARA TIGA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/WhatsApp-Image-2023-10-09-at-10.49.29_06064c3e.jpg',
      address: 'Jl. Kelapa Sawit I No.1, Sei Mangkei, Bosar Maligas, Kabupaten Simalungun Sumatera Utara 21183',
      website: 'https://seimangkeidryport.com/'
    ),
    MemberList(
      name: 'PT. SENDY JAYA PUTRA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PT-SENDY-JAYA-PUTRA.png',
      address: 'Jl.Letjend Suprapto No 58, Baru Ulu – Balikpapan 76133, East Kalimantan',
      website: 'https://sendyjayaputra.co.id/',
    ),
    MemberList(
      name: 'PT. SEGARA CATUR PERKASA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/SEGARA-CATUR.png',
      address: 'Komplek Bintang Industrial Park I No. 27-28, Batu Ampar – Batam, Indonesia',
      website: 'https://segaracatur.id/'
    ),
    MemberList(
      name: 'PT. SEKAWAN TERMINAL SAMUDRA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Sekawan-Terminal-Samudra.jpg',
      address: 'Komplek Ruko Pergudangan Martadinata No. A3, Jl. RE Martadinata Kel. Kalidono, Ilir Timur II, Kota Palembang'
    ),
    MemberList(
      name: 'PT. SIAM MASPION TERMINAL',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Siam-Maspion-Terminal.jpg',
      address: 'Kawasan Industri Maspion, Jl Raya Manyar, Kecamatan Manyar. Kabupaten Gresik, Jawa Timur 61151',
      website: 'https://smtjetty.com/'
    ),
    MemberList(
      name: 'PT. SIAK TERMINAL INDONESIA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Screenshot-2025-03-03-092430.jpg',
      address: 'Jl. Sultan Syarif Hasyim No. 162, Kec. Siak, Kab. Siak, Provinsi Riau'
    ),
    MemberList(
      name: 'PT. SINAR MAS PONTIANAK',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Logo-Sinar-Mas-Pontianak.jpg',
      address: 'Komplek Pertokoan Grand Panglima Polim, Jl. Panglima Polim No. 65-66 Unit 83, Kebayoran Baru - Jakarta Selatan'
    ),
    MemberList(
      name: 'PT. SINARMAS LDA USAHA PELABUHAN',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PT-SINARMAS-LDA-MARITIME.png',
      address: 'Sinarmas Land Plaza Tower II 3/F, Jl. MH Thamrin No. 51, Jakarta Pusat 10350',
      website: 'https://www.sl-maritime.com/'
    ),
    MemberList(
      name: 'PT. SRIWIJAYA RAYA MINERAL',
      address: 'Komplek Biraland Residence Blok B/9 Mataiwoi Wua-Wua. Kendari SulTra'
    ),
    MemberList(
      name: 'PT. SURYA MENTAYA GEMILANG',
      address: 'Jl. Haryono Mas Tirtodarma, Kotawaringin Timur, Kallimantan Tengah'
    ),
    MemberList(
      name: 'PT. TERMINAL BORNEO INDONESIA',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Terminal-Borneo-Indonesia.jpg',
      address: 'Equity Tower Lantai 37, Jl. Jend. Sudirman Kav. 52 – 53, SCBD, Jakarta Selatan',
    ),
    MemberList(
      name: 'PT. TERMINAL INTI SAMUDERA',
      address: 'Ruko Inkopal, Jl. Boulevard Barat Raya Blok C No 39-41 Kelapa Gading Barat Jakarta Utara 14240',
    ),
    MemberList(
      name: 'PT. TITIAN LABUAN ANUGRAH',
      address: 'Jl. Sultan Hasanudin 10 Biawao, Kota Selatan Gorontalo, Sulawesi',
    ),
    MemberList(
      name: 'PT. TRANSMARINA PELABUHAN INDONESIA',
    ),
    MemberList(
      name: 'PT. TRANSPORINDO NUSANTARA TERMINAL',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/tnt.jpg',
      address: 'Jl. Sulung 89 Blok D-2 Surabaya 60174',
    ),
    MemberList(
      name: 'PT. TRIPLE EIGHT ENERGY',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/logo-triple-eight.png',
      address: 'Gedung Data Print, Jl. Blora No. 276, Jakarta Pusat – 10310',
    ),
    MemberList(
      name: 'PT. TUNAS INTI ABADI',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Tunas-Into-Abadi.jpg',
      address: 'Gedung TMT 1 Lantai 9, Jl. Cilandak KKO No. 1, Jakarta 12560',
      website: 'https://www.tiacoal.co.id/',
    ),
    MemberList(
      name: 'PT. USAHA MULIA KALBAR',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Logo-Usaha-Mulia-Kalbar.jpg',
      address: 'Komplek Pertokoan Grand Panglima Polim, Jl. Panglima Polim No. 65-66 Unit 83, Kebayoran Baru - Jakarta Selatan',
    ),
    MemberList(
      name: 'PT. VARIA USAHA BAHARI',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/VUBA.jpg',
      address: 'Jl. Veteran 129 Gresik, Jawa Timur 61122',
      website: 'https://www.silog.co.id/pt-varia-usaha-bahari-vuba/',
    ),
    MemberList(
      name: 'PT. WORLD TERMINALINDO',
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/World-Terminalindo.jpg',
      address: 'Kokan Permata Kelapa Gading Blok B.35, Jl. Boulevard Bukit Gading Raya, Jakarta 14239',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget _buildExpandableCapsule(
      BuildContext context, {
        required String title,
        required List<Widget> children,
      }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(2, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.listOfMember ?? 'Daftar Anggota',
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
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            ..._memberList.map((member) => _buildExpandableCapsule(
              context,
              title: member.name,
              children: [
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (member.imageURL != null) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              member.imageURL!,
                              width: 64,
                              height: 64,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 64,
                                height: 64,
                                color: Colors.grey[300],
                                child: const Icon(Icons.image_not_supported),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Expanded(
                          child: Text(
                            member.address ?? '-',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (member.website != null && member.website!.isNotEmpty)
                    ...[
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.open_in_new),
                          label: Text(l10n?.visitWebsite ?? 'Kunjungi Website'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE2642A),
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            final url = member.website!;
                            final validUrl =
                                (url.startsWith("http://") || url.startsWith("https://"))
                                    ? url
                                    : "https://$url";
                            launchWebsite(validUrl);
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            )).toList(),
          ],
        ),
      ),
    );
  }
}
