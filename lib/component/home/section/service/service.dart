import 'package:abupi/arguments/home_args.dart';
import 'package:abupi/arguments/service_args.dart';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/main.dart';
import 'package:flutter/material.dart';

class ServiceSection extends StatelessWidget {

  const ServiceSection({super.key});

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
          Text(
            l10n?.service ?? "Layanan",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          _buildItem(
            '🧭',
            (l10n?.serviceConsultationAssistanceTitle ?? ''),
            (l10n?.serviceConsultationAssistanceDescription ?? ''),
            () => Navigator.pushNamedAndRemoveUntil(
              context,
              AbupiApp.homeRoute,
              (route) => false,
              arguments: HomeScreenArguments(
                initialIndex: 2,
                service: ServiceScreenArguments(service: 0),
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildItem(
            '📘',
            (l10n?.serviceEducationTrainingTitle ?? ''),
            (l10n?.serviceEducationTrainingDescription ?? ''),
            () => Navigator.pushNamedAndRemoveUntil(
              context,
              AbupiApp.homeRoute,
              (route) => false,
              arguments: HomeScreenArguments(
                initialIndex: 2,
                service: ServiceScreenArguments(service: 1),
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildItem(
            '🗂️',
            (l10n?.serviceWebsiteDatabasePartnerTitle ?? ''),
            (l10n?.serviceWebsiteDatabasePartnerDescription ?? ''),
            () => Navigator.pushNamedAndRemoveUntil(
              context,
              AbupiApp.homeRoute,
              (route) => false,
              arguments: HomeScreenArguments(
                initialIndex: 2,
                service: ServiceScreenArguments(service: 2),
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildItem(
            '🤝',
            (l10n?.serviceExternalPartnerServiceTitle ?? ''),
            (l10n?.serviceExternalPartnerServiceDescription ?? ''),
            () => Navigator.pushNamedAndRemoveUntil(
              context,
              AbupiApp.homeRoute,
              (route) => false,
              arguments: HomeScreenArguments(
                initialIndex: 2,
                service: ServiceScreenArguments(service: 3),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

Widget _buildItem(
    String icon,
    String title,
    String description,
    VoidCallback onClick,
    ) {
  return InkWell(
    onTap: onClick,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.purple.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
          // This sits nicely on the far right
          const Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
        ],
      ),
    ),
  );
}