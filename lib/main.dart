import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'application/providers/settings_provider.dart';
import 'l10n/app_localizations.dart';
import 'presentation/screens/home_screen.dart';
import 'services/background_scan_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BackgroundScanService.initialize();
  runApp(const ProviderScope(child: FindPhoneApp()));
}

class FindPhoneApp extends ConsumerWidget {
  const FindPhoneApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(appSettingsProvider.select((s) => s.language));
    final locale = Locale(language.code);

    return MaterialApp(
      title: 'findphone X',
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Colors.greenAccent,
          surface: Colors.black,
        ),
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: language.isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: child!,
        );
      },
      home: const HomeScreen(),
    );
  }
}
