import 'package:flutter/material.dart';

import '../../theme/app_assets.dart';
import '../../theme/app_theme.dart';
import '../layout/layout_scope.dart';
import '../section_id.dart';
import '../widgets/pill_button.dart';

/// Links shown in the nav bar and the mobile drawer.
const navLinks = <(String, SectionId)>[
  ('Home', SectionId.hero),
  ('Features', SectionId.features),
  ('Cats', SectionId.packs),
  ('Plus', SectionId.pricing),
  ('FAQ', SectionId.footer),
];

class NavBar extends StatelessWidget {
  const NavBar({required this.onSelect, required this.onDownload, super.key});

  final ValueChanged<SectionId> onSelect;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    final compact = LayoutScope.compactOf(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    final logoSize = compact ? 36.0 : 44.0;
    final brand = Row(
      mainAxisSize: MainAxisSize.min,
      spacing: compact ? 10 : AppSpacing.md,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(logoSize * 0.25),
          child: Image.asset(
            AppAssets.appIcon,
            width: logoSize,
            height: logoSize,
            semanticLabel: 'Purrday logo',
          ),
        ),
        Text(
          'Purrday',
          style: compact
              ? text.titleLarge
              : text.titleLarge!.copyWith(fontSize: 26, height: 32 / 26),
        ),
      ],
    );

    return SectionContainer(
      child: SizedBox(
        height: compact ? 72 : 96,
        child: compact
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  brand,
                  IconButton(
                    tooltip: 'Menu',
                    icon: const Icon(Icons.menu_rounded, size: 28),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  brand,
                  Row(
                    spacing: AppSpacing.md,
                    children: [
                      for (final (label, id) in navLinks)
                        TextButton(
                          onPressed: () => onSelect(id),
                          style: TextButton.styleFrom(
                            foregroundColor: id == SectionId.hero
                                ? scheme.onSurface
                                : scheme.onSurfaceVariant,
                            textStyle: text.labelLarge,
                          ),
                          child: Text(label),
                        ),
                    ],
                  ),
                  Row(
                    spacing: AppSpacing.xl,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: AppSpacing.xxs,
                        children: [
                          Text(
                            'English',
                            style: text.labelLarge!.copyWith(
                              fontSize: 15,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                          Icon(
                            Icons.expand_more_rounded,
                            size: 18,
                            color: scheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                      PillButton(label: 'Download', onPressed: onDownload),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
