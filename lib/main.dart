import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/screens/home_screen.dart';
import 'services/background_scan_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BackgroundScanService.initialize();
  runApp(const ProviderScope(child: FindPhoneApp()));
}

class FindPhoneApp extends StatelessWidget {
  const FindPhoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'findphone X',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Colors.greenAccent,
          surface: Colors.black,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
