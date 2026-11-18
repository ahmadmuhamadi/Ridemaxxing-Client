import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.bg,
    required this.surface,
    required this.ink,
    required this.muted,
    required this.primary,
    required this.onPrimary,
    required this.gold,
    required this.danger,
    required this.edge,
    required this.map,
    required this.street,
    required this.park,
    required this.water,
  });

  final Color bg, surface, ink, muted, primary, onPrimary, gold, danger;
  final Color edge, map, street, park, water;

  Color get line => ink.withValues(alpha: 0.12);
  Color get glass => surface.withValues(alpha: 0.6);
  Color get primarySoft => primary.withValues(alpha: 0.14);
  Color get goldSoft => gold.withValues(alpha: 0.18);
  Color get shadow => const Color(0x2E000000);

  static const light = AppColors(
    bg: Color(0xFFF2F3F5),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF15171C),
    muted: Color(0xFF5B606B),
    primary: Color(0xFF2B54D0),
    onPrimary: Color(0xFFFFFFFF),
    gold: Color(0xFFA8761E),
    danger: Color(0xFFB42318),
    edge: Color(0xCCFFFFFF),
    map: Color(0xFFE8EAE6),
    street: Color(0xFFFFFFFF),
    park: Color(0xFFD3E2CC),
    water: Color(0xFFC8DAE6),
  );

  static const dark = AppColors(
    bg: Color(0xFF0E0F12),
    surface: Color(0xFF1A1C21),
    ink: Color(0xFFF1F2F5),
    muted: Color(0xFFA2A7B2),
    primary: Color(0xFF8EA8FF),
    onPrimary: Color(0xFF0C1330),
    gold: Color(0xFFE2B04F),
    danger: Color(0xFFFF8A80),
    edge: Color(0x1AFFFFFF),
    map: Color(0xFF17191E),
    street: Color(0xFF262930),
    park: Color(0xFF1B2620),
    water: Color(0xFF142230),
  );

  @override
  AppColors copyWith() => this;

  @override
  AppColors lerp(AppColors? other, double t) =>
      t < 0.5 || other == null ? this : other;
}

extension AppColorsOf on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}

abstract final class Radii {
  static const button = 16.0;
  static const card = 22.0;
  static const sheet = 30.0;
  static const pill = 999.0;
}

TextStyle numStyle(double size, Color color) => GoogleFonts.bigShoulders(
  fontSize: size,
  fontWeight: FontWeight.w800,
  color: color,
  height: 1,
);

ThemeData appTheme(Brightness brightness) {
  final c = brightness == Brightness.dark ? AppColors.dark : AppColors.light;
  return ThemeData(
    brightness: brightness,
    colorScheme: ColorScheme.fromSeed(
      seedColor: c.primary,
      brightness: brightness,
      primary: c.primary,
      onPrimary: c.onPrimary,
      surface: c.surface,
      onSurface: c.ink,
    ),
    scaffoldBackgroundColor: c.bg,
    splashFactory: NoSplash.splashFactory,
    extensions: [c],
  );
}
