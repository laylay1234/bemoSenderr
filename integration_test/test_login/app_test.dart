import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/views/auth/auth.dart';
import 'package:mobileapp/views/home_view.dart';
import '../../lib/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 10));
      // enter the login screen by clicking the login button
      Finder finderButton = find.byKey(Key('loginButtonKey'));
      expect(finderButton, findsOneWidget);
      await tester.tap(finderButton);

      //
      await Future.delayed(Duration(seconds: 2));
      AuthController authController = Get.find<AuthController>();
      // fill the phone field
      Finder phoneFieldFinder = find.byKey(authController.phoneKey.value);
      await tester.enterText(phoneFieldFinder, '3069884048');

      await Future.delayed(Duration(seconds: 2));
      // fill the password field
      Finder passwordFieldFinder = find.byKey(authController.passwordKey.value);
      await tester.enterText(passwordFieldFinder, '12345678');

      //click on the login button and wait
      Finder loginButtonFinder = find.byKey(Key('login_button_key'));
      await tester.tap(loginButtonFinder);

      await Future.delayed(Duration(seconds: 30));

      expect(HomeView.id, Get.currentRoute);

      //
    });
  });
}
