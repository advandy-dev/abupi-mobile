import 'package:abupi/util/launch_url.dart';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/models/regulator.dart';
import 'package:flutter/material.dart';

class RegulatorScreen extends StatefulWidget {
  const RegulatorScreen({super.key});

  @override
  _RegulatorScreen createState() => _RegulatorScreen();
}

class _RegulatorScreen extends State<RegulatorScreen> {
  final List<Regulator> _regulators = [
    Regulator(
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/KEMENKOMARVEST-300x210-1.png',
      name: 'KEMENTERIAN KOORDINATOR BIDANG KEMARITIMAN DAN INVESTASI',
      name_en: 'MINISTRY OF COORDINATOR MARITIME AFFAIRS AND INVESTMENT',
      address: 'Jl. MH. Thamrin No.8, Jakarta Pusat 10340, Indonesia.',
      phone: '(021) 23951100',
      fax: '(021) 3141790',
      email: 'humas@maritim.go.id',
      website: 'maritim.go.id',
    ),
    Regulator(
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/KEMENHUB-300x210-1.png',
      name: 'KEMENTERIAN PERHUBUNGAN REPUBLIK INDONESIA',
      name_en: 'MINISTRY OF TRANSPORTATION OF THE REPUBLIC OF INDONESIA',
      address: 'Jl. Medan Merdeka Barat No. 8 Jakarta Pusat DKI Jakarta 10110',
      phone: '(021) 23951100',
      fax: '(021) 3141790',
      callCenter: '151',
      email: 'info151@dephub.go.id',
      website: 'dephub.go.id',
    ),
    Regulator(
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/kkp2-300x300-1.png',
      name: 'KEMENTERIAN KELAUTAN DAN PERIKANAN',
      name_en: 'MINISTRY OF MARINE AFFAIRS AND FISHERIES',
      address: 'Medan Merdeka Timur No.16 Jakarta Pusat',
      phone: '(021) 3519070',
      fax: '(021) 3864293',
      callCenter: '141',
      email: 'info151@dephub.go.id',
      website: 'kkp.go.id',
    ),
    Regulator(
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/KEMENKEU-300x210-1.png',
      name: 'KEMENTERIAN KEUANGAN REPUBLIK INDONESIA',
      name_en: 'MINISTRY OF FINANCE OF THE REPUBLIC OF INDONESIA',
      address: 'Gedung Djuanda I, Kementerian Keuangan, Jl. Dr. Wahidin Raya No.1, Pasar Baru, Sawah Besar, Central Jakarta City, Jakarta 10710',
      phone: '(021) 3449230',
      callCenter: '134',
      email: 'kemenkeu.prime@kemenkeu.go.id',
      website: 'kemenkeu.go.id',
    ),
    Regulator(
      imageURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/lklhk2-300x300-1.png',
      name: 'KEMENTERIAN LINGKUNGAN HIDUP DAN KEHUTANAN',
      name_en: 'MINISTRY OF ENVIRONMENT AND FORESTRY',
      address: 'Jl. Pejompongan Raya No.1, RT.1/RW.3, Bend. Hilir, Kecamatan Tanah Abang, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10270',
      phone: '(021) 5704501',
      callCenter: '134',
      email: 'pusdatin@menlhk.go.id',
      website: 'https://www.menlhk.go.id/kemenkeu.go.id',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: const Text(
          'Regulator',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _regulators.length,
        itemBuilder: (context, index) {
          return _buildRegulatorItem(context, _regulators[index]);
        },
      ),
    );
  }

  Widget _buildRegulatorItem(BuildContext context, Regulator regulator) {
    final l10n = AppLocalizations.of(context);
    final language = l10n?.language;

    var phoneFaxText = '';
    var phone = '${l10n?.phoneShort ?? 'Telp'}: ${regulator.phone}';

    if (regulator.fax != null && regulator.fax!.isNotEmpty) {
      phoneFaxText = '$phone – Fax. ${regulator.fax}';
    } else {
      phoneFaxText = phone;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Name/Title
            Text(
              language == null || language == 'id' ? regulator.name : regulator.name_en,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo/Image
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: regulator.imageURL.isNotEmpty ? 
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        regulator.imageURL,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.business,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
                    ) : const Icon(
                      Icons.business,
                      size: 60,
                      color: Colors.grey,
                    ),
                ),
                const SizedBox(width: 20),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Address
                      Text(
                        regulator.address,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF555555),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Phone and Fax
                      Text(
                        phoneFaxText,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF555555),
                        ),
                      ),
                      if (regulator.callCenter != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Call Center: ${regulator.callCenter}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF555555),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Email & Website buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => launchEmail([regulator.email]),
                    icon: const Icon(Icons.email_outlined, size: 18),
                    label: const Text('Email'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE2642A),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => launchWebsite(regulator.website),
                    icon: const Icon(Icons.language, size: 18),
                    label: const Text('Website'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE2642A),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}
