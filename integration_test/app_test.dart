import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mobileapp/views/auth/auth.dart';
import '../lib/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 5));

      await Future.delayed(Duration(seconds: 10));
      Finder finderButton = find.byKey(Key('loginButtonKey'));
      expect(finderButton, findsOneWidget);
      await tester.tap(finderButton);
      await Future.delayed(Duration(seconds: 5));
    });
  });
}
