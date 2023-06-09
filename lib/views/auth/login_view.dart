import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/widgets/forms/login_form_widget.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';
//import 'package:screen_size_test/screen_size_test.dart';

class LoginView extends StatelessWidget {
  static const String id = '/login';

  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();

    authController.resetauthData();
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    return Scaffold(
      appBar: XemoAppBar(leading: true, function: authController.clearData),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 0.06.sw, left: 0.05.sw),
              //padding: EdgeInsets.only(right: 0.03.sw, left: 0.03.sw),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 25.h,
                  ),
                  Text(
                    "common.signIn".tr,
                    style: XemoTypography.headLine1Black(context),
                  ),
                  const LoginFormWidget()
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: null,
    );
  }
}
