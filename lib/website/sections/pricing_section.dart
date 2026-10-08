import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../layout/layout_scope.dart';
import '../widgets/pill_button.dart';
import '../widgets/section_title.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({required this.onGetApp, super.key});

  final VoidCallback onGetApp;

  /// (feature, Free value, Plus value). '✓' = included, '–' = not included.
  static const _rows = <(String, String, String)>[
    ('Custom blocks', '✓', '✓'),
    ('Basic analysis', '✓', '✓'),
    ('In-depth analysis', '–', '✓'),
    ('Ad-free', '–', '✓'),
    ('Photos per day', '1', '3'),
    ('Device sync', '–', 'All devices'),
    ('Cat packs', '1 free pack', 'All packs'),
  ];

  @override
  Widget build(BuildContext context) {
    final compact = LayoutScope.compactOf(context);
    final scheme = Theme.of(context).colorScheme;

    final free = _PlanCard(
      name: 'Free',
      price: r'$0',
      unit: 'forever',
      note: 'Everything you need to start',
      rows: [for (final r in _rows) (r.$1, r.$2)],
      button: PillButton(
        label: 'Get Purrday',
        style: PillStyle.outlined,
        height: 52,
        expand: true,
        onPressed: onGetApp,
      ),
    );
    final plus = _PlanCard(
      name: 'Purrday Plus',
      price: r'$39.99',
      unit: '/year',
      strikePrice: r'$83.88',
      note: 'Save 53% · or \$6.99/month · 7 days free',
      rows: [for (final r in _rows) (r.$1, r.$3)],
      popular: true,
      button: PillButton(
        label: 'Begin free trial',
        height: 52,
        expand: true,
        onPressed: onGetApp,
      ),
    );

    return SectionContainer(
      top: compact ? AppSpacing.huge : AppSpacing.section,
      bottom: compact ? AppSpacing.huge : AppSpacing.section,
      child: Column(
        children: [
          Icon(Icons.workspace_premium_rounded, size: 40, color: scheme.primary),
          const SizedBox(height: AppSpacing.lg),
          const SectionTitle(
            eyebrow: 'PURRDAY PLUS',
            title: 'Choose the plan that fits you best',
            subtitle: 'Completely free for 7 days. Cancel anytime.',
          ),
          SizedBox(height: compact ? AppSpacing.xxlg : AppSpacing.xxxl),
          if (compact)
            Column(
              spacing: AppSpacing.xl,
              children: [plus, free],
            )
          else
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: AppSpacing.xxlg,
                children: [
                  Expanded(child: free),
                  Expanded(child: plus),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.name,
    required this.price,
    required this.unit,
    required this.note,
    required this.rows,
    required this.button,
    this.strikePrice,
    this.popular = false,
  });

  final String name;
  final String price;
  final String unit;
  final String? strikePrice;
  final String note;
  final List<(String, String)> rows;
  final Widget button;
  final bool popular;

  @override
  Widget build(BuildContext context) {
    final compact = LayoutScope.compactOf(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;
    final muted = text.bodyMedium!.copyWith(color: scheme.onSurfaceVariant);

    return Stack(
      fit: StackFit.passthrough,
      clipBehavior: Clip.none,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surfaceContainer,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: popular ? scheme.primary : scheme.surfaceContainer,
              width: 2,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(compact ? AppSpacing.xl : AppSpacing.xxlg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(name, style: text.headlineMedium),
                const SizedBox(height: AppSpacing.xxs),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  spacing: AppSpacing.sm,
                  children: [
                    Text(price, style: text.displayMedium),
                    Text(unit, style: muted),
                    if (strikePrice != null)
                      Text(
                        strikePrice!,
                        style: muted.copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(note, style: muted),
                const SizedBox(height: AppSpacing.lg),
                for (final (label, value) in rows)
                  _PlanRow(label: label, value: value, compact: compact),
                const SizedBox(height: AppSpacing.xl),
                button,
              ],
            ),
          ),
        ),
        if (popular)
          Positioned(
            right: AppSpacing.xl,
            top: -14,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.primary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md + 2,
                  vertical: AppSpacing.xxs,
                ),
                child: Text(
                  'POPULAR',
                  style: text.labelSmall!.copyWith(
                    letterSpacing: 1,
                    color: scheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _PlanRow extends StatelessWidget {
  const _PlanRow({
    required this.label,
    required this.value,
    required this.compact,
  });

  final String label;
  final String value;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    final Widget trailing = switch (value) {
      '✓' => Icon(
          Icons.check_rounded,
          size: 22,
          color: scheme.primary,
          semanticLabel: 'Included',
        ),
      '–' => Semantics(
          label: 'Not included',
          child: Text(
            '—',
            style: text.labelLarge!.copyWith(color: scheme.outlineVariant),
          ),
        ),
      _ => Text(value, style: text.labelLarge),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: scheme.outlineVariant)),
      ),
      child: SizedBox(
        height: compact ? 44 : 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: text.bodyMedium),
            trailing,
          ],
        ),
      ),
    );
  }
}
