import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../layout/layout_scope.dart';
import '../widgets/feature_card.dart';
import '../widgets/feature_visuals.dart';
import '../widgets/section_title.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  static const _cards = <Widget>[
    FeatureCard(
      visual: RecordVisual(),
      title: 'Record in seconds',
      description: 'Pick a cat, jot a few words. Your day is logged in a few '
          'taps.',
    ),
    FeatureCard(
      visual: CustomizeVisual(),
      title: 'Fully customizable',
      description: 'Edit the blocks and icons to fit your lifestyle.',
    ),
    FeatureCard(
      visual: PacksVisual(),
      title: 'Decorate with cat packs',
      description: 'Swap in cats that fit your vibe and make the calendar '
          'yours.',
    ),
    FeatureCard(
      visual: MoodMixVisual(),
      title: 'Track your mood shifts',
      description: 'See how your mood is shaped by parts of your day.',
    ),
    FeatureCard(
      visual: PatternsVisual(),
      title: 'Find your patterns',
      description: 'Personal reports reveal the rhythm of your weeks and '
          'months.',
    ),
    FeatureCard(
      visual: PawVisual(),
      title: 'A little paw every day',
      description: 'A small, kind note is waiting for you each morning.',
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
            eyebrow: 'FEATURES',
            title: 'Small taps, big picture',
            subtitle: 'Everything you need to keep a diary you actually keep.',
          ),
          SizedBox(height: compact ? AppSpacing.xxlg : 56),
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              mainAxisSpacing: gap,
              crossAxisSpacing: gap,
              mainAxisExtent: compact ? 340 : 420,
            ),
            children: _cards,
          ),
        ],
      ),
    );
  }
}
