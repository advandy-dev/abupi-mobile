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
      'mission': 'Misi',
      'basis_foundation_abupi': 'Dasar Pendirian ABUPI',
      'basis_foundation_description_abupi': 'Dasar pendirian ABUPI adalah untuk mendukung program reformasi pelabuhan seperti yang diamanatkan pada Undang-undang No. 17 Tahun 2008 tentang Pelayaran dan Peraturan Pemerintah No. 61 Tahun 2009 tentang Kepelabuhanan.',
      'deed_of_establishment_abupi': 'Akta Pendirian ABUPI',
      'deed_of_establishment_description_abupi': 'ABUPI didirikan dengan akte pendirian No. 010 tanggal 16 Februari 2015 di hadapan Notaris Elly Rustam SH dan dikukuhkan dengan pengesahan dari Kementrian Hukum dan Hak Asasi Manusia Republik Indonesia No. AHU-001650.AH.01, Tahun 2015.',
      'vision_description': 'Sebagai badan usaha yang mengedepankan kerjasama antara Badan Usaha Pelabuhan (BUP), Terminal Untuk Kepentingan Sendiri (TUKS) dan Terminal Khusus (TerSus) dalam mendukung pembangunan sektor maritim di Indonesia.',
      'mission_description_1': 'Menghimpun, membina dan mengembangkan usaha para anggotanya untuk dapat lebih berperan serta di dalam meningkatkan pembangunan perekonomian nasional.',
      'mission_description_2': 'Melindungi kepentingan kegiatan Jasa Kepelabuhanan dengan menjunjung tinggi etika dan professionalisme para anggota dalam mengantisipasi perkembangan yang terjadi, baik secara Nasional maupun Internasional.',
      'mission_description_3': 'Melindungi kepentingan anggota dan mencegah timbulnya persaingan usaha yang tidak sehat dalam dunia usaha Jasa Kepelabuhanan.',
      'mission_description_4': 'Meningkatkan kemampuan serta pengetahuan sember daya manusia (SDM) para anggota di bidang Jasa Kepelabuhanan sejalan dengan kemajuan teknologi di berbagai bidang.',
      'form_registration_company_name_title': 'Nama Perusahaan',
      'form_registration_company_name_placeholder': 'PT Contoh Indonesia',
      'form_registration_pic_name_title': 'Nama PIC',
      'form_registration_pic_name_placeholder': 'Nama lengkap PIC',
      'form_registration_company_address_title': 'Alamat Perusahaan',
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
      'mission': 'Mission',
      'basis_foundation_abupi': 'Basis Foundation of ABUPI',
      'basis_foundation_description_abupi': 'The basis for establishing ABUPI is to support the port reform program as mandated by Law No. 17 of 2008 concerning Shipping and Government Regulation No. 61 of 2009 concerning Ports.',
      'deed_of_establishment_abupi': 'Deed of Establishment ABUPI',
      'deed_of_establishment_description_abupi': 'ABUPI was established with deed of establishment No. 010 dated February 16, 2015 before Notary Elly Rustam SH and confirmed with ratification from the Ministry of Law and Human Rights of the Republic of Indonesia No. AHU-001650.AH.01, Year 2015.',
      'vision_description': 'As a business entity that prioritizes cooperation between Port Business Entities (BUP), Terminals for Self-Use (TUKS) and Special Terminals (TerSus) in supporting the development of the maritime sector in Indonesia.',
      'mission_description_1': 'To gather, foster, and develop the businesses of its members so they can play a greater role in enhancing national economic development.',
      'mission_description_2': 'To protect the interests of port services by upholding the ethics and professionalism of its members in anticipating developments, both nationally and internationally.',
      'mission_description_3': 'To protect the interests of its members and prevent unfair business competition in the port services industry.',
      'mission_description_4': 'To improve the skills and knowledge of its members human resources in the port services sector in line with technological advances in various fields.',
      'form_registration_company_name_title': 'Company Name',
      'form_registration_company_name_placeholder': 'Example Company',
      'form_registration_pic_name_title': 'PIC Name',
      'form_registration_pic_name_placeholder': 'PIC fullname',
      'form_registration_company_address_title': 'Company Address',
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
  String get basisFoundationABUPI => translate('basis_foundation_abupi');
  String get deedEstablishmentABUPI => translate('deed_of_establishment_abupi');
  String get basisFoundationDescriptionABUPI => translate('basis_foundation_description_abupi');
  String get deedEstablishmentDescriptionABUPI => translate('deed_of_establishment_description_abupi');
  String get visionDescription => translate('vision_description');
  String get missionDescription1 => translate('mission_description_1');
  String get missionDescription2 => translate('mission_description_2');
  String get missionDescription3 => translate('mission_description_3');
  String get missionDescription4 => translate('mission_description_4');
  String get formRegistrationCompanyNameTitle => translate('form_registration_company_name_title');
  String get formRegistrationCompanyNamePlaceholder => translate('form_registration_company_name_placeholder');
  String get formRegistrationPicNameTitle => translate('form_registration_pic_name_title');
  String get formRegistrationPicNamePlaceholder => translate('form_registration_pic_name_placeholder');
  String get formRegistrationCompanyAddressTitle => translate('form_registration_company_address_title');
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
