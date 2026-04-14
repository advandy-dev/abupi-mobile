import 'dart:convert';

import 'package:abupi/arguments/pdf_args.dart';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/main.dart';
import 'package:abupi/models/newsletter.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class NewsletterSection extends StatefulWidget {
  const NewsletterSection({super.key});

  @override
  State<NewsletterSection> createState() => _NewsletterSectionState();
}

class _NewsletterSectionState extends State<NewsletterSection> {
  bool _isLoading = false;
  Newsletter? _newsletter;

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
      final response = await WordPressApi.getNewsletter(1);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isNotEmpty) {
          try {
            var newsletter = jsonList.map((item) {
              final acf = item['acf'];
              return Newsletter(
                title: acf['title'],
                date: acf['date'],
                image: acf['image'],
                fileURL: acf['newsletter_file'],
              );
            }).toList();

            setState(() {
              _newsletter = newsletter[0];
              _isLoading = false;
            });
          } catch (e) {
            debugPrint('error newsletter list $e');
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
    final language = l10n?.locale.languageCode;

    String monthAndYear = '';
    if (_newsletter != null) {
      final dateTime = DateTime.parse(_newsletter?.date ?? '');
      monthAndYear = DateFormat('MMMM yyyy', language).format(dateTime);
    }

    if (_isLoading) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2f3fa3),
              Color(0xFF1fa2b1),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFF173B8A).withOpacity(0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  border: Border.all(
                    color: Colors.grey,
                    width: 4.0, // Set border thickness here
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: 80,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFF173B8A).withOpacity(0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: 200,
                height: 14,
                decoration: BoxDecoration(
                  color: const Color(0xFF173B8A).withOpacity(0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: 150,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF173B8A).withOpacity(0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2f3fa3),
            Color(0xFF1fa2b1),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFF173B8A).withOpacity(0.5),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              border: Border.all(
                color: Colors.grey,
                width: 4.0, // Set border thickness here
              ),
            ),
            child: Center(
              child: InkWell(
                onTap: () => Navigator.pushNamed(
                    context,
                    AbupiApp.pdfRoute,
                    arguments: PDFScreenArguments(
                      url: _newsletter?.fileURL ?? '',
                    ),
                ),
                child: Image.network(
                  _newsletter?.image ?? '',
                  fit: BoxFit.fill,
                ),
              )
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n?.newsletter ?? 'Buletin',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'ABUPI Newsletter $monthAndYear',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 2, // The "height" of the shadow
              backgroundColor: const Color(0xFFF2C21A), // Your light blue
              foregroundColor: Colors.white, // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: () => Navigator.pushNamed(
              context,
              AbupiApp.newsletterRoute,
            ),
            child: Text(
              l10n?.readMore ?? 'Selengkapnya',
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}