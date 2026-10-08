# Purrday website (Flutter web)

Responsive landing page for Purrday, built from the website boards in the
design canvas. Compact (mobile) layout below 960 px wide, desktop above.

## Run

```
flutter pub get
flutter run -d chrome
```

Needs Flutter 3.27 or newer (uses `Row.spacing` and `Color.withValues`).

If `flutter run` asks for platform folders, run `flutter create . --platforms=web`
once. It keeps the existing `lib/`, `web/index.html` and assets.

## Build

```
flutter build web
```

Upload the contents of `build/web/` to any static host. If you deploy under a
sub-path, pass `--base-href /your-path/`.

## Structure

```
lib/
  main.dart, app.dart          app entry and MaterialApp
  theme/                       palette, spacing, type scale, light + dark themes,
                               mood enum, asset paths
  website/
    website_page.dart          scroll view, nav-to-section links, mobile drawer
    layout/                    breakpoint, LayoutScope, SectionContainer, text sizes
    sections/                  nav, hero, intro, features, packs, pricing,
                               entries, CTA, footer
    widgets/                   phone frame + Home/Report screen mocks, feature
                               visuals, buttons, chips, mood faces
assets/images/                 mood faces, full cat illustrations, app icon, hero art
```

## Things to replace

- Store badges are drawn placeholders (`widgets/store_badges.dart`). Use the
  official App Store / Google Play artwork and add the links.
- Contact email, social links, Terms and Privacy are placeholders in
  `sections/footer_section.dart`.
- The "A peek inside" entries are sample content.
- Fonts (Fraunces, Nunito) load from Google Fonts at runtime. To bundle them,
  add the font files and replace the `GoogleFonts` calls in
  `theme/app_theme.dart`.
