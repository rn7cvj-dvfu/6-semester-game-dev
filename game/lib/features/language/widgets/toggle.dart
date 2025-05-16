import 'package:flutter/material.dart';
import '../../../.gen/i18n/strings.g.dart';
import '../storage.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = LocaleSettings.currentLocale;
    return Column(
      children: [
        ListTile(
          title: Text(context.t.strings.useLangue),
        ),
        SegmentedButton<AppLocale>(
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
            if (selected.isEmpty) {
              return;
            }
            LocaleSettings.setLocale(selected.first);
            LanguageStorage.saveLanguage(selected.first);
          },
        ),
      ],
    );
  }
}
