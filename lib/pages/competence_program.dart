import 'package:abupi/l10n/locale_provider.dart';
import 'package:flutter/material.dart';

class CompetenceProgramScreen extends StatefulWidget {
  const CompetenceProgramScreen({super.key});

  @override
  State<CompetenceProgramScreen> createState() => _CompetenceProgramScreenState();
}

class _CompetenceProgramScreenState extends State<CompetenceProgramScreen> {
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.newsletter ?? 'Buletin',
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
                          /*child: Image.network(
                    _selectedNewsletter?.image ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 360,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(
                          color: Colors.grey.shade500,
                          child: const Center(
                            child: Icon(
                              Icons.event_rounded,
                              size: 32,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey.shade500,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                  ),*/
                          child: Container(
                            width: double.infinity,
                            height: 360,
                            color: Colors.grey.shade400,
                            child: const Center(
                              child: Text('Image/Video'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'STRATEGI',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        const Text(
                          'Informasi belum tersedia.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'SASARAN',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        const Text(
                          'Informasi belum tersedia.',
                          style: TextStyle(
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
                        const Text(
                          'Program Kerja',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: Colors.deepPurple,
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  'Membangun kolaborasi dan kemitraan antar anggota, pemerintah dan stakeholder',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
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