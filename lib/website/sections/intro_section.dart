import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../theme/mood.dart';
import '../layout/layout_scope.dart';
import '../widgets/mood_face.dart';
import '../widgets/section_title.dart';

class IntroSection extends StatelessWidget {
  const IntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final compact = LayoutScope.compactOf(context);
    final theme = Theme.of(context);

    return SectionContainer(
      top: compact ? AppSpacing.huge : AppSpacing.section,
      bottom: compact ? AppSpacing.huge : AppSpacing.section,
      child: Column(
        children: [
          const SectionTitle(
            eyebrow: 'SIMPLE ON PURPOSE',
            title: 'The simplest way to remember your day',
            subtitle: 'Meet Purrday, where you record your day with one cat '
                'and a few words. Making journaling a habit has never been '
                'easier.',
          ),
          SizedBox(height: compact ? AppSpacing.xxlg : 56),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: compact ? 10 : AppSpacing.xxxl - AppSpacing.sm,
            runSpacing: AppSpacing.xl,
            children: [
              for (final mood in Mood.values)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [
                    MoodFace(mood, size: compact ? 56 : 96),
                    Text(
                      mood.label,
                      style: theme.textTheme.labelLarge!.copyWith(
                        fontSize: compact ? 13 : 15,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
