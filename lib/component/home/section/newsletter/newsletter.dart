import 'package:abupi/l10n/locale_provider.dart';
import 'package:flutter/material.dart';

class NewsletterSection extends StatefulWidget {
  const NewsletterSection({super.key});

  @override
  State<NewsletterSection> createState() => _NewsletterSectionState();
}

class _NewsletterSectionState extends State<NewsletterSection> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF5C94EC), // Light Blue
            Color(0xFF2D5FB7), // Darker Blue
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
              borderRadius: const BorderRadius.all(Radius.circular(16))
            ),
            child: const Center(
              child: Text(
                'ABUPI News Jan 2026',
                style: TextStyle(color: Colors.white),
              ),
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
          const Text(
            'ABUPI Newsletter Jan 2026',
            style: TextStyle(
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
            ),            onPressed: () => {},
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