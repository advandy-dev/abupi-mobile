import 'package:flutter/material.dart';
import 'package:abupi/pages/home.dart';
import 'package:abupi/pages/event.dart';
import 'package:abupi/pages/service.dart';
import 'package:abupi/main.dart';
import 'package:abupi/l10n/locale_provider.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _pages = const [
    HomeScreen(),
    EventScreen(),
    ServiceScreen(),
  ];

  void _showOtherMenuPopup() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const OtherMenuPopup(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Builder(
            builder: (context) {
              final l10n = AppLocalizations.of(context);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    index: 0,
                    icon: Icons.home_outlined,
                    selectedIcon: Icons.home,
                    label: l10n?.home ?? 'Beranda',
                  ),
                  _buildNavItem(
                    index: 1,
                    icon: Icons.event_outlined,
                    selectedIcon: Icons.event,
                    label: l10n?.event ?? 'Acara',
                  ),
                  _buildNavItem(
                    index: 2,
                    icon: Icons.miscellaneous_services_outlined,
                    selectedIcon: Icons.miscellaneous_services,
                    label: l10n?.service ?? 'Layanan',
                  ),
                  _buildOtherMenuItem(l10n),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData selectedIcon,
    required String label,
  }) {
    final isSelected = _currentIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              color: isSelected ? const Color(0xFF2e2f7f) : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? const Color(0xFF2e2f7f) : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtherMenuItem(AppLocalizations? l10n) {
    return InkWell(
      onTap: _showOtherMenuPopup,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.more_horiz,
                color: Colors.grey,
                size: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n?.other ?? 'Lainnya',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OtherMenuPopup extends StatelessWidget {
  const OtherMenuPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.info_outline,
                  title: l10n?.aboutUs ?? 'Tentang Kami',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AbupiApp.aboutUsRoute);
                  },
                ),
                _buildDivider(context),
                _buildMenuItem(
                  context,
                  icon: Icons.people_outline,
                  title: l10n?.organization ?? 'Organisasi',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AbupiApp.organizationRoute);
                  },
                ),
                _buildDivider(context),
                _buildMenuItem(
                  context,
                  icon: Icons.image_outlined,
                  title: l10n?.media ?? 'Media',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AbupiApp.mediaRoute);
                  },
                ),
                _buildDivider(context),
                _buildMenuItem(
                  context,
                  icon: Icons.work_outline,
                  title: l10n?.workPlan ?? 'Program Kerja ',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AbupiApp.workPlanRoute);
                  },
                ),
                _buildDivider(context),
                _buildMenuItem(
                  context,
                  icon: Icons.contact_support,
                  title: l10n?.contactUs ?? 'Hubungi Kami',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AbupiApp.contactUsRoute);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 80), // Space for the bottom nav bar
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
              color: const Color((0xFF2e2f7f)),
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.black45,
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
      color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.3),
    );
  }
}
