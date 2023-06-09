
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/theme.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/widgets/buttons/login_button_widget.dart';
import 'package:mobileapp/widgets/buttons/new_member_button_widget.dart';
import 'package:mobileapp/widgets/caroussel/caroussel_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';


class LandingView extends StatelessWidget {
  /// This page is for asking users which user will select which auth they
  /// will use for logging in
  static const String id = '/landing-view';

  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OriginController appSettingsController = Get.find<OriginController>();

    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      appBar: XemoAppBar(leading: false),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(
            top: XemoTransferTheme.heightScalingPercent(0.76),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                //Logo
                // _logoWidget(context, width: XemoTransferTheme.widthScalingPercent(294), height: XemoTransferTheme.heightScalingPercent(77)),
                Container(
                  height: 20.h,
                ),
                Container(
                    height: 335.h,
                    padding: EdgeInsets.only(
                      top: XemoTransferTheme.heightScalingPercent(0.h),
                    ),
                    width: Get.width,
                    child: const CarousselWidget()),
                SizedBox(
                  height: XemoTransferTheme.heightScalingPercent(100.h),
                ),
                //Sign in with Cred*
                //          margin: EdgeInsets.only(right: 0.05.sw, left: 0.05.sw, top: 20.h),
                Container(
                  margin: EdgeInsets.only(right: 0.05.sw, left: 0.05.sw),
                  child: Column(
                    //  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LoginButtonWidget(),
                      const NewMemberButtonWidget(),
                      Container(
                        margin: EdgeInsets.only(top: 25.h),
                        child: Text(
                          "Version " + appSettingsController.version.value,
                          style: XemoTypography.bodyDefault(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
