import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../layout/layout_scope.dart';
import '../layout/web_text.dart';
import '../widgets/app_mocks.dart';
import '../widgets/disc.dart';
import '../widgets/phone_frame.dart';
import '../widgets/store_badges.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final compact = LayoutScope.compactOf(context);
    final scheme = Theme.of(context).colorScheme;

    return ClipRect(
      child: Stack(
        children: [
          if (compact)
            Positioned(
              top: -98,
              right: -80,
              child: Disc(size: 240, color: scheme.secondaryContainer),
            ),
          Positioned(
            left: -140,
            bottom: -120,
            child: Disc(
              size: 420,
              color: scheme.primary.withValues(alpha: 0.07),
            ),
          ),
          SectionContainer(
            top: AppSpacing.lg,
            bottom: AppSpacing.huge,
            child: compact ? const _CompactHero() : const _DesktopHero(),
          ),
        ],
      ),
    );
  }
}

class _DesktopHero extends StatelessWidget {
  const _DesktopHero();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(flex: 11, child: _HeroCopy()),
        SizedBox(width: AppSpacing.xxxl),
        Expanded(
          flex: 9,
          child: FittedBox(fit: BoxFit.scaleDown, child: _PhonePair()),
        ),
      ],
    );
  }
}

class _CompactHero extends StatelessWidget {
  const _CompactHero();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _HeroCopy(),
        SizedBox(height: 36),
        Center(child: PhoneFrame(width: 242, child: HomeMock())),
      ],
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy();

  @override
  Widget build(BuildContext context) {
    final compact = LayoutScope.compactOf(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: compact ? AppSpacing.lg : AppSpacing.xl,
      children: [
        Text(
          'MOOD DIARY FOR CAT PEOPLE',
          style: text.eyebrow.copyWith(color: scheme.primary),
        ),
        Semantics(
          header: true,
          child: Text(
            'Every day, one little cat.',
            style: text.heroTitle(compact: compact),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Text(
            'Pick a cat that matches your mood, jot a few words and watch '
            'your month fill up with tiny faces.',
            style: text
                .lead(compact: compact)
                .copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: AppSpacing.sm),
          child: StoreBadges(),
        ),
        Text(
          'Free on iOS and Android · Purrday Plus free for 7 days',
          style: text.bodyMedium!.copyWith(
            fontSize: 14,
            color: scheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _PhonePair extends StatelessWidget {
  const _PhonePair();

  static const _phoneWidth = 281.0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 520,
      height: 740,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 60,
            top: 20,
            child: Disc(size: 560, color: scheme.secondaryContainer),
          ),
          const Positioned(
            left: 0,
            top: 50,
            child: PhoneFrame(width: _phoneWidth, child: HomeMock()),
          ),
          const Positioned(
            left: 240,
            top: 110,
            child: PhoneFrame(width: _phoneWidth, child: ReportMock()),
          ),
        ],
      ),
    );
  }
}
