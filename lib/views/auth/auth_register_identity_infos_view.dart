import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/widgets/common/same_information_like_id_widget.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/widgets/forms/register_identity_infos_form_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class AuthRegisterIdentityInfosView extends StatelessWidget {
  static const String id = '/register-identity-infos';

  const AuthRegisterIdentityInfosView({Key? key}) : super(key: key);

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
            Container(
              height: 25.h,
            ),
            SameInformationIDWidget(),
            Container(
              margin: EdgeInsets.only(right: 0.06.sw, left: 0.05.sw, top: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    //   padding: const EdgeInsets.only(left: 2.0),
                    child: Text(
                      "common.auth.register.title".tr,
                      style: XemoTypography.headLine1Black(context),
                    ),
                  ),
                  const RegisterIdentityInfosFormWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
