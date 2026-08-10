import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSettings {
  final bool redact;
  final bool soundEnabled;

  const AppSettings({this.redact = false, this.soundEnabled = false});

  AppSettings copyWith({bool? redact, bool? soundEnabled}) {
    return AppSettings(
      redact: redact ?? this.redact,
      soundEnabled: soundEnabled ?? this.soundEnabled,
    );
  }
}

class AppSettingsController extends StateNotifier<AppSettings> {
  AppSettingsController() : super(const AppSettings());

  void setRedact(bool value) => state = state.copyWith(redact: value);

  void setSound(bool value) => state = state.copyWith(soundEnabled: value);
}

final appSettingsProvider =
    StateNotifierProvider<AppSettingsController, AppSettings>((ref) {
  return AppSettingsController();
});
