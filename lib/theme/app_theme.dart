import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Purrday palette, taken from the Color palette sheets (dark and light).
abstract class AppColors {
  // Brand
  static const sage500 = Color(0xFFAEC391);
  static const olive600 = Color(0xFF6F7F57);
  static const dusk500 = Color(0xFF4A5F7A);
  static const dusk700 = Color(0xFF2F3B4C);

  // Neutrals
  static const ink900 = Color(0xFF1C1B18);
  static const ink800 = Color(0xFF2A2926);
  static const ink700 = Color(0xFF3A3834);
  static const cream400 = Color(0xFFA8A396);
  static const cream50 = Color(0xFFF4EFE2);

  // Mood
  static const joyful = Color(0xFFF5E6B0);
  static const calm = Color(0xFFCFDCC4);
  static const meh = Color(0xFFE8DFCB);
  static const sad = Color(0xFFBCCDE6);
  static const grumpy = Color(0xFFEFC5C0);
  static const grumpyTan = Color(0xFFD5BBA3);

  // Cat pack tile tints (Shop screen)
  static const packCozy = Color(0xFF3A3326);
  static const packSpace = Color(0xFF283345);
  static const packSushi = Color(0xFF3D2D2B);
  static const packWinter = Color(0xFF2A3429);

  // Light-mode surfaces (from the Light sheets)
  static const paper = Color(0xFFFFFFFF);
  static const paperLine = Color(0xFFD9D1BE);
  static const paperTrack = Color(0xFFE4DCC6);
  static const paperMuted = Color(0xFF6F6B5E);

  /// Not on the kit sheets: a deeper take on Grumpy so errors read on cream.
  static const errorLight = Color(0xFFB3574F);
}

/// Spacing scale. Every step is a multiple of [spaceUnit].
abstract class AppSpacing {
  static const double spaceUnit = 16;

  static const double xxs = 0.25 * spaceUnit; // 4
  static const double sm = 0.5 * spaceUnit; // 8
  static const double md = 0.75 * spaceUnit; // 12
  static const double lg = spaceUnit; // 16
  static const double xl = 1.5 * spaceUnit; // 24
  static const double xxlg = 2 * spaceUnit; // 32
  static const double xxxl = 3 * spaceUnit; // 48
  static const double huge = 4 * spaceUnit; // 64
  static const double section = 6 * spaceUnit; // 96
}

/// Type scale from the Font styles sheet. Fraunces for display, Nunito for text.
abstract class AppTextStyle {
  static TextStyle get _display =>
      GoogleFonts.fraunces(fontWeight: FontWeight.w600);
  static TextStyle get _body => GoogleFonts.nunito(fontWeight: FontWeight.w500);
  static TextStyle get _label => GoogleFonts.nunito(fontWeight: FontWeight.w700);
  static TextStyle get _heavy => GoogleFonts.nunito(fontWeight: FontWeight.w800);

  static TextTheme get textTheme => TextTheme(
        // Hero / wordmark
        displayLarge: _display.copyWith(fontSize: 56, height: 64 / 56),
        // Display L
        displayMedium: _display.copyWith(fontSize: 40, height: 48 / 40),
        // Heading
        headlineMedium: _display.copyWith(fontSize: 28, height: 34 / 28),
        // Title
        titleLarge: _display.copyWith(fontSize: 22, height: 28 / 22),
        // Body
        bodyLarge: _body.copyWith(fontSize: 16, height: 24 / 16),
        bodyMedium: _body.copyWith(fontSize: 15, height: 22 / 15),
        // Caption
        bodySmall: _body.copyWith(fontSize: 13, height: 18 / 13),
        // Label / Button
        labelLarge: _label.copyWith(fontSize: 16, height: 20 / 16),
        // Eyebrow
        labelMedium: _heavy.copyWith(
          fontSize: 13,
          height: 16 / 13,
          letterSpacing: 2,
        ),
        labelSmall: _body.copyWith(
          fontSize: 12,
          height: 16 / 12,
          letterSpacing: 2,
        ),
      );
}

abstract class AppTheme {
  static ThemeData get dark => _build(_darkScheme);
  static ThemeData get light => _build(_lightScheme);

  static const _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.sage500,
    onPrimary: AppColors.ink900,
    secondary: AppColors.dusk500,
    onSecondary: AppColors.cream50,
    secondaryContainer: AppColors.dusk700,
    onSecondaryContainer: AppColors.cream50,
    tertiary: AppColors.olive600,
    onTertiary: AppColors.cream50,
    error: AppColors.grumpy,
    onError: AppColors.ink900,
    surface: AppColors.ink900,
    onSurface: AppColors.cream50,
    onSurfaceVariant: AppColors.cream400,
    surfaceContainer: AppColors.ink800,
    surfaceContainerHighest: AppColors.ink700,
    outline: AppColors.cream400,
    outlineVariant: AppColors.ink700,
  );

  static const _lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.sage500,
    onPrimary: AppColors.ink900,
    secondary: AppColors.dusk500,
    onSecondary: AppColors.cream50,
    secondaryContainer: AppColors.sad,
    onSecondaryContainer: AppColors.dusk700,
    tertiary: AppColors.olive600,
    onTertiary: AppColors.cream50,
    error: AppColors.errorLight,
    onError: AppColors.cream50,
    surface: AppColors.cream50,
    onSurface: AppColors.ink900,
    onSurfaceVariant: AppColors.paperMuted,
    surfaceContainer: AppColors.paper,
    surfaceContainerHighest: AppColors.paperTrack,
    outline: AppColors.paperMuted,
    outlineVariant: AppColors.paperLine,
  );

  static ThemeData _build(ColorScheme scheme) {
    final textTheme = AppTextStyle.textTheme.apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );
    const padding = EdgeInsets.symmetric(horizontal: AppSpacing.xl);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: textTheme,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: const StadiumBorder(),
          minimumSize: const Size(0, 56),
          padding: padding,
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: const StadiumBorder(),
          minimumSize: const Size(0, 56),
          padding: padding,
          foregroundColor: scheme.onSurface,
          side: BorderSide(color: scheme.onSurface, width: 2),
          textStyle: textTheme.labelLarge,
        ),
      ),
      drawerTheme: DrawerThemeData(backgroundColor: scheme.surfaceContainer),
    );
  }
}
