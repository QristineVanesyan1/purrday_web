import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'website/website_page.dart';

class PurrdayWebsite extends StatelessWidget {
  const PurrdayWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Purrday · Mood diary for cat people',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      // The site is dark-first. AppTheme.light is ready if you want to follow
      // the system setting: use ThemeMode.system and theme: AppTheme.light.
      themeMode: ThemeMode.dark,
      home: const WebsitePage(),
    );
  }
}
