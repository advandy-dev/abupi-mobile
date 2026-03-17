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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 72,
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.network(
            'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/02/abupi-logo.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey,
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
      children: [
        const banner_section.Banner(),
        const AboutUsSection(),
        const SizedBox(height: 4),
        const EventSection(),
        const SizedBox(height: 4),
        const NewsSection(),
        const SizedBox(height: 4),
        const MapsSection(),
        const Partnership(),
        Container(height: 75, color: Colors.grey.shade200),
      ],
    );
  }
}