import 'package:abupi/component/home/section/about-us/about_us.dart';
import 'package:abupi/component/home/section/event/event.dart';
import 'package:abupi/component/home/section/maps/maps.dart';
import 'package:abupi/component/home/section/news/news.dart';
import 'package:abupi/component/home/section/partnership/partnership.dart';
import 'package:abupi/component/language_selector.dart';
import 'package:abupi/main.dart';
import 'package:flutter/material.dart';
import 'package:abupi/component/home/section/banner/banner.dart' as banner_section;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 72,
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.network(
            'https://www.abupi.or.id/wp-content/uploads/2024/08/cropped-cropped-LOGO-ABUPI-HIRES-square-180x180.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Container(
              color: colorScheme.surfaceContainerHighest,
            ),
          ),
        ),
        title: null,
        actions: const [
          LanguageSelectorButton(),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 100,
        shape: const StadiumBorder(),
        onPressed: () {
          Navigator.pushNamed(context, AbupiApp.registrationRoute);
        },
        backgroundColor: const Color(0xFF632f9c),
        label: const Text('JOIN ABUPI', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildBody() {
    return ListView(
      controller: _scrollController,
      children: const [
        banner_section.Banner(),
        AboutUsSection(),
        SizedBox(height: 4),
        EventSection(),
        SizedBox(height: 4),
        NewsSection(),
        SizedBox(height: 4),
        MapsSection(),
        SizedBox(height: 8),
        Partnership(),
        SizedBox(height: 75),
      ],
    );
  }
}