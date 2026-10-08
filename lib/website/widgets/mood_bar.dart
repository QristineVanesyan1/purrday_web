import 'package:flutter/material.dart';

/// Horizontal bar for the mood mix: a track with a rounded fill.
class MoodBar extends StatelessWidget {
  const MoodBar({
    required this.fraction,
    required this.color,
    this.height = 12,
    super.key,
  });

  final double fraction;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(height / 2);

    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: radius,
        child: ColoredBox(
          color: scheme.surfaceContainerHighest,
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: fraction.clamp(0.0, 1.0),
            heightFactor: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(color: color, borderRadius: radius),
            ),
          ),
        ),
      ),
    );
  }
}
