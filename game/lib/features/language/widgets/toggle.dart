import 'package:flutter/material.dart';
import '../../../.gen/i18n/strings.g.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = LocaleSettings.currentLocale;
    return SegmentedButton<AppLocale>(
      segments: const [
        ButtonSegment(
          value: AppLocale.ru,
          label: Text('Русский'),
          icon: Icon(Icons.language),
        ),
        ButtonSegment(
          value: AppLocale.en,
          label: Text('English'),
          icon: Icon(Icons.language),
        ),
      ],
      selected: {locale},
      onSelectionChanged: (selected) {
        if (selected.isNotEmpty) {
          LocaleSettings.setLocale(selected.first);
        }
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 8)),
      ),
      showSelectedIcon: false,
    );
  }
}
