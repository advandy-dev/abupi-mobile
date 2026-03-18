import 'package:abupi/arguments/pdf_args.dart';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/main.dart';
import 'package:flutter/material.dart';

class WorkPlanScreen extends StatelessWidget {
  const WorkPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.workPlan ?? 'Program Kerja',
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
      body: ListView(
        children: [
          _buildMenuItem(
            context,
            icon: Icons.account_balance_outlined,
            title: 'Regulator',
            onTap: () {
              Navigator.pushNamed(context, AbupiApp.regulatorRoute);
            },
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            icon: Icons.policy_outlined,
            title: l10n?.externalRegulation ?? 'Regulasi Eksternal',
            onTap: () {
              Navigator.pushNamed(context, AbupiApp.externalRegulationRoute);
            },
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            icon: Icons.safety_divider,
            title: l10n?.inclusion ?? 'Inklusi',
            onTap: () {
              // TODO inclusion page
            },
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            icon: Icons.people,
            title: 'SDM, Digitalisasi & Berkelanjutan',
            onTap: () {
              // TODO SDM page
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF2e2f7f),
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 60,
      color: Colors.grey.shade300,
    );
  }
}
