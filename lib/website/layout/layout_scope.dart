import 'package:flutter/widgets.dart';

import '../../theme/app_theme.dart';

abstract class Breakpoints {
  /// Below this width the page uses the compact (mobile) layout.
  static const double desktop = 960;

  /// Max width of the page content.
  static const double contentMax = 1120;
}

/// Tells descendants whether the page is in its compact (mobile) layout.
class LayoutScope extends InheritedWidget {
  const LayoutScope({required this.compact, required super.child, super.key});

  final bool compact;

  static bool compactOf(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<LayoutScope>();
    assert(scope != null, 'No LayoutScope found in context');
    return scope!.compact;
  }

  @override
  bool updateShouldNotify(LayoutScope oldWidget) =>
      compact != oldWidget.compact;
}

/// Centers content at [Breakpoints.contentMax] with responsive side padding.
class SectionContainer extends StatelessWidget {
  const SectionContainer({
    required this.child,
    this.top = 0,
    this.bottom = 0,
    super.key,
  });

  final Widget child;
  final double top;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    final compact = LayoutScope.compactOf(context);
    final side = compact ? AppSpacing.xl : AppSpacing.xxxl;

    return Padding(
      padding: EdgeInsets.fromLTRB(side, top, side, bottom),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Breakpoints.contentMax),
          child: SizedBox(width: double.infinity, child: child),
        ),
      ),
    );
  }
}
