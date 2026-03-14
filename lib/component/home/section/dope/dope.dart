import 'package:abupi/main.dart';
import 'package:flutter/material.dart';
import 'package:abupi/component/home/section/dope/dope_card.dart';
import 'package:abupi/models/dope.dart';

class DopeSection extends StatelessWidget {

  const DopeSection({super.key});

  static final List<Dope> _dopeList = [
    Dope(
      title: 'Regulator',
      imageURL: 'https://www.abupi.or.id/wp-content/uploads/2023/03/Icon-Regulator.png',
      url: AbupiApp.regulatorRoute,
    ),
    Dope(
      title: 'Regulasi',
      imageURL: 'https://www.abupi.or.id/wp-content/uploads/2023/01/Icon-Regulasi-150x150.png',
      url: AbupiApp.externalRegulationRoute,
    ),
    Dope(
      title: 'Daftar Anggota',
      imageURL: 'https://www.abupi.or.id/wp-content/uploads/2023/01/Icon-Anggota-1-150x150.png',
      url: '/anggota-abupi',
    ),
    Dope(
      title: 'Agenda',
      imageURL: 'https://www.abupi.or.id/wp-content/uploads/2023/01/Icon-Agenda-150x150.png',
      url: '/posts',
    ),
  ];

  void _onTapDope(BuildContext context, String url) {
    Navigator.pushNamed(
      context,
      url,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _dopeList.map((dope) => DopeCard(
          title: dope.title,
          image: dope.imageURL,
          onTap: () => _onTapDope(context, dope.url),
        )).toList(),
      ),
    );
  }
}
