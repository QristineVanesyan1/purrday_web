import 'package:flutter/material.dart';

/// A flat circle used for the background decoration.
class Disc extends StatelessWidget {
  const Disc({required this.size, required this.color, super.key});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: SizedBox.square(dimension: size),
    );
  }
}
