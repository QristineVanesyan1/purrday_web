import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

enum TagStyle { filled, selected, outlined }

class TagChip extends StatelessWidget {
  const TagChip(this.label, {this.style = TagStyle.filled, super.key});

  final String label;
  final TagStyle style;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final (Color? background, Color foreground, Color? border) = switch (style) {
      TagStyle.filled => (scheme.surfaceContainer, scheme.onSurface, null),
      TagStyle.selected => (scheme.primary, scheme.onPrimary, null),
      TagStyle.outlined => (null, scheme.onSurfaceVariant, scheme.outlineVariant),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
        border: border == null ? null : Border.all(color: border),
      ),
      child: SizedBox(
        height: 32,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Center(
            widthFactor: 1,
            child: Text(
              label,
              style: theme.textTheme.labelLarge!.copyWith(
                fontSize: 13,
                color: foreground,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
