import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  static const String _localeKey = 'selected_locale';
  Locale _locale = const Locale('id');

  Locale get locale => _locale;

  LocaleProvider() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_localeKey);
    if (languageCode != null) {
      final savedLocale = Locale(languageCode);
      if (AppLocalizations.supportedLocales.contains(savedLocale)) {
        _locale = savedLocale;
        notifyListeners();
      }
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (!AppLocalizations.supportedLocales.contains(locale)) return;
    _locale = locale;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
  }
}

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('id'),
    Locale('en'),
  ];

  static final Map<String, Map<String, String>> _localizedValues = {
    'id': {
      'home': 'Beranda',
      'event': 'Acara',
      'service': 'Layanan',
      'other': 'Lainnya',
      'organization': 'Organisasi',
      'regulation': 'Regulasi',
      'media': 'Media',
      'contact_us': 'Hubungi Kami',
      'refresh': 'Segarkan',
      'language': 'Bahasa',
      'indonesian': 'Indonesia',
      'english': 'Inggris',
      'select_language': 'Pilih Bahasa',
      'about_us': 'Tentang Kami',
      'members': 'Anggota ABUPI',
      'board_of_directors': 'Dewan Pengurus',
      'regional_coordinator': 'Koordinator Wilayah',
      'gallery': 'Galeri',
      'strategic_partners': 'Mitra Strategis',
      'work_partners': 'Mitra Kerja',
      'regulator': 'Regulator',
      'external_regulation': 'Regulasi Eksternal',
      'news': 'Berita',
      'read_more': 'Selengkapnya',
      'see': 'Lihat',
      'see_all': 'Lihat Semua',
      'upcoming_events': 'Acara Mendatang',
      'infographic': 'Infografis',
      'organization_structure': 'Struktur Organisasi',
      'general_chairman': 'Ketua Umum',
      'vice_chairman': 'Wakil Ketua Umum',
      'general_secretary': 'Sekretaris Umum',
      'general_treasurer': 'Bendahara Umum',
      'list_of_member': 'Daftar Anggota',
      'service_registration_title': 'Pendaftaran Keanggotaan ABUPI',
      'service_registration_description': 'Silahkan unduh E-Form. Kirimkan Form yang telah diisi dan kelengkapannya ke email sekretariat.',
      'done': 'Selesai',
      'search_event_placeholder': 'Masukkan nama acara',
      'vision': 'Visi',
      'our_vision': 'Visi Kami',
      'mission': 'Misi',
      'our_mission': 'Misi Kami',
      'basis_foundation_abupi': 'Dasar Pendirian ABUPI',
      'basis_foundation_description_abupi': 'Dasar pendirian ABUPI adalah untuk mendukung program reformasi pelabuhan seperti yang diamanatkan pada Undang-undang No. 17 Tahun 2008 tentang Pelayaran dan Peraturan Pemerintah No. 61 Tahun 2009 tentang Kepelabuhanan.',
      'deed_of_establishment_abupi': 'Akta Pendirian ABUPI',
      'deed_of_establishment_description_abupi': 'ABUPI didirikan dengan akte pendirian No. 010 tanggal 16 Februari 2015 di hadapan Notaris Elly Rustam SH dan dikukuhkan dengan pengesahan dari Kementrian Hukum dan Hak Asasi Manusia Republik Indonesia No. AHU-001650.AH.01, Tahun 2015.',
      'vision_description': 'Organisasi ABUPI mempunyai Visi menjadikan anggota sebagai pengelola pelabuhan yang berdaya saing global.',
      'mission_description_1': 'Mendukung kebijakan pemerintah dalam program pembangunan ekonomi nasional.',
      'mission_description_2': 'Mengembangkan pelayanan jasa kepelabuhanan di dalam dan di luar negeri',
      'mission_description_3': 'Mengembangkan kemampuan anggota sebagai tulang punggung kelancaran pelayanan kepelabuhanan.',
      'mission_description_4': 'Menjadikan kegiatan jasa kepelabuhanan sebagai industri jasa yang berdaya saing global.',
      'mission_description_5': 'Menjadikan para anggota sebagai pelaku professional di dalam bidang kepelabuhanan yang berorientasi pada kepuasan pelanggan.',
      'form_registration_company_name_title': 'Nama Perusahaan',
      'form_registration_company_name_placeholder': 'PT Contoh Indonesia',
      'form_registration_pic_name_title': 'Nama PIC',
      'form_registration_pic_name_placeholder': 'Nama lengkap PIC',
      'form_registration_company_address_title': 'Alamat Perusahaan',
      'form_registration_business_address_title': 'Alamat Lokasi Usaha',
      'form_registration_business_address_placeholder': 'Alamat lengkap lokasi usaha',
      'form_registration_company_address_placeholder': 'Alamat lengkap perusahaan',
      'form_registration_pic_position_title': 'Jabatan PIC',
      'form_registration_pic_position_placeholder': 'Direktur operasional',
      'form_registration_pic_phone_number_title': 'Nomor Telepon PIC',
      'form_registration_pic_phone_number_placeholder': '+6281234567890',
      'form_registration_pic_email_title': 'Email PIC',
      'form_registration_pic_email_placeholder': 'nama@company.com',
      'form_registration_type_of_business_title': 'Jenis Izin Usaha',
      'form_registration_status_company_title': 'Status Perusahaan',
      'form_registration_membership_type_title': 'Jenis Keanggotaan',
      'required_fill': 'Wajib diisi',
      'empty_event': 'Tidak ada acara',
      'empty_news': 'Tidak ada berita',
      'empty_data': 'Tidak ada data',
      'office_address_value': 'Alamat Kantor Kami',
      'phone_number': 'Nomor Telepon',
      'phone': 'Telepon',
      'open_map': 'Buka Map',
      'contact': 'Hubungi',
      'email_address': 'Alamat Email',
      'send_email': 'Kirim Email',
      'visit_website': 'Kunjungi Website',
      'phone_short': 'Telp',
      'address': 'Alamat',
      'training_type': 'Tipe Pelatihan',
      'education_and_training': 'Pendidikan & Pelatihan',
      'consultation_service': 'Konsultasi BUP/Tersus/TUKS',
      'advisory_board': 'Dewan Penasihat',
      'supervisory_board': 'Dewan Pembina',
      'expert_advisory_board': 'Dewan Pakar',
      'template_prefix_email_registration': 'Yth. Pengurus ABUPI\n\nMelalui email ini kami bermaksud mengajukan permohonan untuk menjadi bagian dari ABUPI.\n\nBersamaan dengan email ini, kami lampirkan data perusahaan kami beserta data PIC yang dapat dihubungi.\n',
      'template_postfix_email_registration': '\nTerima kasih atas waktu dan perhatiannya.',
      'search_news_placeholder': 'Masukkan nama berita',
      'work_plan': 'Program Kerja',
      'inclusion': 'Inklusi',
      'newsletter': 'Buletin',
      'journal': 'Jurnal',
      'description': 'Deskripsi',
      'pillar_description': 'Untuk mewujudkan visi tersebut, ABUPI berkomitmen memperkuat kolaborasi, tata kelola, dan keberlanjutan melalui tiga pilar utama berikut:',
      'regional_operation_section_title': 'Wilayah Operasi Regional ABUPI',
      'stakeholders': 'Pemangku Kepentingan',
      'press_release': 'Siaran Pers',
      'service_consultation_and_assistance_title': 'Konsultasi & Asistensi',
      'service_consultation_and_assistance_description': 'Dapatkan dukungan dari tim ABUPI untuk konsultasi BUP/Tersus/TUKS.',
      'service_education_and_training_title': 'Pendidikan & Pelatihan',
      'service_education_and_training_description': 'Program pengembangan kompetensi melalui Public Training dan In-house Training.',
      'service_website_database_partner_title': 'Website Database Partner',
      'service_website_database_partner_description': 'Akses informasi partner dan jaringan kolaborasi ABUPI.',
      'service_external_partner_service_title': 'Layanan Partner Eksternal',
      'service_external_partner_service_description': 'Layanan tambahan bersama partner eksternal untuk kebutuhan aanggota.',
      'service_consultation_and_assistance_form_button': 'Form Konsultasi & Asistensi',
      'service_education_and_training_public_training_button': 'Public Training',
      'service_education_and_training_in_house_training_button': 'In-House Training',
      'service_website_database_partner_button': 'Buka Website Partner',
      'service_cooperation_and_partnership_title': 'Kerjasama dan Kemitraan',
      'service_cooperation_and_partnership_description': 'Akses informasi partner dan jaringan kolaborasi ABUPI.',
      'service_cooperation_and_partnership_button': 'Informasi Jaringan',
      'service_external_partner_service_visit_button': 'Kunjungi Partner',
      'service_financing_title': 'Pembiayaan',
      'service_financing_description': 'Solusi Pembiayaan Pengembangan Pelabuhan mulai dari skema KPBU, Investasi.',
      'service_financing_button': 'Hubungi Kami',
      'registration_same_address_label': 'Sama dengan alamat perusahaan',
      'work_plan_acceleration': 'Akselerasi',
      'work_plan_inclusion': 'Inklusi',
      'work_plan_competence': 'Kompetensi',
      'work_plan_technology': 'Teknologi',
      'work_plan_sustainability': 'Keberlanjutan',
      'template_prefix_email_consultation_and_assistance': 'Yth. Pengurus ABUPI\n\nMelalui email ini kami bermaksud mengajukan permohonan untuk konsultasi dan asistensi.\n\nBersamaan dengan email ini, kami lampirkan data perusahaan kami beserta data PIC yang dapat dihubungi.\n',
      'name': 'Nama',
      'position': 'Jabatan',
      'email': 'Email',
      'contact_number': 'Nomor Kontak',
      'ABUPI_member_id': 'Nomor Keanggotaan ABUPI',
      'subject': 'Subject',
      'problem_description': 'Deskripsi Permasalahan',
      'consultation_assistance_tnc_description': 'Dengan ini saya menyatakan bahwa seluruh data yang saya isi adalah benar dan dapat dipertanggungjawabkan. Dengan mengisi formulir ini, saya bersedia untuk dihubungi oleh ABUPI guna menindaklanjuti permasalahan yang saya sampaikan.',
      'agree': 'Saya setuju',
      'category': 'Kategori',
      'choose_category': 'Pilih Kategori',
      'download_newsletter': 'Unduh Buletin',
      'share_to_whatsapp': 'Bagikan melalui Whatsapp',
      'newsletter_information': '* Klik pada Cover di atas untuk membaca buletin',
      'companies_that_trust_abupi': 'Perusahaan-perusahaan yang mempercayai ABUPI',
      'abstract': 'Abstrak',
      'see_abstract': 'Lihat Abstrak',
      'form_contact_title': 'Form Kontak',
      'form_contact_first_name': 'Nama Depan',
      'form_contact_last_name': 'Nama Belakang',
      'form_contact_email': 'Email',
      'form_contact_message': 'Pesan',
      'send': 'Kirim',
      'contact_us_success': 'Pesan berhasil dikirim. Mohon tunggu respons dari tim ABUPI. Silakan cek email Anda untuk memastikan pesan terkirim dengan baik ke ABUPI.',
      'registration_success': 'Form registrasi Anda sudah kami terima. Tim internal ABUPI akan menghubungi Anda lebih lanjut melalui email. Silakan cek email Anda untuk memastikan pesan terkirim dengan baik.',
      'consultation_assistance_success': 'Formulir berhasil dikirim. Mohon tunggu respons dari tim ABUPI. Silakan cek email Anda untuk memastikan pesan terkirim dengan baik ke ABUPI.',
      'service_join_title': 'Membangun Koneksi, Mendorong Pertumbuhan.',
      'service_join_description': 'Bersama ABUPI, wujudkan sinergi untuk memperkuat daya saing industri kepelabuhanan Indonesia.',
      'search_journal_placeholder': 'Masukkan nama jurnal',
      'send_journal': 'Kirim Jurnal',
      'form_journal_title': 'Form Pengiriman Jurnal',
      'form_journal_name_placeholder': 'Masukkan nama lengkap',
      'form_journal_phone_number_placeholder': '+6281234567890',
      'form_journal_company_name_title': 'Nama perusahaan',
      'form_journal_company_name_placeholder': 'Masukkan nama perusahaan',
      'form_journal_company_address_title': 'Alamat Perusahaan',
      'form_journal_company_address_placeholder': 'Masukkan alamat perusahaan',
      'form_journal_abstract_title': 'Abstrak',
      'form_journal_abstract_placeholder': 'Tuliskan ringkasan jurnal Anda',
      'form_journal_file_title': 'File Jurnal',
      'form_journal_tnc_checklist': 'Saya memahami bahwa pengajuan jurnal akan direview terlebih dahulu sebelum dapat ditampilkan di website.',
    },
    'en': {
      'home': 'Home',
      'event': 'Event',
      'service': 'Service',
      'other': 'Other',
      'organization': 'Organization',
      'regulation': 'Regulation',
      'media': 'Media',
      'contact_us': 'Contact Us',
      'refresh': 'Refresh',
      'language': 'Language',
      'indonesian': 'Indonesian',
      'english': 'English',
      'select_language': 'Select Language',
      'about_us': 'About Us',
      'members': 'ABUPI Members',
      'board_of_directors': 'Board of Directors',
      'regional_coordinator': 'Regional Coordinator',
      'gallery': 'Gallery',
      'strategic_partners': 'Strategic Partners',
      'work_partners': 'Work Partners',
      'regulator': 'Regulator',
      'external_regulation': 'External Regulation',
      'news': 'News',
      'see': 'See',
      'see_all': 'See All',
      'read_more': 'Read More',
      'upcoming_events': 'Upcoming Events',
      'infographic': 'Infographic',
      'organization_structure': 'Organization Structure',
      'general_chairman': 'General Chairman',
      'vice_chairman': 'Vice Chairman',
      'general_secretary': 'General Secretary',
      'general_treasurer': 'General Treasurer',
      'list_of_member': 'List of Member',
      'service_registration_title': 'ABUPI Membership Registration',
      'service_registration_description': 'Please download the e-form. Send the completed form and all necessary documents to the secretariat email address.',
      'done': 'Done',
      'search_event_placeholder': 'Input event name',
      'vision': 'Vision',
      'our_vision': 'Our Vision',
      'mission': 'Mission',
      'our_mission': 'Our Mission',
      'basis_foundation_abupi': 'Basis Foundation of ABUPI',
      'basis_foundation_description_abupi': 'The basis for establishing ABUPI is to support the port reform program as mandated by Law No. 17 of 2008 concerning Shipping and Government Regulation No. 61 of 2009 concerning Ports.',
      'deed_of_establishment_abupi': 'Deed of Establishment ABUPI',
      'deed_of_establishment_description_abupi': 'ABUPI was established with deed of establishment No. 010 dated February 16, 2015 before Notary Elly Rustam SH and confirmed with ratification from the Ministry of Law and Human Rights of the Republic of Indonesia No. AHU-001650.AH.01, Year 2015.',
      'vision_description': "ABUPI's vision is to make its members globally competitive port operators.",
      'mission_description_1': 'Supporting government policies in the national economic development program.',
      'mission_description_2': 'Developing maritime services domestically and internationally.',
      'mission_description_3': 'Developing member capabilities as the backbone of smooth port services.',
      'mission_description_4': 'Making maritime services a globally competitive service industry.',
      'mission_description_5': 'Making members professional actors in the field of ports oriented towards customer satisfaction.',
      'form_registration_company_name_title': 'Company Name',
      'form_registration_company_name_placeholder': 'Example Company',
      'form_registration_pic_name_title': 'PIC Name',
      'form_registration_pic_name_placeholder': 'PIC fullname',
      'form_registration_company_address_title': 'Company Address',
      'form_registration_business_address_title': 'Business Address',
      'form_registration_business_address_placeholder': 'Business Address',
      'form_registration_company_address_placeholder': 'Company address',
      'form_registration_pic_position_title': 'PIC Position',
      'form_registration_pic_position_placeholder': 'Director of operations',
      'form_registration_pic_phone_number_title': 'PIC Phone Number',
      'form_registration_pic_phone_number_placeholder': '+6281234567890',
      'form_registration_pic_email_title': 'PIC Email',
      'form_registration_pic_email_placeholder': 'name@company.com',
      'form_registration_type_of_business_title': 'BusinessType',
      'form_registration_status_company_title': 'Company Status',
      'form_registration_membership_type_title': 'Membership Type',
      'required_fill': 'Required to fill',
      'empty_event': 'Event is empty',
      'empty_news': 'News is empty',
      'empty_data': 'Data is empty',
      'office_address_value': 'Office Address',
      'phone_number': 'Phone Number',
      'phone': 'Phone',
      'open_map': 'Open Map',
      'contact': 'Contact',
      'email_address': 'Email Address',
      'send_email': 'Send Email',
      'visit_website': 'Visit Website',
      'phone_short': 'Phone',
      'address': 'Address',
      'training_type': 'Training Type',
      'education_and_training': 'Education & Training',
      'consultation_service': 'BUP/Tersus/TUKS Consultation',
      'advisory_board': 'Advisory Board',
      'supervisory_board': 'Supervisory Board',
      'expert_advisory_board': 'Expert Advisory Board',
      'template_prefix_email_registration': 'Dear ABUPI Management\n\nThrough this email, we would like to apply to become a part of ABUPI.\n\nAlong with this email, we attach our company data as well as the contactable PIC information.\n',
      'template_postfix_email_registration': '\nThank you for your time and attention.',
      'search_news_placeholder': 'Input news name',
      'work_plan': 'Work Plan',
      'inclusion': 'Inclusion',
      'newsletter': 'Newsletter',
      'journal': 'Journal',
      'description': 'Description',
      'pillar_description': 'To realize this vision, ABUPI is committed to strengthening collaboration, governance, and sustainability through the following three main pillars:',
      'regional_operation_section_title': 'ABUPI Regional Operational Area',
      'stakeholders': 'Stakeholders',
      'press_release': 'Press Release',
      'service_consultation_and_assistance_title': 'Consultation & Assistance',
      'service_consultation_and_assistance_description': 'Get support from the ABUPI team for BUP/Tersus/TUKS consultations.',
      'service_education_and_training_title': 'Education & Training',
      'service_education_and_training_description': 'Competency development programs through Public and In-House Training.',
      'service_website_database_partner_title': 'Website Database Partner',
      'service_website_database_partner_description': 'Access to partner information and ABUPI`s collaboration network.',
      'service_cooperation_and_partnership_title': 'Cooperation dan Partnership',
      'service_cooperation_and_partnership_description': 'Access to partner information and ABUPI`s collaboration network.',
      'service_cooperation_and_partnership_button': 'Network Information',
      'service_external_partner_service_title': 'External Partner Services',
      'service_external_partner_service_description': 'Additional services with external partners to meet member needs.',
      'service_consultation_and_assistance_form_button': 'Form Consultation & Assistance',
      'service_education_and_training_public_training_button': 'Public Training',
      'service_education_and_training_in_house_training_button': 'In-House Training',
      'service_website_database_partner_button': 'Open Partner Website',
      'service_external_partner_service_visit_button': 'Visit Partner',
      'service_financing_title': 'Financing',
      'service_financing_description': 'Port Development Financing Solutions from KPBU schemes to Investment.',
      'service_financing_button': 'Contact Us',
      'registration_same_address_label': 'Same like company address',
      'work_plan_acceleration': 'Acceleration',
      'work_plan_inclusion': 'Inclusion',
      'work_plan_competence': 'Competence',
      'work_plan_technology': 'Technology',
      'work_plan_sustainability': 'Sustainability',
      'name': 'Name',
      'position': 'Position',
      'email': 'Email',
      'contact_number': 'Contact Number',
      'ABUPI_member_id': 'ABUPI Member ID',
      'subject': 'Subject',
      'problem_description': 'Description of Problem',
      'template_prefix_email_consultation_and_assistance': 'Dear ABUPI Management\n\nThrough this email, we would like to apply to consultation dan assistance.\n\nAlong with this email, we attach our company data as well as the contactable PIC information.\n',
      'agree': 'I agree',
      'consultation_assistance_tnc_description': 'I confirm that all the details I have entered are true and valid. By filling out this form, I agree to be contacted by ABUPI to follow up on the issues I submitted.',
      'category': 'Category',
      'choose_category': 'Choose Category',
      'download_newsletter': 'Download Newsletter',
      'share_to_whatsapp': 'Share to Whatsapp',
      'newsletter_information': '* Click on Cover above for read the newsletter',
      'companies_that_trust_abupi': 'Companies that trust ABUPI',
      'abstract': 'Abstract',
      'see_abstract': 'See Abstract',
      'form_contact_title': 'Contact Form',
      'form_contact_first_name': 'First Name',
      'form_contact_last_name': 'Last Name',
      'form_contact_email': 'Email',
      'form_contact_message': 'Message',
      'send': 'Send',
      'contact_us_success': 'Your message has been sent successfully. Please wait for a response from the ABUPI team. Please check your email to ensure your message was delivered to ABUPI.',
      'registration_success': 'We have received your registration form. The ABUPI internal team will contact you via email for further information. Please check your email to ensure your message was sent correctly.',
      'consultation_assistance_success': 'Formulir berhasil dikirim. Mohon tunggu respons dari tim ABUPI. Silakan cek email Anda untuk memastikan pesan terkirim dengan baik ke ABUPI.',
      'service_join_title': 'Building Connection, Drives Growth.',
      'service_join_description': 'With ABUPI, create synergy to strengthen the competitiveness of Indonesia`s port industry.',
      'search_journal_placeholder': 'Input journal name',
      'send_journal': 'Send Journal',
      'form_journal_title': 'Journal Submission Form',
      'form_journal_name_placeholder': 'Input full name',
      'form_journal_phone_number_placeholder': '+6281234567890',
      'form_journal_company_name_title': 'Company name',
      'form_journal_company_name_placeholder': 'Input company name',
      'form_journal_company_address_title': 'Company Address',
      'form_journal_company_address_placeholder': 'Input company address',
      'form_journal_abstract_title': 'Abstract',
      'form_journal_abstract_placeholder': 'Write a summary of your journal',
      'form_journal_file_title': 'Journal File',
      'form_journal_tnc_checklist': 'I understand that journal submissions will be reviewed before they can be displayed on the website.',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  String get home => translate('home');
  String get event => translate('event');
  String get service => translate('service');
  String get other => translate('other');
  String get organization => translate('organization');
  String get regulation => translate('regulation');
  String get media => translate('media');
  String get contactUs => translate('contact_us');
  String get refresh => translate('refresh');
  String get language => translate('language');
  String get indonesian => translate('indonesian');
  String get english => translate('english');
  String get selectLanguage => translate('select_language');
  String get aboutUs => translate('about_us');
  String get members => translate('members');
  String get boardOfDirectors => translate('board_of_directors');
  String get regionalCoordinator => translate('regional_coordinator');
  String get gallery => translate('gallery');
  String get strategicPartners => translate('strategic_partners');
  String get workPartners => translate('work_partners');
  String get regulator => translate('regulator');
  String get externalRegulation => translate('external_regulation');
  String get news => translate('news');
  String get see => translate('see');
  String get seeAll => translate('see_all');
  String get upcomingEvents => translate('upcoming_events');
  String get infographic => translate('infographic');
  String get readMore => translate('read_more');
  String get organizationStructure => translate('organization_structure');
  String get generalChairman => translate('general_chairman');
  String get viceChairman => translate('vice_chairman');
  String get generalSecretary => translate('general_secretary');
  String get generalTreasurer => translate('general_treasurer');
  String get listOfMember => translate('list_of_member');
  String get serviceRegistrationTitle => translate('service_registration_title');
  String get serviceRegistrationDescription => translate('service_registration_description');
  String get done => translate('done');
  String get searchEventPlaceholder => translate('search_event_placeholder');
  String get vision => translate('vision');
  String get mission => translate('mission');
  String get ourVision => translate('our_vision');
  String get ourMission => translate('our_mission');
  String get basisFoundationABUPI => translate('basis_foundation_abupi');
  String get deedEstablishmentABUPI => translate('deed_of_establishment_abupi');
  String get basisFoundationDescriptionABUPI => translate('basis_foundation_description_abupi');
  String get deedEstablishmentDescriptionABUPI => translate('deed_of_establishment_description_abupi');
  String get visionDescription => translate('vision_description');
  String get missionDescription1 => translate('mission_description_1');
  String get missionDescription2 => translate('mission_description_2');
  String get missionDescription3 => translate('mission_description_3');
  String get missionDescription4 => translate('mission_description_4');
  String get missionDescription5 => translate('mission_description_5');
  String get formRegistrationCompanyNameTitle => translate('form_registration_company_name_title');
  String get formRegistrationCompanyNamePlaceholder => translate('form_registration_company_name_placeholder');
  String get formRegistrationPicNameTitle => translate('form_registration_pic_name_title');
  String get formRegistrationPicNamePlaceholder => translate('form_registration_pic_name_placeholder');
  String get formRegistrationCompanyAddressTitle => translate('form_registration_company_address_title');
  String get formRegistrationBusinessAddressTitle => translate('form_registration_business_address_title');
  String get formRegistrationBusinessAddressPlaceholder => translate('form_registration_business_address_placeholder');
  String get formRegistrationCompanyAddressPlaceholder => translate('form_registration_company_address_placeholder');
  String get formRegistrationPicPositionTitle => translate('form_registration_pic_position_title');
  String get formRegistrationPicPositionPlaceholder => translate('form_registration_pic_position_placeholder');
  String get formRegistrationPicPhoneNumberTitle => translate('form_registration_pic_phone_number_title');
  String get formRegistrationPicPhoneNumberPlaceholder => translate('form_registration_pic_phone_number_placeholder');
  String get formRegistrationPicEmailTitle => translate('form_registration_pic_email_title');
  String get formRegistrationPicEmailPlaceholder => translate('form_registration_pic_email_placeholder');
  String get formRegistrationTypeOfBusinessTitle => translate('form_registration_type_of_business_title');
  String get formRegistrationStatusCompanyTitle => translate('form_registration_status_company_title');
  String get formRegistrationMembershipTypeTitle => translate('form_registration_membership_type_title');
  String get requiredFill => translate('required_fill');
  String get emptyEvent => translate('empty_event');
  String get emptyNews => translate('empty_news');
  String get officeAddressValue => translate('office_address_value');
  String get phoneNumber => translate('phone_number');
  String get openMap => translate('open_map');
  String get contact => translate('contact');
  String get emailAddress => translate('email_address');
  String get sendEmail => translate('send_email');
  String get visitWebsite => translate('visit_website');
  String get phoneShort => translate('phone_short');
  String get address => translate('address');
  String get trainingType => translate('training_type');
  String get educationAndTraining => translate('education_and_training');
  String get consultationService => translate('consultation_service');
  String get phone => translate('phone');
  String get advisoryBoard => translate('advisory_board');
  String get supervisoryBoard => translate('supervisory_board');
  String get expertAdvisoryBoard => translate('expert_advisory_board');
  String get templatePrefixEmailRegistration => translate('template_prefix_email_registration');
  String get templatePostfixEmailRegistration => translate('template_postfix_email_registration');
  String get searchNewsPlaceholder => translate('search_news_placeholder');
  String get workPlan => translate('work_plan');
  String get inclusion => translate('inclusion');
  String get newsletter => translate('newsletter');
  String get journal => translate('journal');
  String get description => translate('description');
  String get pillarDescription => translate('pillar_description');
  String get regionalOperationSectionTitle => translate('regional_operation_section_title');
  String get stakeholders => translate('stakeholders');
  String get pressRelease => translate('press_release');
  String get serviceConsultationAssistanceTitle => translate('service_consultation_and_assistance_title');
  String get serviceConsultationAssistanceDescription => translate('service_consultation_and_assistance_description');
  String get serviceEducationTrainingTitle => translate('service_education_and_training_title');
  String get serviceEducationTrainingDescription => translate('service_education_and_training_description');
  String get serviceWebsiteDatabasePartnerTitle => translate('service_website_database_partner_title');
  String get serviceWebsiteDatabasePartnerDescription => translate('service_website_database_partner_description');
  String get serviceExternalPartnerServiceTitle => translate('service_external_partner_service_title');
  String get serviceExternalPartnerServiceDescription => translate('service_external_partner_service_description');
  String get serviceCooperationAndPartnershipTitle => translate('service_cooperation_and_partnership_title');
  String get serviceCooperationAndPartnershipDescription => translate('service_cooperation_and_partnership_description');
  String get serviceCooperationAndPartnershipButton => translate('service_cooperation_and_partnership_button');
  String get serviceFinancingTitle => translate('service_financing_title');
  String get serviceFinancingDescription => translate('service_financing_description');
  String get serviceFinancingButton => translate('service_financing_button');
  String get serviceConsultationAssistanceFormButton => translate('service_consultation_and_assistance_form_button');
  String get serviceEducationTrainingPublicTrainingButton => translate('service_education_and_training_public_training_button');
  String get serviceEducationTrainingInHouseButton => translate('service_education_and_training_in_house_training_button');
  String get serviceWebsiteDatabasePartnerButton => translate('service_website_database_partner_button');
  String get serviceExternalPartnerServiceVisitButton => translate('service_external_partner_service_visit_button');
  String get registrationSameAddressLabel => translate('registration_same_address_label');
  String get workPlanAcceleration => translate('work_plan_acceleration');
  String get workPlanInclusion => translate('work_plan_inclusion');
  String get workPlanCompetence => translate('work_plan_competence');
  String get workPlanTechnology => translate('work_plan_technology');
  String get workPlanSustainability => translate('work_plan_sustainability');
  String get name => translate('name');
  String get position => translate('position');
  String get email => translate('email');
  String get contactNumber => translate('contact_number');
  String get idMemberABUPI => translate('ABUPI_member_id');
  String get subject => translate('subject');
  String get problemDescription => translate('problem_description');
  String get templatePrefixEmailConsultationAndAssistance => translate('template_prefix_email_consultation_and_assistance');
  String get agree => translate('agree');
  String get consultationAssistanceTNCDescription => translate('consultation_assistance_tnc_description');
  String get category => translate('category');
  String get chooseCategory => translate('choose_category');
  String get emptyData => translate('empty_data');
  String get downloadNewsletter => translate('download_newsletter');
  String get shareToWhatsapp => translate('share_to_whatsapp');
  String get newsletterInformation => translate('newsletter_information');
  String get companiesThatTrustABUPI => translate('companies_that_trust_abupi');
  String get abstract => translate('abstract');
  String get seeAbstract => translate('see_abstract');
  String get formContactTitle => translate('form_contact_title');
  String get formContactFirstName => translate('form_contact_first_name');
  String get formContactLastName => translate('form_contact_last_name');
  String get formContactEmail => translate('form_contact_email');
  String get formContactMessage => translate('form_contact_message');
  String get send => translate('send');
  String get contactUsSuccess => translate('contact_us_success');
  String get registrationSuccess => translate('registration_success');
  String get consultationAssistanceSuccess => translate('consultation_assistance_success');
  String get serviceJoinTitle => translate('service_join_title');
  String get serviceJoinDescription => translate('service_join_description');
  String get searchJournalPlaceholder => translate('search_journal_placeholder');
  String get sendJournal => translate('send_journal');
  String get formJournalTitle => translate('form_journal_title');
  String get formJournalNamePlaceholder => translate('form_journal_name_placeholder');
  String get formJournalPhoneNumberPlaceholder => translate('form_journal_phone_number_placeholder');
  String get formJournalCompanyNameTitle => translate('form_journal_company_name_title');
  String get formJournalCompanyNamePlaceholder => translate('form_journal_company_name_placeholder');
  String get formJournalCompanyAddressTitle => translate('form_journal_company_address_title');
  String get formJournalCompanyAddressPlaceholder => translate('form_journal_company_address_placeholder');
  String get formJournalAbstractTitle => translate('form_journal_abstract_title');
  String get formJournalAbstractPlaceholder => translate('form_journal_abstract_placeholder');
  String get formJournalFileTitle => translate('form_journal_file_title');
  String get formJournalTNCChecklist => translate('form_journal_tnc_checklist');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['id', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
