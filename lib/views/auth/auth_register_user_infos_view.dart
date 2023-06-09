import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/widgets/common/same_information_like_id_widget.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/widgets/forms/register_user_infos_form_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';
import 'package:screen_size_test/screen_size_test.dart';

class AuthRegisterUserInfosView extends StatelessWidget {
  static const String id = '/register-user-infos';

  const AuthRegisterUserInfosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    return Scaffold(
      appBar: XemoAppBar(leading: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25.h,
            ),
            SameInformationIDWidget(),
            Container(
              margin: EdgeInsets.only(right: 0.06.sw, left: 0.05.sw, top: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "auth.register.title".tr,
                    textAlign: TextAlign.start,
                    style: XemoTypography.headLine1Black(context),
                  ),
                  const RegisterUserInfosFormWidget()
                ],
              ),
            ),
            //form here
          ],
        ),
      ),
    );
  }
}
