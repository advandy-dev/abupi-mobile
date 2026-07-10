import 'dart:convert';

import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TechnologyProgramScreen extends StatefulWidget {
  const TechnologyProgramScreen({super.key});

  @override
  State<TechnologyProgramScreen> createState() => _TechnologyProgramScreenState();
}

class _TechnologyProgramScreenState extends State<TechnologyProgramScreen> {
  Map<String, dynamic>? _pageData;
  String _title = 'Teknologi';
  String? _currentLanguage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context);
    final newLanguage = l10n?.locale.languageCode ?? 'id';

    if (_currentLanguage != newLanguage) {
      _currentLanguage = newLanguage;
      _loadData();
    }
  }

  String _getSlugForLanguage(String language) {
    return language == 'en' ? 'work-program-technology' : 'program-kerja-teknologi';
  }

  Future<void> _loadData() async {
    if (_currentLanguage == null) return;

    final slug = _getSlugForLanguage(_currentLanguage!);

    try {
      final response = await WordPressApi.getPages(slug);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isNotEmpty) {
          final data = jsonList.first as Map<String, dynamic>;

          setState(() {
            _pageData = data;
            _title = data['acf']['strategic_title'] ?? 'Teknologi';
          });
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    // Extract image URL from ACF data or use a dummy placeholder
    final acfImage = _pageData?['acf']?['image'];
    final imageUrl = (acfImage != null && acfImage.toString().isNotEmpty)
        ? acfImage.toString()
        : 'https://placehold.co/600x400/png?text=ABUPI+Teknologi';

    // Process Strategy Description
    String? rawStrategicDesc = _pageData?['acf']['strategic_description'];
    String displayStrategicDesc = (rawStrategicDesc?.isEmpty ?? true)
        ? (l10n?.workPlanEmptyInfo ?? 'Informasi belum tersedia.')
        : rawStrategicDesc!;

    // Process Target Title
    String displayTargetTitle = _pageData?['acf']['target_title'] ?? 'SASARAN';
    if (displayTargetTitle.isEmpty) displayTargetTitle = 'SASARAN';

    // Process Target Description
    String? rawTargetDesc = _pageData?['acf']['target_description'];
    String displayTargetDesc = (rawTargetDesc?.isEmpty ?? true)
        ? (l10n?.workPlanEmptyInfo ?? 'Informasi belum tersedia.')
        : rawTargetDesc!;

    // Extract Work Programs iteratively
    final List<String> workPrograms = [];
    if (_pageData?['acf'] != null) {
      final acf = _pageData!['acf'];
      for (int i = 1; i <= 20; i++) {
        final key = 'work_program_$i';
        final value = acf[key];
        if (value != null && value.toString().trim().isNotEmpty) {
          workPrograms.add(value.toString().trim());
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          _title.isEmpty ? 'Teknologi' : _title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          width: double.infinity,
                          height: 360,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: 360,
                            color: Colors.grey.shade200,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: 360,
                            color: Colors.grey.shade400,
                            child: const Center(
                              child: Icon(
                                Icons.broken_image,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        (l10n?.strategy ?? '').isNotEmpty ? l10n!.strategy.toUpperCase() : 'STRATEGI',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        displayStrategicDesc,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        displayTargetTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        displayTargetDesc,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n?.workPlan ?? 'Program Kerja',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (workPrograms.isEmpty)
                        Text(
                          l10n?.emptyWorkPlanList ?? 'Belum ada daftar program kerja.',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      else
                        ...workPrograms.map((program) => Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.deepPurple,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      program,
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        }
      ),
    );
  }
}
