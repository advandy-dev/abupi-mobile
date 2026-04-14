import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/main.dart';
import 'package:abupi/util/launch_url.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ServiceScreen extends StatefulWidget {
  final int? service;

  const ServiceScreen({super.key, this.service});

  @override
  _ServiceScreen createState() => _ServiceScreen();
}

class _ServiceScreen extends State<ServiceScreen> {

  @override
  void initState() {
    super.initState();
  }

  Widget _buildExpandableCapsule(
    BuildContext context, {
    required String title,
    required String icon,
    required bool initiallyExpanded,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(1, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: initiallyExpanded,
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(145, 179, 236, 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(icon, style: const TextStyle(fontSize: 20)),
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Color(0xFF333333),
              ),
            ),
            iconColor: const Color.fromRGBO(145, 179, 236, 1.0),
            collapsedIconColor: Colors.grey,
            backgroundColor: Colors.white,
            collapsedBackgroundColor: Colors.white,
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.service ?? 'Layanan',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            _buildExpandableCapsule(
              context,
              title: l10n?.serviceConsultationAssistanceTitle ?? '',
              icon: '🧭',
              initiallyExpanded: widget.service == 0,
              children: [
                const SizedBox(height: 8),
                Text(
                    l10n?.serviceConsultationAssistanceDescription ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Color(0xFF2e2f7f)),
                    ),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AbupiApp.consultationAndAssistanceFormRoute,
                    ),
                    child: Text(
                      l10n?.serviceConsultationAssistanceFormButton ?? '',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildExpandableCapsule(
              context,
              title: l10n?.serviceEducationTrainingTitle ?? '',
              icon: '📘',
              initiallyExpanded: widget.service == 1,
              children: [
                const SizedBox(height: 8),
                Text(
                  l10n?.serviceEducationTrainingDescription ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Color(0xFF2e2f7f)),
                      ),
                      onPressed: () => launchWebsite('https://www.instagram.com/port_learningcenter/'),
                      child: const Text(
                        'Port Learning Center',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Color(0xFF2e2f7f)),
                      ),
                      onPressed: () => launchWebsite('https://www.instagram.com/lsp_pelabuhan/'),
                      child: const Text(
                        'LSP Pelabuhan',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildExpandableCapsule(
              context,
              title: l10n?.serviceCooperationAndPartnershipTitle ?? '',
              icon: '🗂️',
              initiallyExpanded: widget.service == 2,
              children: [
                const SizedBox(height: 8),
                Text(
                  l10n?.serviceCooperationAndPartnershipDescription ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Color(0xFF2e2f7f)),
                    ),
                    onPressed: () => Navigator.pushNamed(context, AbupiApp.stakeholderRoute),
                    child: Text(
                      l10n?.serviceCooperationAndPartnershipButton ?? '',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildExpandableCapsule(
              context,
              title: l10n?.serviceFinancingTitle ?? '',
              icon: '🤝',
              initiallyExpanded: widget.service == 3,
              children: [
                const SizedBox(height: 8),
                Text(
                  l10n?.serviceFinancingDescription ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Color(0xFF2e2f7f)),
                    ),
                    onPressed: () => launchUrlString('https://wa.me/message/XRU4Y4HHCOK2K1'),
                    child: Text(
                      l10n?.serviceFinancingButton ?? '',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFF632f9c)),
                  minimumSize: WidgetStatePropertyAll<Size>(
                      Size(double.infinity, 42)
                  ),
                ),
                onPressed: () => Navigator.pushNamed(context, AbupiApp.registrationRoute),
                child: const Text(
                  'Join ABUPI',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
