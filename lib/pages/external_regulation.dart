import 'package:abupi/arguments/pdf_args.dart';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/main.dart';
import 'package:abupi/models/external_regulation.dart';
import 'package:flutter/material.dart';

class ExternalRegulationScreen extends StatelessWidget {
  const ExternalRegulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final List<ExternalRegulation> externalRegulations = [
      ExternalRegulation(
        name: 'UNDANG-UNDANG NO. 17 TAHUN 2008 TENTANG PELAYARAN',
        url: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/02/uu_17_tahun_2008-Tentang-Pelayaran.pdf',
      ),
      ExternalRegulation(
        name: 'PERATURAN PEMERINTAH NO. 61 TAHUN 2009 TENTANG KEPELABUHANAN',
        url: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/02/PP_No_61_2009-Tentang-Kepelabuhanan.pdf',
      ),
      ExternalRegulation(
        name: 'PERATURAN PEMERINTAH NO. 64 TAHUN 2015 TENTANG PERUBAHAN ATAS PP NO. 61 TAHUN 2009 TENTANG KEPELABUHANAN',
        url: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/02/PP_64_Tahun_2015-Tentang-Perubahan-PP-61-Tahun-2009-Ttg-Kepelabuhanan.pdf',
      ),
      ExternalRegulation(
        name: 'PERATURAN MENTERI PERHUBUNGAN RI NO. PM 48 TAHUN 2021 TENTANG KONSESI DAN KERJASAMA BENTUK LAINNYA ANTARA PENYELENGGARA PELABUHAN DENGAN BADAN USAHA PELABUHAN DI BIDANG KEPELABUHANAN',
        url: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/02/PM-48-TAHUN-2021-Konsesi-dan-Kerjasama-Bentuk-lainnya.pdf',
      ),
      ExternalRegulation(
        name: 'PERATURAN MENTERI PERHUBUNGAN RI NO. PM 50 TAHUN 2021 TENTANG PENYELENGGARAAN PELABUHAN LAUT',
        url: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/02/PM_50_Tahun_2021_JDIH_Penyelenggaraan-Pelabuhan-Laut.pdf',
      ),
      ExternalRegulation(
        name: 'PERATURAN MENTERI PERHUBUNGAN RI NO. PM 52 TAHUN 2021 TENTANG TERMINAL KHUSUS DAN TRMINAL UNTUK KEPENTINGAN SENDIRI',
        url: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/02/PM_52_Tahun_2021_JDIH_TERSUS_TUKS.pdf',
      ),
      ExternalRegulation(
        name: 'PERATURAN MENTERI PERHUBUNGAN RI NO. PM 5 TAHUN 2022 TENTANG TATA CARA PEMBERIAN KONSESI DAN KERJASAMA MELALUI MEKANISME PELELANGAN',
        url: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/02/PM-5-TAHUN-2022-Konsesi-Melaului-Pelelangan.pdf',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.externalRegulation ?? 'Regulasi Eksternal',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: const Color(0xFFE3E3E3),
        child: ListView.separated(
          itemCount: externalRegulations.length,
          itemBuilder: (context, index) {
            return _buildMenuItem(context, externalRegulations[index]);
          },
          padding: const EdgeInsets.symmetric(vertical: 16),
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, ExternalRegulation externalRegulation) {
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
                externalRegulation.name,
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
              onPressed: () => Navigator.pushNamed(context, AbupiApp.pdfRoute, arguments: PDFScreenArguments(url: externalRegulation.url)),
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
