import 'package:flutter/material.dart';
import 'strings_en.dart';
import 'strings_fa.dart';

/// Lightweight, dependency-free localization: no codegen, no .arb files.
/// English is the default/fallback language; Persian (fa) is the second
/// supported locale, toggled from the Settings screen.
class AppLocalizations {
  final Locale locale;

  const AppLocalizations(this.locale);

  static const supportedLocales = [Locale('en'), Locale('fa')];

  static const AppLocalizationsDelegate delegate = AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _tables = {
    'en': enStrings,
    'fa': faStrings,
  };

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        const AppLocalizations(Locale('en'));
  }

  bool get isRtl => locale.languageCode == 'fa';

  /// Plain lookup, falling back to English then to the raw key.
  String t(String key) {
    final table = _tables[locale.languageCode] ?? _tables['en']!;
    return table[key] ?? _tables['en']![key] ?? key;
  }

  /// Lookup with `{placeholder}` substitution, e.g.
  /// `l10n.tp('errorPrefix', {'error': err.toString()})`.
  String tp(String key, Map<String, String> params) {
    var value = t(key);
    params.forEach((k, v) {
      value = value.replaceAll('{$k}', v);
    });
    return value;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales
      .map((l) => l.languageCode)
      .contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

/// `context.l10n.t('key')` sugar.
extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
