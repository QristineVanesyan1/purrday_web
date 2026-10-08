import 'package:flutter/material.dart';

import '../../theme/app_assets.dart';
import '../../theme/app_theme.dart';
import '../layout/layout_scope.dart';
import '../layout/web_text.dart';
import '../widgets/disc.dart';
import '../widgets/store_badges.dart';

class CtaSection extends StatelessWidget {
  const CtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final compact = LayoutScope.compactOf(context);
    final scheme = Theme.of(context).colorScheme;

    const copy = _CtaCopy();
    final art = Image.asset(
      AppAssets.heroCalm,
      fit: BoxFit.contain,
      semanticLabel: 'A calm cat meditating next to the sun',
    );

    return ClipRect(
      child: Stack(
        children: [
          Positioned(
            top: compact ? -60 : -120,
            right: compact ? -80 : -100,
            child: Disc(
              size: compact ? 240 : 360,
              color: scheme.secondaryContainer,
            ),
          ),
          if (!compact)
            Positioned(
              left: -100,
              bottom: -80,
              child: Disc(
                size: 300,
                color: scheme.primary.withValues(alpha: 0.07),
              ),
            ),
          SectionContainer(
            top: compact ? AppSpacing.huge : AppSpacing.section,
            bottom: compact ? AppSpacing.huge : AppSpacing.section,
            child: compact
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: AppSpacing.xxlg,
                    children: [copy, art],
                  )
                : Row(
                    spacing: AppSpacing.xxxl,
                    children: [
                      const Expanded(child: copy),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 540),
                            child: art,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _CtaCopy extends StatelessWidget {
  const _CtaCopy();

  @override
  Widget build(BuildContext context) {
    final compact = LayoutScope.compactOf(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.lg,
      children: [
        Text('GET PURRDAY', style: text.eyebrow.copyWith(color: scheme.primary)),
        Semantics(
          header: true,
          child: Text(
            'Start journaling today!',
            style: text.displayMedium!.copyWith(
              fontSize: compact ? 38 : 60,
              height: compact ? 44 / 38 : 66 / 60,
            ),
          ),
        ),
        Text(
          'Download free on iOS and Android.',
          style: text
              .subtitle(compact: compact)
              .copyWith(color: scheme.onSurfaceVariant),
        ),
        const Padding(
          padding: EdgeInsets.only(top: AppSpacing.sm),
          child: StoreBadges(),
        ),
      ],
    );
  }
}
