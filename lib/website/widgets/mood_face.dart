import 'package:flutter/material.dart';

import '../../theme/app_assets.dart';
import '../../theme/mood.dart';

class MoodFace extends StatelessWidget {
  const MoodFace(
    this.mood, {
    required this.size,
    this.illustration = false,
    super.key,
  });

  final Mood mood;
  final double size;

  /// Use the full illustration instead of the tight face crop.
  final bool illustration;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      illustration ? AppAssets.cat(mood) : AppAssets.face(mood),
      width: size,
      height: size,
      semanticLabel: '${mood.label} cat',
      filterQuality: FilterQuality.medium,
    );
  }
}
