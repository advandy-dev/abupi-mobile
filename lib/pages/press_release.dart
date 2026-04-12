import 'dart:convert';

import 'package:abupi/arguments/pdf_args.dart';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/main.dart';
import 'package:abupi/models/press_release.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PressReleaseScreen extends StatefulWidget {
  const PressReleaseScreen({super.key});

  @override
  State<PressReleaseScreen> createState() => _PressReleaseScreenState();
}

class _PressReleaseScreenState extends State<PressReleaseScreen> {
  bool _isLoading = false;
  List<PressRelease> _pressReleaseList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await WordPressApi.getPressRelease();

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isNotEmpty) {
          try {
            var pressReleases = jsonList.map((item) {
              final acf = item['acf'];
              return PressRelease(
                title: acf['title'],
                file: acf['press_release_file'],
                releaseDate: acf['release_date']
              );
            }).toList();

            setState(() {
              _pressReleaseList = pressReleases;
              _isLoading = false;
            });
          } catch (e) {
            debugPrint('error press release list $e');
            setState(() {
              _isLoading = false;
            });
          }
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.pressRelease ?? 'Siaran Pers',
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
      backgroundColor: Colors.white,
      body: _isLoading ?
      const Center(
        child: CircularProgressIndicator(color: Color(0xFF2e2f7f)),
      ) :
      ListView.separated(
        padding: const EdgeInsets.only(top: 16),
        itemCount: _pressReleaseList.length,
        itemBuilder: (context, index) {
          final pressRelease = _pressReleaseList[index];
          return _buildMenuItem(context, pressRelease);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, PressRelease pressRelease) {
    final l10n = AppLocalizations.of(context);
    final language = l10n?.locale.languageCode;

    final dateTime = DateTime.parse(pressRelease.releaseDate);
    final month = DateFormat('MMM', language).format(dateTime);
    final date = DateFormat('d').format(dateTime);

    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 6,
              color: Colors.purple,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          month,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade900,
                          ),
                        ),
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        pressRelease.title,
                        maxLines: 4, // Set the maximum number of lines
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Color(0xFFF2C21A)),
                      ),
                      onPressed: () => Navigator.pushNamed(context, AbupiApp.pdfRoute, arguments: PDFScreenArguments(url: pressRelease.file)),
                      child: Text(
                        l10n?.see ?? 'Lihat',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}