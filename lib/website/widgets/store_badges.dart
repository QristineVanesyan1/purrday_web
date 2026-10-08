import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../layout/layout_scope.dart';

/// Placeholder store button. Swap for the official badge artwork and link it.
class StoreBadge extends StatelessWidget {
  const StoreBadge({required this.caption, required this.name, super.key});

  final String caption;
  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    return Semantics(
      button: true,
      label: '$caption $name',
      excludeSemantics: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: SizedBox(
          height: 56,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpacing.md,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const SizedBox.square(dimension: 28),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      caption,
                      style: text.bodySmall!.copyWith(
                        fontSize: 11,
                        height: 1.2,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      name,
                      style: text.labelLarge!.copyWith(
                        fontSize: 19,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
      StoreBadge(caption: 'Download on the', name: 'App Store'),
      StoreBadge(caption: 'Get it on', name: 'Google Play'),
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
