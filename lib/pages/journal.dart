import 'dart:convert';

import 'package:abupi/arguments/pdf_args.dart';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/main.dart';
import 'package:abupi/models/journal.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:flutter/material.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  bool _isLoading = false;
  List<Journal> _journalList = [];

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
      final response = await WordPressApi.getJournals();

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isNotEmpty) {
          try {
            var journals = jsonList.map((item) {
              final acf = item['acf'];
              return Journal(
                title: acf['title'],
                journal: acf['journal'],
              );
            }).toList();

            setState(() {
              _journalList = journals;
              _isLoading = false;
            });
          } catch (e) {
            debugPrint('error journal list $e');
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
          l10n?.journal ?? 'Jurnal',
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
        itemCount: _journalList.length,
        itemBuilder: (context, index) {
          final journal = _journalList[index];
          return _buildMenuItem(context, journal);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, Journal journal) {
    final l10n = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            const Icon(
              Icons.description_outlined,
              color: Color(0xFF2e2f7f),
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                journal.title,
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
              onPressed: () => Navigator.pushNamed(context, AbupiApp.pdfRoute, arguments: PDFScreenArguments(url: journal.journal)),
              child: Text(
                l10n?.see ?? 'Lihat',
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}