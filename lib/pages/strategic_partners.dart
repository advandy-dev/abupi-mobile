import 'package:abupi/helper/launch_url.dart';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/models/strategic_partners.dart';
import 'package:flutter/material.dart';

class StrategicPartnersScreen extends StatefulWidget {
  const StrategicPartnersScreen({super.key});

  @override
  _StrategicPartnersScreen createState() => _StrategicPartnersScreen();
}

class _StrategicPartnersScreen extends State<StrategicPartnersScreen> {
  final List<StrategicPartners> _strategicPartners = [
    StrategicPartners(
      imageURL: 'https://www.abupi.or.id/wp-content/uploads/2023/01/LOGO-INSA-300x282.png',
      name: 'INDONESIAN NATIONAL SHIPOWNER’S ASSOCIATION',
      address: 'Tanah Abang III No 10 Jakarta Pusat',
      phone: '(021) 3850993, (021) 3447149, (021) 3849522',
      fax: '(021) 3849522',
      email: 'info@insa.or.id',
      website: 'insa.or.id',
    ),
    StrategicPartners(
      imageURL: 'https://www.abupi.or.id/wp-content/uploads/2023/01/LOGO-IPERINDO-HITAM-300x80.png',
      name: 'INDONESIA SHIPBUILDING & OFFSHORE ASSOCIATION',
      address: 'Komplek Griya Inti Sentosa, Jl. Griya Agung No.77, RT.2/RW.20, Sunter Agung, Kec. Tj. Priok, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14350',
      phone: '(021) 6404253',
      email: 'iperindo@indo.net.id',
      website: 'iperindo.org',
    ),
    StrategicPartners(
      imageURL: 'https://www.abupi.or.id/wp-content/uploads/2023/01/LOGO-ISAA-300x118.png',
      name: 'INDONESIA SHIPPING AGENCIES ASSOCIATION',
      website: 'dppisaa.blogspot.com',
    ),
    StrategicPartners(
      imageURL: 'https://www.abupi.or.id/wp-content/uploads/2023/01/LOGO-HAPI-300x294.png',
      name: 'HIMPUNAN AHLI PELABUHAN INDONESIA',
    ),
    StrategicPartners(
      imageURL: 'https://www.abupi.or.id/wp-content/uploads/2023/01/LOGO-ALFI-300x268.png',
      name: 'ASOSIASI LOGISTIK DAN FORWARDER INDONESIA',
      address: 'Kantor Taman E3.Unit D3, Lantai 2, Jl. Dr. Ide Anak Agung Gde Agung, Kawasan Mega Kuningan, Jakarta 12950 - Indonesia',
      phone: '(021) 5795 6601',
      email: 'secretariat@ilfa.co.id',
      website: 'www.ilfa.or.id',
    ),
    StrategicPartners(
      imageURL: 'https://www.abupi.or.id/wp-content/uploads/2023/01/LOGO-APBMI-300x300.png',
      name: 'ASOSIASI PERUSAHAAN BONGKAR MUAT INDONESIA',
      address: 'Jl. Swasembada Timur XI No.25, RT.12/RW.10, Kb. Bawang, Kec. Tj. Priok, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14320',
      phone: '(021) 816 1357 278',
      email: 'info@apbmi.or.id',
      website: 'www.apbmi.or.id',
    ),
    StrategicPartners(
      imageURL: 'https://www.abupi.or.id/wp-content/uploads/2023/01/LOGO-INAMPA-300x246.png',
      name: 'INDONESIAN MARITIME PILOTS ASSOCIATION',
      address: 'Jl. Matahari No.4, RT.1/RW.13, Rawabadak Utara, Kec. Koja, Jakarta Utara, Daerah Khusus Ibukota Jakarta 14230',
      phone: '(021) 4390 0975',
      email: 'inampadpp_jakarta@yahoo.co.id',
      website: 'www.inampa3.org',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.strategicPartners ?? 'Mitra Strategis',
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _strategicPartners.length,
        itemBuilder: (context, index) {
          return _buildRegulatorItem(context, _strategicPartners[index]);
        },
      ),
    );
  }

  Widget _buildRegulatorItem(BuildContext context, StrategicPartners partner) {
    final l10n = AppLocalizations.of(context);
    var phoneFaxText = '';
    final isPhoneNotEmpty = partner.phone != null && partner.phone!.isNotEmpty;

    if (isPhoneNotEmpty) {
      phoneFaxText = '${l10n?.phoneShort ?? 'Telp'}: ${partner.phone}';
    }
    if (partner.fax != null && partner.fax!.isNotEmpty) {
      phoneFaxText = '$phoneFaxText ${isPhoneNotEmpty ? '- ' : ''}Fax. ${partner.fax}';
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
                partner.name,
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
                    child: partner.imageURL.isNotEmpty ?
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        partner.imageURL,
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
                        if (partner.address != null) ...[
                        // Address
                        Text(
                          partner.address ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF555555),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ],
                        // Phone and Fax
                        Text(
                          phoneFaxText,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF555555),
                          ),
                        ),
                        if (partner.callCenter != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Call Center: ${partner.callCenter}',
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
                  if (partner.email != null) ...[
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => launchEmail([partner.email ?? '']),
                      icon: const Icon(Icons.email_outlined, size: 18),
                      label: const Text('Email'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE2642A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  )],
                  const SizedBox(width: 12),
                  if (partner.website != null) ...[
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => launchWebsite(partner.website ?? ''),
                      icon: const Icon(Icons.language, size: 18),
                      label: const Text('Website'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE2642A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),]
                ],
              ),
            ],
          )
      ),
    );
  }
}
