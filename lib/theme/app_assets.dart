import 'mood.dart';

abstract class AppAssets {
  static const _dir = 'assets/images';

  static const appIcon = '$_dir/app_icon.png';
  static const fabCat = '$_dir/fab_cat.png';
  static const heroCalm = '$_dir/hero_calm.png';

  /// Tight face crop on a tinted circle (calendar, chips, lists).
  static String face(Mood mood) => '$_dir/face_${mood.name}.png';

  /// Full illustration (cat packs, report, hero art).
  static String cat(Mood mood) => '$_dir/cat_${mood.name}.png';
}
