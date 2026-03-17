import 'package:abupi/l10n/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelectorButton extends StatelessWidget {
  const LanguageSelectorButton({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLocale = localeProvider.locale;

    return IconButton(
      icon: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // Moves shadow down
            ),
          ],
        ),
        child: Image.asset(
          currentLocale.languageCode == 'id'
              ? 'assets/images/flag_id.jpg'
              : 'assets/images/flag_gb.jpg',
          width: 30,
        ),
      ),
      onPressed: () => _showLanguageDialog(context),
      tooltip: AppLocalizations.of(context)?.language ?? 'Language',
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final localizations = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: DefaultTextStyle(
          //   style: const TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
          //   child: Text(localizations?.selectLanguage ?? 'Pilih Bahasa'),
          // ),
          title: Text(
            localizations?.selectLanguage ?? 'Pilih Bahasa',
            style: const TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.only(top: 16, bottom: 8),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LanguageOption(
                language: 'id',
                languageName: localizations?.indonesian ?? 'Indonesian',
                locale: const Locale('id'),
                currentLocale: localeProvider.locale,
                onSelect: (locale) {
                  localeProvider.setLocale(locale);
                  Navigator.of(context).pop();
                },
              ),
              _LanguageOption(
                language: 'en',
                languageName: localizations?.english ?? 'English',
                locale: const Locale('en'),
                currentLocale: localeProvider.locale,
                onSelect: (locale) {
                  localeProvider.setLocale(locale);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String language;
  final String languageName;
  final Locale locale;
  final Locale currentLocale;
  final Function(Locale) onSelect;

  const _LanguageOption({
    required this.language,
    required this.languageName,
    required this.locale,
    required this.currentLocale,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentLocale.languageCode == locale.languageCode;

    return InkWell(
      onTap: () => onSelect(locale),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // Moves shadow down
                  ),
                ],
              ),
              child: Image.asset(
                language == 'id' ?
                  'assets/images/flag_id.jpg' :
                  'assets/images/flag_gb.jpg',
                width: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                languageName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            Radio<Locale>(
              value: locale,
              groupValue: currentLocale,
              activeColor: const Color(0xFF632f9c),
              fillColor: const WidgetStatePropertyAll<Color>(Color(0xFF632f9c)),
              onChanged: (value) {
                if (value != null) {
                  onSelect(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
