import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../layout/layout_scope.dart';
import '../layout/web_text.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    required this.visual,
    required this.title,
    required this.description,
    super.key,
  });

  final Widget visual;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final compact = LayoutScope.compactOf(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: EdgeInsets.all(compact ? 20 : 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: compact ? 170 : 200,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: FittedBox(fit: BoxFit.scaleDown, child: visual),
                ),
              ),
            ),
            SizedBox(height: compact ? AppSpacing.lg : 22),
            Text(title, style: text.cardTitle(compact: compact)),
            const SizedBox(height: AppSpacing.sm),
            Text(
              description,
              style: text.bodyLarge!.copyWith(
                fontSize: compact ? 15 : 16,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
