import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/scaffolds/sb_scrollable_scaffold.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/widgets/buttons/connect_with_flinks_button_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import 'auth_register_user_infos_view.dart';

class AuthConnectWithFlinksView extends StatelessWidget {
  static const String id = '/register-connect-flinks';

  const AuthConnectWithFlinksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //AuthController authController = Get.find<AuthController>();
    // log(authController.formateAndStandardizePhoneNumber());
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    return MBScrollableScaffold(
      appBar: XemoAppBar(leading: true, function: backLogoutInSignUp),
      body: Container(
        margin: EdgeInsets.only(right: 0.06.sw, left: 0.05.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 116.h),
              child: SvgPicture.asset(
                'assets/xemo/icon-lock.svg',
                color: Get.theme.primaryColorLight,
                height: 98.h,
                width: 74.w,
              ),
            ),
            Padding(
              //        margin: EdgeInsets.only(right: 0.05.sw, left: 0.04.sw),
              padding: EdgeInsets.only(right: 0.05.sw, left: 0.04.sw, top: 55.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "auth.signup.consent".tr,
                    textAlign: TextAlign.start,
                    style: XemoTypography.bodySmall(context),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 13.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.solidCircleCheck,
                          size: 25,
                          color: Get.theme.primaryColorLight,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 7.h),
                            width: 267.w,
                            child: Text(
                              "auth.signup.consent.first".tr,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: XemoTypography.bodySmall(context)!.copyWith(color: kLightDisplayInfoText),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 13.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          // ignore: deprecated_member_use
                          FontAwesomeIcons.solidCheckCircle,
                          size: 25,
                          color: Get.theme.primaryColorLight,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 7.h),
                            width: 260.w,
                            child: Text(
                              "auth.signup.consent.second".tr,
                              textAlign: TextAlign.start,
                              style: XemoTypography.bodySmall(context)!.copyWith(color: kLightDisplayInfoText),
                              maxLines: 3,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(margin: EdgeInsets.only(top: 30.h), child: const ConnectWithFlinksButtonWidget()),
            GestureDetector(
              onTap: () {
                //navigate to next screen
                Get.toNamed(AuthRegisterUserInfosView.id);
              },
              child: Container(
                margin: EdgeInsets.only(top: 100.h),
                child: Text("auth.signup.bank.skip.connection".tr, style: XemoTypography.buttonUnderlined(context)),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: null,
    );
  }

  void backLogoutInSignUp() async {
    AuthController authController = Get.find<AuthController>();
    Get.dialog(Center(
      child: RotatedSpinner(
        spinnerColor: SpinnerColor.GREEN,
        height: 45,
        width: 45,
      ),
    ));
    await authController.logout();
    if (Get.isOverlaysOpen) {
      Get.back();
    }
  }
}
