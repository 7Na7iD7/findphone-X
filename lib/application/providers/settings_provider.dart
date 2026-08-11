import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLanguage { en, fa }

extension AppLanguageX on AppLanguage {
  String get code => this == AppLanguage.en ? 'en' : 'fa';
  bool get isRtl => this == AppLanguage.fa;
  String get nativeName => this == AppLanguage.en ? 'English' : 'فارسی';

  static AppLanguage fromCode(String? code) {
    return code == 'fa' ? AppLanguage.fa : AppLanguage.en;
  }
}

class AppSettings {
  final bool redact;
  final bool soundEnabled;
  final AppLanguage language;
  final bool hasSeenWelcome;
  final bool restored;

  const AppSettings({
    this.redact = false,
    this.soundEnabled = false,
    this.language = AppLanguage.en,
    this.hasSeenWelcome = false,
    this.restored = false,
  });

  AppSettings copyWith({
    bool? redact,
    bool? soundEnabled,
    AppLanguage? language,
    bool? hasSeenWelcome,
    bool? restored,
  }) {
    return AppSettings(
      redact: redact ?? this.redact,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      language: language ?? this.language,
      hasSeenWelcome: hasSeenWelcome ?? this.hasSeenWelcome,
      restored: restored ?? this.restored,
    );
  }
}

class AppSettingsController extends StateNotifier<AppSettings> {
  static const _kRedact = 'settings.redact';
  static const _kSound = 'settings.soundEnabled';
  static const _kLanguage = 'settings.language';
  static const _kHasSeenWelcome = 'settings.hasSeenWelcome';

  AppSettingsController() : super(const AppSettings()) {
    _restore();
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    state = AppSettings(
      redact: prefs.getBool(_kRedact) ?? false,
      soundEnabled: prefs.getBool(_kSound) ?? false,
      language: AppLanguageX.fromCode(prefs.getString(_kLanguage)),
      hasSeenWelcome: prefs.getBool(_kHasSeenWelcome) ?? false,
      restored: true,
    );
  }

  Future<void> setRedact(bool value) async {
    state = state.copyWith(redact: value);
    (await SharedPreferences.getInstance()).setBool(_kRedact, value);
  }

  Future<void> setSound(bool value) async {
    state = state.copyWith(soundEnabled: value);
    (await SharedPreferences.getInstance()).setBool(_kSound, value);
  }

  Future<void> setLanguage(AppLanguage language) async {
    if (language == state.language) return;
    state = state.copyWith(language: language);
    (await SharedPreferences.getInstance())
        .setString(_kLanguage, language.code);
  }

  Future<void> markWelcomeSeen() async {
    if (state.hasSeenWelcome) return;
    state = state.copyWith(hasSeenWelcome: true);
    (await SharedPreferences.getInstance())
        .setBool(_kHasSeenWelcome, true);
  }
}

final appSettingsProvider =
    StateNotifierProvider<AppSettingsController, AppSettings>((ref) {
  return AppSettingsController();
});
