import 'package:flutter/material.dart';

class AppColors {
  final LinearGradient bgGradient;
  final Color bg;
  final Color card;
  final Color title;
  final Color subtitle;
  final Color border;
  final Color iconBg;
  final Color iconColor;
  final Color iconBgMuted;
  final Color iconMuted;
  final Color primary;
  final Color secondary;
  final Color surface;
  AppColors._({
    required this.bgGradient,
    required this.bg,
    required this.card,
    required this.title,
    required this.subtitle,
    required this.border,
    required this.iconBg,
    required this.iconColor,
    required this.iconBgMuted,
    required this.iconMuted,
    required this.primary,
    required this.secondary,
    required this.surface,
  });

  factory AppColors.of(BuildContext context) {
    // Korenza Brand Colors (Light Only)
    const primaryPink = Color.fromARGB(255, 255, 77, 141);
    const softPinkBg = Color.fromARGB(255, 255, 248, 248);
    const charcoalTitle = Color(0xFF2E1F24);
    const mauveSubtitle = Color(0xFF8E7E83);

    return AppColors._(
      bgGradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(255, 255, 247, 250), // Very Light/Pale Pink (Top)
          Color.fromARGB(255, 255, 209, 227), // Richer, Defined Pink (Bottom)
        ],
        // Optional: Add stops to control where the transition starts/ends
        stops: [0.0, 0.3],
      ),
      bg: softPinkBg,
      card: Colors.white,
      title: charcoalTitle,
      subtitle: Color.fromARGB(255, 119, 84, 99),
      border: Color.fromARGB(255, 243, 214, 227),
      iconBg: const Color(0xFFFCE4EC),
      iconColor: Color.fromARGB(255, 185, 10, 90),
      iconBgMuted: Colors.grey.withAlpha(10),
      iconMuted: mauveSubtitle,
      primary: primaryPink,
      secondary: const Color.fromARGB(255, 255, 209, 227),
      surface: Colors.white,
    );
  }
}
