import 'package:flutter/material.dart';

import 'app_theme.dart';

enum Mood {
  joyful('Joyful', AppColors.joyful),
  calm('Calm', AppColors.calm),
  meh('Meh', AppColors.meh),
  sad('Sad', AppColors.sad),
  grumpy('Grumpy', AppColors.grumpyTan);

  const Mood(this.label, this.color);

  final String label;
  final Color color;
}
