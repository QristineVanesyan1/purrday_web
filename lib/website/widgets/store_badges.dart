import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../layout/layout_scope.dart';

/// Official store badge artwork. Link it by passing [onTap].
class StoreBadge extends StatelessWidget {
  const StoreBadge({
    required this.asset,
    required this.label,
    this.onTap,
    super.key,
  });

  final String asset;
  final String label;
  final VoidCallback? onTap;

  static const double height = 56;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: MouseRegion(
        cursor: onTap == null ? MouseCursor.defer : SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Image.asset(asset, height: height, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class StoreBadges extends StatelessWidget {
  const StoreBadges({super.key});

  @override
  Widget build(BuildContext context) {
    final compact = LayoutScope.compactOf(context);
    const badges = [
      StoreBadge(
        asset: 'assets/images/badge_app_store.png',
        label: 'Download on the App Store',
      ),
      StoreBadge(
        asset: 'assets/images/badge_google_play.png',
        label: 'Get it on Google Play',
      ),
    ];

    if (compact) {
      return const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.md,
        children: badges,
      );
    }
    return const Row(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.md,
      children: badges,
    );
  }
}
