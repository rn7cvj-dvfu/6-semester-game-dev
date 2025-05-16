import 'package:shared_preferences/shared_preferences.dart';

import '../../.gen/i18n/strings.g.dart';

final class LanguageStorage {
  static const String _LanguageKey = 'language';

  LanguageStorage._();

  static Future<AppLocale?> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();

    final languageString = prefs.getString(_LanguageKey);

    try {
      final language = AppLocale.values
          .where((e) => e.toString() == languageString)
          .firstOrNull;

      return language;
    } catch (e) {
      return null;
    }
  }

  static Future<void> saveLanguage(AppLocale language) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_LanguageKey, language.toString());
  }
}
