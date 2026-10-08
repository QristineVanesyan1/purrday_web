import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'layout/layout_scope.dart';
import 'section_id.dart';
import 'sections/cta_section.dart';
import 'sections/entries_section.dart';
import 'sections/features_section.dart';
import 'sections/footer_section.dart';
import 'sections/hero_section.dart';
import 'sections/intro_section.dart';
import 'sections/nav_bar.dart';
import 'sections/packs_section.dart';
import 'sections/pricing_section.dart';

class WebsitePage extends StatefulWidget {
  const WebsitePage({super.key});

  @override
  State<WebsitePage> createState() => _WebsitePageState();
}

class _WebsitePageState extends State<WebsitePage> {
  final _keys = {for (final id in SectionId.values) id: GlobalKey()};
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _goTo(SectionId id) {
    if (id == SectionId.hero) {
      _scrollController.animateTo(
        0,
        duration: Durations.extralong1,
        curve: Easing.emphasizedDecelerate,
      );
      return;
    }
    final target = _keys[id]!.currentContext;
    if (target == null) return;
    Scrollable.ensureVisible(
      target,
      duration: Durations.extralong1,
      curve: Easing.emphasizedDecelerate,
    );
  }

  Widget _section(SectionId id, Widget child) =>
      KeyedSubtree(key: _keys[id], child: child);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < Breakpoints.desktop;

        return LayoutScope(
          compact: compact,
          child: Scaffold(
            endDrawer: compact ? _MenuDrawer(onSelect: _goTo) : null,
            body: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  NavBar(
                    onSelect: _goTo,
                    onDownload: () => _goTo(SectionId.cta),
                  ),
                  _section(SectionId.hero, const HeroSection()),
                  const IntroSection(),
                  _section(SectionId.features, const FeaturesSection()),
                  _section(SectionId.packs, const PacksSection()),
                  _section(
                    SectionId.pricing,
                    PricingSection(onGetApp: () => _goTo(SectionId.cta)),
                  ),
                  const EntriesSection(),
                  _section(SectionId.cta, const CtaSection()),
                  _section(SectionId.footer, const FooterSection()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MenuDrawer extends StatelessWidget {
  const _MenuDrawer({required this.onSelect});

  final ValueChanged<SectionId> onSelect;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final (label, id) in navLinks)
                ListTile(
                  title: Text(label, style: text.titleLarge),
                  onTap: () {
                    Navigator.of(context).pop();
                    onSelect(id);
                  },
                ),
              const Spacer(),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onSelect(SectionId.cta);
                },
                child: const Text('Download'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
