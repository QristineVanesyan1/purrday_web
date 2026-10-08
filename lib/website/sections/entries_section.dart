import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../theme/mood.dart';
import '../layout/layout_scope.dart';
import '../widgets/mood_face.dart';
import '../widgets/section_title.dart';
import '../widgets/tag_chip.dart';

class _Entry {
  const _Entry(this.mood, this.date, this.note, this.tags);

  final Mood mood;
  final String date;
  final String note;
  final List<String> tags;
}

class EntriesSection extends StatelessWidget {
  const EntriesSection({super.key});

  static const _entries = <_Entry>[
    _Entry(
      Mood.joyful,
      'Oct 1',
      'Cat café with friends. Best latte of the year.',
      ['Friends', 'Café'],
    ),
    _Entry(
      Mood.calm,
      'Oct 5',
      'A long walk and a quiet evening with a book.',
      ['Walking', 'Reading'],
    ),
    _Entry(
      Mood.grumpy,
      'Oct 6',
      'Back-to-back meetings. Not my day.',
      ['Work'],
    ),
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
            eyebrow: 'A PEEK INSIDE',
            title: 'Little entries, big picture',
            subtitle: 'Sample entries from a Purrday calendar.',
          ),
          SizedBox(height: compact ? AppSpacing.xxlg : 56),
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              mainAxisSpacing: gap,
              crossAxisSpacing: gap,
              mainAxisExtent: 240,
            ),
            children: [
              for (final entry in _entries) _EntryCard(entry: entry),
            ],
          ),
        ],
      ),
    );
  }
}

class _EntryCard extends StatelessWidget {
  const _EntryCard({required this.entry});

  final _Entry entry;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 14,
          children: [
            Row(
              spacing: 14,
              children: [
                MoodFace(entry.mood, size: 56),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.date, style: text.titleLarge),
                    Text(
                      entry.mood.label,
                      style: text.bodySmall!.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(entry.note, style: text.bodyLarge),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [for (final tag in entry.tags) TagChip(tag)],
            ),
          ],
        ),
      ),
    );
  }
}
