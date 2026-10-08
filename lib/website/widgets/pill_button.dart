import 'package:flutter/material.dart';

enum PillStyle { filled, outlined }

/// Pill-shaped button. Colors and shape come from the theme.
class PillButton extends StatelessWidget {
  const PillButton({
    required this.label,
    required this.onPressed,
    this.style = PillStyle.filled,
    this.height = 44,
    this.expand = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final PillStyle style;
  final double height;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final size = Size(expand ? double.infinity : 0, height);

    return switch (style) {
      PillStyle.filled => FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(minimumSize: size),
          child: Text(label),
        ),
      PillStyle.outlined => OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(minimumSize: size),
          child: Text(label),
        ),
    };
  }
}
