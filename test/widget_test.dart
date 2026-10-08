import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purrday_website/app.dart';

void main() {
  testWidgets('landing page renders hero', (tester) async {
    tester.view.physicalSize = const Size(1440, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const PurrdayWebsite());
    expect(find.text('Every day, one little cat.'), findsOneWidget);
  });
}
