import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../widgets/forms/register_phone_form_widget.dart';

class AuthRegisterPhoneView extends StatelessWidget {
  static const String id = '/register-phone';

  const AuthRegisterPhoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    OriginController originController = Get.find<OriginController>();
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    authController.clearData();
    return Scaffold(
        appBar: XemoAppBar(leading: true, function: authController.clearAll),
        body: Container(
          margin: EdgeInsets.only(right: 0.06.sw, left: 0.05.sw),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 25.h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 0.005.sw),
                  child: Text(
                    "common.auth.register.title".tr,
                    style: XemoTypography.headLine1Black(context),
                  ),
                ),

                //
                const RegisterPhoneFormWidget()
              ],
            ),
          ),
        ));
  }
}
