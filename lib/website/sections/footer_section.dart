import 'package:flutter/material.dart';

import '../../theme/app_assets.dart';
import '../../theme/app_theme.dart';
import '../layout/layout_scope.dart';
import '../layout/web_text.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final compact = LayoutScope.compactOf(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    const brand = _Brand();
    const explore = _LinkColumn(
      heading: 'EXPLORE',
      items: ['Home', 'FAQ', 'Blog'],
    );
    const legal = _LinkColumn(
      heading: 'LEGAL',
      items: ['Terms of Use', 'Privacy Policy'],
    );
    const contact = _LinkColumn(
      heading: 'CONTACT US',
      items: ['hello@purrday.app', 'Instagram · YouTube · Pinterest'],
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: scheme.outlineVariant)),
      ),
      child: SectionContainer(
        top: compact ? AppSpacing.xxxl : AppSpacing.huge,
        bottom: AppSpacing.xxlg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (compact)
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpacing.xxlg,
                children: [brand, explore, legal, contact],
              )
            else
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpacing.xxlg,
                children: [
                  Expanded(flex: 16, child: brand),
                  Expanded(flex: 10, child: explore),
                  Expanded(flex: 10, child: legal),
                  Expanded(flex: 14, child: contact),
                ],
              ),
            const SizedBox(height: AppSpacing.xxxl),
            Text(
              '© 2026 Purrday. All rights reserved.',
              style: text.bodySmall!.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 14,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.md,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Image.asset(AppAssets.appIcon, width: 44, height: 44),
            ),
            Text(
              'Purrday',
              style: text.titleLarge!.copyWith(fontSize: 26, height: 32 / 26),
            ),
          ],
        ),
        Text(
          'Mood diary for cat people.\nEvery day counts.',
          style: text.bodyMedium!.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _LinkColumn extends StatelessWidget {
  const _LinkColumn({required this.heading, required this.items});

  final String heading;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.md,
      children: [
        Text(
          heading,
          style: text.eyebrow.copyWith(color: theme.colorScheme.primary),
        ),
        for (final item in items) Text(item, style: text.bodyMedium),
      ],
    );
  }
}
