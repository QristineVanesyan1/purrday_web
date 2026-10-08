import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../theme/mood.dart';
import 'mood_bar.dart';
import 'mood_face.dart';
import 'tag_chip.dart';

/// Small illustrations used inside the feature cards.

class RecordVisual extends StatelessWidget {
  const RecordVisual({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.xxs,
      children: [
        for (final mood in Mood.values)
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: mood == Mood.grumpy ? scheme.primary : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xxs),
              child: MoodFace(mood, size: 44),
            ),
          ),
      ],
    );
  }
}

class CustomizeVisual extends StatelessWidget {
  const CustomizeVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 260),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: [
          TagChip('Weather'),
          TagChip('Reading'),
          TagChip('Walking'),
          TagChip('Calm', style: TagStyle.selected),
          TagChip('Coffee'),
          TagChip('+ Add', style: TagStyle.outlined),
        ],
      ),
    );
  }
}

class PacksVisual extends StatelessWidget {
  const PacksVisual({super.key});

  static const _tiles = <(Color, Mood, double)>[
    (AppColors.packCozy, Mood.joyful, -0.1),
    (AppColors.packSpace, Mood.sad, 0),
    (AppColors.packWinter, Mood.calm, 0.1),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 248,
      height: 120,
      child: Stack(
        children: [
          for (var i = 0; i < _tiles.length; i++)
            Positioned(
              left: i * 76.0,
              top: 12,
              child: Transform.rotate(
                angle: _tiles[i].$3,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: _tiles[i].$1,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: scheme.shadow.withValues(alpha: 0.35),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: SizedBox.square(
                    dimension: 96,
                    child: Center(
                      child: MoodFace(
                        _tiles[i].$2,
                        size: 64,
                        illustration: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class MoodMixVisual extends StatelessWidget {
  const MoodMixVisual({super.key});

  static const _rows = <(Mood, double)>[
    (Mood.calm, 1),
    (Mood.joyful, 0.34),
    (Mood.grumpy, 0.34),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 240,
      child: Column(
        spacing: 14,
        children: [
          for (final (mood, fraction) in _rows)
            Row(
              spacing: 10,
              children: [
                SizedBox(
                  width: 52,
                  child: Text(
                    mood.label,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Expanded(child: MoodBar(fraction: fraction, color: mood.color)),
              ],
            ),
        ],
      ),
    );
  }
}

class PatternsVisual extends StatelessWidget {
  const PatternsVisual({super.key});

  static const _month = <Mood>[
    Mood.calm,
    Mood.calm,
    Mood.joyful,
    Mood.meh,
    Mood.calm,
    Mood.grumpy,
    Mood.sad,
    Mood.calm,
    Mood.joyful,
    Mood.joyful,
    Mood.calm,
    Mood.meh,
    Mood.meh,
    Mood.calm,
    Mood.calm,
    Mood.sad,
    Mood.calm,
    Mood.joyful,
    Mood.grumpy,
    Mood.calm,
    Mood.calm,
    Mood.meh,
    Mood.joyful,
    Mood.calm,
    Mood.calm,
    Mood.joyful,
    Mood.sad,
    Mood.calm,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 7 * 22 + 6 * AppSpacing.sm,
      child: Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: [
          for (final mood in _month)
            DecoratedBox(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: mood.color),
              child: const SizedBox.square(dimension: 22),
            ),
        ],
      ),
    );
  }
}

class PawVisual extends StatelessWidget {
  const PawVisual({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Mood.calm.color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: SizedBox(
        width: 230,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'TUESDAY, OCTOBER 6',
                style: text.labelSmall!.copyWith(
                  fontSize: 11,
                  letterSpacing: 1.5,
                  color: AppColors.olive600,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'A quiet moment is still a moment.',
                style: text.titleLarge!.copyWith(
                  fontSize: 18,
                  height: 24 / 18,
                  color: AppColors.ink900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
