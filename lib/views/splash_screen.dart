import 'package:flutter/material.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/widgets/common/all_widgets.dart';

import '../widgets/common/rotated_spinner.dart';

class SplashScreen extends StatelessWidget {
  static const String id = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    return Scaffold(
      body: Container(
        // margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/splash.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 300),
          child: Center(
            child: RotatedSpinner(
              spinnerColor: SpinnerColor.GREEN,
              width: 45,
              height: 45,
            ),
          ),
        ),
      ),
    );
  }
}
