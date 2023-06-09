import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/widgets/common/same_information_like_id_widget.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/widgets/forms/email_form_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class AuthRegisterUserCredentialView extends StatelessWidget {
  static const String id = '/register-user-creds';

  const AuthRegisterUserCredentialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    return Scaffold(
      appBar: XemoAppBar(leading: true),
      body: SingleChildScrollView(
        child: Container(
          //   margin: EdgeInsets.only(left: 0.03.sw, right: 0.03.sw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 25.h),
              SameInformationIDWidget(),
              Container(
                margin: EdgeInsets.only(right: 0.06.sw, left: 0.05.sw, top: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      //    margin: EdgeInsets.only(left: 0.005.sw, top: 20.h),
                      child: Text(
                        "common.auth.register.title".tr,
                        style: XemoTypography.headLine1Black(context),
                      ),
                    ),
                    const EmailPasswordFormWidget()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
