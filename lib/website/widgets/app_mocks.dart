import 'package:flutter/material.dart';

import '../../theme/app_assets.dart';
import '../../theme/app_theme.dart';
import '../../theme/mood.dart';
import 'disc.dart';
import 'mood_bar.dart';
import 'mood_face.dart';

// Static copies of the Home and Report screens, laid out on a 390x844 canvas.
// Wrap them in a PhoneFrame to scale them down.

const _navItems = <(IconData, String)?>[
  (Icons.calendar_month_outlined, 'Home'),
  (Icons.bar_chart_rounded, 'Report'),
  null,
  (Icons.shopping_bag_outlined, 'Shop'),
  (Icons.settings_outlined, 'Settings'),
];

/// Bottom tab bar plus the centre cat button. Spread into a Stack.
List<Widget> _mockNavBar(BuildContext context, {required int active}) {
  final theme = Theme.of(context);
  final scheme = theme.colorScheme;
  final text = theme.textTheme;

  return [
    Positioned(
      left: 0,
      right: 0,
      top: 752,
      height: 92,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surfaceContainer,
          border: Border(top: BorderSide(color: scheme.outlineVariant)),
        ),
        child: Row(
          children: [
            for (var i = 0; i < _navItems.length; i++)
              Expanded(
                child: _navItems[i] == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.md),
                        child: Column(
                          spacing: AppSpacing.xxs,
                          children: [
                            Icon(
                              _navItems[i]!.$1,
                              size: 26,
                              color: i == active
                                  ? scheme.primary
                                  : scheme.onSurfaceVariant,
                            ),
                            Text(
                              _navItems[i]!.$2,
                              style: text.bodySmall!.copyWith(
                                fontSize: 12,
                                color: i == active
                                    ? scheme.primary
                                    : scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
          ],
        ),
      ),
    ),
    Positioned(
      left: 164,
      top: 723,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: scheme.secondary,
          border: Border.all(color: scheme.surface, width: 6),
        ),
        child: ClipOval(
          child: Image.asset(AppAssets.fabCat, width: 50, height: 50),
        ),
      ),
    ),
  ];
}

class HomeMock extends StatelessWidget {
  const HomeMock({super.key});

  static const _logged = <int, Mood>{
    1: Mood.joyful,
    2: Mood.calm,
    3: Mood.calm,
    4: Mood.meh,
    5: Mood.calm,
    6: Mood.grumpy,
  };
  static const _selectedDay = 6;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    final cells = <Widget>[
      for (var i = 0; i < 4; i++) const SizedBox.shrink(),
      for (var d = 1; d <= 31; d++)
        _DayCell(
          day: d,
          mood: _logged[d],
          selected: d == _selectedDay,
        ),
    ];

    return Stack(
      children: [
        Positioned(
          left: 230,
          top: -98,
          child: Disc(size: 240, color: scheme.secondaryContainer),
        ),
        Positioned(
          left: 24,
          top: 64,
          child: Row(
            spacing: AppSpacing.md,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: Image.asset(AppAssets.appIcon, width: 36, height: 36),
              ),
              Text('Purrday', style: text.titleLarge),
            ],
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          top: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.square(
                dimension: 44,
                child: Icon(Icons.chevron_left_rounded, size: 28),
              ),
              Text(
                'October 2026',
                style: text.headlineMedium!.copyWith(
                  fontSize: 30,
                  height: 36 / 30,
                ),
              ),
              const SizedBox.square(
                dimension: 44,
                child: Icon(Icons.chevron_right_rounded, size: 28),
              ),
            ],
          ),
        ),
        Positioned(
          left: 24,
          width: 342,
          top: 182,
          child: Row(
            children: [
              for (final d in 'SMTWTFS'.split(''))
                Expanded(
                  child: Center(
                    child: Text(
                      d,
                      style: text.labelLarge!.copyWith(
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Positioned(
          left: 24,
          width: 342,
          top: 212,
          child: Column(
            spacing: 4,
            children: [
              for (var r = 0; r < 5; r++)
                SizedBox(
                  height: 66,
                  child: Row(
                    children: [
                      for (var c = 0; c < 7; c++) Expanded(child: cells[r * 7 + c]),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const Positioned(
          left: 20,
          right: 20,
          top: 606,
          height: 106,
          child: _EntryCard(),
        ),
        ..._mockNavBar(context, active: 0),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({required this.day, required this.mood, required this.selected});

  final int day;
  final Mood? mood;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final numberColor = selected
        ? scheme.onPrimary
        : mood != null
            ? scheme.onSurface
            : scheme.onSurfaceVariant.withValues(alpha: 0.7);

    return Column(
      spacing: 4,
      children: [
        mood != null
            ? MoodFace(mood!, size: 40)
            : DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: scheme.surfaceContainer,
                ),
                child: const SizedBox.square(dimension: 40),
              ),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 32),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: selected ? scheme.primary : null,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Center(
              widthFactor: 1,
              heightFactor: 1,
              child: Text(
                '$day',
                style: theme.textTheme.labelLarge!.copyWith(
                  fontSize: 15,
                  height: 22 / 15,
                  color: numberColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _EntryCard extends StatelessWidget {
  const _EntryCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: scheme.onSurface, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: AppSpacing.lg),
        child: Row(
          spacing: AppSpacing.lg,
          children: [
            const MoodFace(Mood.grumpy, size: 64),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Oct 6', style: text.headlineMedium),
                  Text(
                    'Tuesday · Grumpy',
                    style: text.bodySmall!.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.edit_outlined, size: 24),
          ],
        ),
      ),
    );
  }
}

class ReportMock extends StatelessWidget {
  const ReportMock({super.key});

  static const _mix = <(Mood, int)>[
    (Mood.joyful, 1),
    (Mood.calm, 3),
    (Mood.meh, 1),
    (Mood.sad, 0),
    (Mood.grumpy, 1),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    return Stack(
      children: [
        Positioned(
          left: 230,
          top: -98,
          child: Disc(size: 240, color: scheme.secondaryContainer),
        ),
        Positioned(
          left: 24,
          right: 24,
          top: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Report', style: text.displayMedium),
              Text(
                'October 2026',
                style: text.bodyLarge!.copyWith(color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: 22),
              const _Segmented(),
              const SizedBox(height: 20),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    spacing: 20,
                    children: [
                      const MoodFace(Mood.calm, size: 88, illustration: true),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mostly',
                            style: text.bodyMedium!.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                          Text('Calm', style: text.headlineMedium),
                          Text(
                            '3 of 6 logged days',
                            style: text.bodyMedium!.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 22,
                    children: [
                      Text('Mood mix', style: text.labelLarge),
                      for (final (mood, count) in _mix)
                        Row(
                          children: [
                            SizedBox(
                              width: 74,
                              child: Text(
                                mood.label,
                                style: text.bodyMedium!.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                            Expanded(
                              child: MoodBar(
                                fraction: count / 3,
                                color: mood.color,
                                height: 14,
                              ),
                            ),
                            SizedBox(
                              width: 34,
                              child: Text(
                                '$count',
                                textAlign: TextAlign.end,
                                style: text.labelLarge,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        ..._mockNavBar(context, active: 1),
      ],
    );
  }
}

class _Segmented extends StatelessWidget {
  const _Segmented();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              for (final label in const ['Week', 'Month', 'Year'])
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: label == 'Month' ? scheme.primary : null,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        label,
                        style: theme.textTheme.labelLarge!.copyWith(
                          color: label == 'Month'
                              ? scheme.onPrimary
                              : scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
