import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../theme/mood.dart';
import '../layout/layout_scope.dart';
import '../widgets/mood_face.dart';
import '../widgets/section_title.dart';

class PacksSection extends StatelessWidget {
  const PacksSection({super.key});

  static const _packs = <(String, Color, Mood, String)>[
    ('Cozy Cats', AppColors.packCozy, Mood.joyful, 'Free'),
    ('Space Cats', AppColors.packSpace, Mood.sad, r'$1.99'),
    ('Sushi Cats', AppColors.packSushi, Mood.grumpy, r'$1.99'),
    ('Winter Cats', AppColors.packWinter, Mood.calm, r'$1.99'),
  ];

  @override
  Widget build(BuildContext context) {
    final compact = LayoutScope.compactOf(context);
    final gap = compact ? AppSpacing.md : AppSpacing.xl;

    return SectionContainer(
      top: compact ? AppSpacing.huge : AppSpacing.section,
      bottom: compact ? AppSpacing.huge : AppSpacing.section,
      child: Column(
        children: [
          const SectionTitle(
            eyebrow: 'CAT PACKS',
            title: 'Pick a cat pack for every mood',
            subtitle: 'Decorate your calendar with cats that fit your vibe.',
          ),
          SizedBox(height: compact ? AppSpacing.xxlg : 56),
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 280,
              mainAxisSpacing: gap,
              crossAxisSpacing: gap,
              mainAxisExtent: compact ? 230 : 340,
            ),
            children: [
              for (final (name, tint, mood, price) in _packs)
                _PackTile(name: name, tint: tint, mood: mood, price: price),
            ],
          ),
        ],
      ),
    );
  }
}

class _PackTile extends StatelessWidget {
  const _PackTile({
    required this.name,
    required this.tint,
    required this.mood,
    required this.price,
  });

  final String name;
  final Color tint;
  final Mood mood;
  final String price;

  @override
  Widget build(BuildContext context) {
    final compact = LayoutScope.compactOf(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(compact ? 24 : 28),
      ),
      child: Padding(
        padding: EdgeInsets.all(compact ? AppSpacing.md : 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: tint,
                  borderRadius: BorderRadius.circular(compact ? 18 : 22),
                ),
                child: Center(
                  child: MoodFace(
                    mood,
                    size: compact ? 76 : 124,
                    illustration: true,
                  ),
                ),
              ),
            ),
            SizedBox(height: compact ? AppSpacing.sm : 14),
            Text(
              name,
              style: text.labelLarge!.copyWith(fontSize: compact ? 15 : 19),
            ),
            SizedBox(height: compact ? AppSpacing.sm : 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '5 cats',
                  style: text.bodySmall!.copyWith(
                    fontSize: compact ? 12 : 14,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: compact ? 10 : 14,
                      vertical: compact ? 4 : 6,
                    ),
                    child: Text(
                      price,
                      style: text.labelLarge!.copyWith(
                        fontSize: compact ? 12 : 14,
                        color: scheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
