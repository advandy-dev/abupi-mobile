import 'package:abupi/arguments/event_detail_args.dart';
import 'package:abupi/pages/about_us.dart';
import 'package:abupi/pages/board_of_directors.dart';
import 'package:abupi/pages/contact_us.dart';
import 'package:abupi/pages/event_detail.dart';
import 'package:abupi/pages/gallery.dart';
import 'package:abupi/pages/main_navigation.dart';
import 'package:abupi/pages/member_list.dart';
import 'package:abupi/pages/news.dart';
import 'package:abupi/pages/pdf.dart';
import 'package:abupi/pages/organization.dart';
import 'package:abupi/pages/regional_board_of_director.dart';
import 'package:abupi/pages/registration.dart';
import 'package:abupi/pages/regulation.dart';
import 'package:abupi/pages/media.dart';
import 'package:abupi/pages/regulator.dart';
import 'package:abupi/pages/external_regulation.dart';
import 'package:abupi/pages/strategic_partners.dart';
import 'package:flutter/material.dart';
import 'package:abupi/pages/work_partners.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:abupi/l10n/locale_provider.dart';

import 'arguments/pdf_args.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: const AbupiApp(),
    ),
  );
}

class AbupiApp extends StatelessWidget {
  const AbupiApp({super.key});

  // Route names
  static const String homeRoute = '/';
  static const String organizationRoute = '/organisasi';
  static const String regulationRoute = '/regulasi';
  static const String mediaRoute = '/media';
  static const String contactUsRoute = '/hubungi-kami';
  static const String postDetailRoute = '/post-detail';
  static const String serviceRoute = '/layanan';
  static const String pdfRoute = '/pdf';
  static const String regulatorRoute = '/regulator';
  static const String externalRegulationRoute = '/regulasi-eksternal';
  static const String strategicPartnersRoute = '/mitra-strategis';
  static const String workPartnersRoute = '/mitra-kerja';
  static const String aboutUsRoute = '/tentang-kami';
  static const String memberListRoute = '/anggota-abupi';
  static const String boardOfDirectorsRoute = '/dewan-pengurus';
  static const String regionalBODRoute = '/koordinator-wilayah';
  static const String galeriRoute = '/galeri';
  static const String eventRoute = '/acara';
  static const String registrationRoute = '/register';
  static const String newsRoute = '/berita';

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      title: 'ABUPI',
      debugShowCheckedModeBanner: false,
      locale: localeProvider.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A5F),
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4FC3F7),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Roboto',
      ),
      themeMode: ThemeMode.system,
      initialRoute: homeRoute,
      onGenerateRoute: (settings) {
        if (settings.name != null && settings.name!.startsWith(eventRoute)) {
          final uri = Uri.parse(settings.name ?? '');
          final args = settings.arguments as EventDetailArguments;
          return MaterialPageRoute(
            builder: (context) => EventDetailScreen(
              id: uri.pathSegments.length > 1 ? int.parse(uri.pathSegments[1]) : 0,
              event: args.event,
            ),
          );
        }

        if (settings.name != null && settings.name!.startsWith(newsRoute)) {
          return MaterialPageRoute(
            builder: (context) => const NewsListScreen(),
          );
        }

        switch (settings.name) {
          case homeRoute:
            final initialIndex = settings.arguments as int?;
            return MaterialPageRoute(
              builder: (context) => MainNavigation(
                initialIndex: initialIndex ?? 0,
              ),
            );
          case organizationRoute:
            return MaterialPageRoute(
              builder: (context) => const OrganizationScreen(),
            );
          case regulationRoute:
            return MaterialPageRoute(
              builder: (context) => const RegulationScreen(),
            );
          case mediaRoute:
            return MaterialPageRoute(
              builder: (context) => const MediaScreen(),
            );
          case pdfRoute:
            final args = settings.arguments as PDFScreenArguments;
            return MaterialPageRoute(
              builder: (context) => PDFScreen(
                url: args.url,
              ),
            );
          case contactUsRoute:
            return MaterialPageRoute(
              builder: (context) => const ContactUsScreen(),
            );
          case regulatorRoute:
            return MaterialPageRoute(
              builder: (context) => const RegulatorScreen(),
            );
          case externalRegulationRoute:
            return MaterialPageRoute(
              builder: (context) => const ExternalRegulationScreen(),
            );
          case strategicPartnersRoute:
            return MaterialPageRoute(
              builder: (context) => const StrategicPartnersScreen(),
            );
          case workPartnersRoute:
            return MaterialPageRoute(
              builder: (context) => const WorkPartnersScreen(),
            );
          case aboutUsRoute:
            return MaterialPageRoute(
              builder: (context) => const AboutUsScreen(),
            );
          case memberListRoute:
            return MaterialPageRoute(
              builder: (context) => const MemberListScreen(),
            );
          case boardOfDirectorsRoute:
            return MaterialPageRoute(
              builder: (context) => const BoardOfDirectorsScreen(),
            );
          case regionalBODRoute:
            return MaterialPageRoute(
              builder: (context) => const RegionalBoardOfDirectorsScreen(),
            );
          case galeriRoute:
            return MaterialPageRoute(
              builder: (context) => const GalleryScreen(),
            );
          case registrationRoute:
            return MaterialPageRoute(
              builder: (context) => const RegistrationScreen(),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const MainNavigation(),
            );
        }
      },
    );
  }
}
