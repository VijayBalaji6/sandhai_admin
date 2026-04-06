// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:sandhai_admin/app.dart';

void main() {
  testWidgets('App boots', (WidgetTester tester) async {
    await tester.pumpWidget(const SandhaiAdminApp());
    await tester.pump();

    expect(find.text('Sandhai Admin'), findsOneWidget);

    // Splash navigates after 2s; advance so no timer is left pending.
    await tester.pump(const Duration(seconds: 3));
  });
}
