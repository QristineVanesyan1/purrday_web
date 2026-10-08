import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// Shows a 390x844 app screen scaled into a phone-shaped frame.
///
/// The screen always renders with the dark app theme, whatever the page theme.
class PhoneFrame extends StatelessWidget {
  const PhoneFrame({required this.child, required this.width, super.key});

  static const designWidth = 390.0;
  static const designHeight = 844.0;

  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    final scale = width / designWidth;
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(44 * scale);
    final appTheme = AppTheme.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(color: scheme.outlineVariant, spreadRadius: 5),
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.55),
            blurRadius: 80,
            offset: const Offset(0, 40),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: SizedBox(
          width: width,
          height: designHeight * scale,
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: designWidth,
              height: designHeight,
              child: Theme(
                data: appTheme,
                child: Material(
                  color: appTheme.colorScheme.surface,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
