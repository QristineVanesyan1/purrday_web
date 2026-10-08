import 'package:flutter/material.dart';

/// Website-specific sizes, derived from the shared type scale.
extension WebText on TextTheme {
  TextStyle heroTitle({required bool compact}) => displayLarge!.copyWith(
        fontSize: compact ? 46 : 76,
        height: compact ? 52 / 46 : 82 / 76,
      );

  TextStyle sectionTitle({required bool compact}) => displayMedium!.copyWith(
        fontSize: compact ? 34 : 48,
        height: compact ? 40 / 34 : 56 / 48,
      );

  TextStyle cardTitle({required bool compact}) => titleLarge!.copyWith(
        fontSize: compact ? 22 : 26,
        height: compact ? 28 / 22 : 32 / 26,
      );

  TextStyle lead({required bool compact}) => bodyLarge!.copyWith(
        fontSize: compact ? 17 : 20,
        height: compact ? 26 / 17 : 31 / 20,
      );

  TextStyle subtitle({required bool compact}) => bodyLarge!.copyWith(
        fontSize: compact ? 16 : 18,
        height: compact ? 24 / 16 : 28 / 18,
      );

  TextStyle get eyebrow => labelMedium!;
}
