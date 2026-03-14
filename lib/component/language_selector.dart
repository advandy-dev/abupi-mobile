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
      icon: Text(
        currentLocale.languageCode == 'id' ? '🇮🇩' : '🇬🇧',
        style: const TextStyle(fontSize: 24),
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
          title: Text(localizations?.selectLanguage ?? 'Select Language'),
          contentPadding: const EdgeInsets.only(top: 16, bottom: 8),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LanguageOption(
                flag: '🇮🇩',
                languageName: localizations?.indonesian ?? 'Indonesian',
                locale: const Locale('id'),
                currentLocale: localeProvider.locale,
                onSelect: (locale) {
                  localeProvider.setLocale(locale);
                  Navigator.of(context).pop();
                },
              ),
              _LanguageOption(
                flag: '🇬🇧',
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
  final String flag;
  final String languageName;
  final Locale locale;
  final Locale currentLocale;
  final Function(Locale) onSelect;

  const _LanguageOption({
    required this.flag,
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
            Text(
              flag,
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                languageName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            Radio<Locale>(
              value: locale,
              groupValue: currentLocale,
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
