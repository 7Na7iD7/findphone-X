import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/settings_provider.dart';
import 'home_screen.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  static const _developers = [
    'Navid Afzali',
    'Niki Farzami',
    'Rozhan Pourshad',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _scale = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _continue() {
    ref.read(appSettingsProvider.notifier).markWelcomeSeen();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, anim, __) => const HomeScreen(),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: ScaleTransition(
            scale: _scale,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  const _GlowMark(),
                  const SizedBox(height: 28),
                  const Text(
                    'findphone X',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Locate a nearby Bluetooth device\nby signal strength.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 36),
                  const _FeatureRow(
                    icon: Icons.bluetooth_searching,
                    label: 'Scan & survey every device nearby',
                  ),
                  const SizedBox(height: 14),
                  const _FeatureRow(
                    icon: Icons.gps_fixed,
                    label: 'Track one device with live distance',
                  ),
                  const SizedBox(height: 14),
                  const _FeatureRow(
                    icon: Icons.language,
                    label: 'English & فارسی, switch anytime',
                  ),
                  const Spacer(flex: 3),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: _continue,
                      child: const Text(
                        'Get Started',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'DEVELOPED BY',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.3),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: _developers
                        .map((name) => _DeveloperChip(name: name))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GlowMark extends StatelessWidget {
  const _GlowMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.greenAccent.withValues(alpha: 0.08),
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent.withValues(alpha: 0.25),
            blurRadius: 40,
            spreadRadius: 6,
          ),
        ],
      ),
      child: const Icon(Icons.bluetooth, color: Colors.greenAccent, size: 44),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: Colors.greenAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(9),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: Colors.greenAccent, size: 18),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class _DeveloperChip extends StatelessWidget {
  final String name;
  const _DeveloperChip({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Text(
        name,
        style: const TextStyle(color: Colors.white60, fontSize: 12.5),
      ),
    );
  }
}
