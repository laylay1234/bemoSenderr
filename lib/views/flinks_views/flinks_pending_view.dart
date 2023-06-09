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

import '../auth/auth_register_user_infos_view.dart';

class FlinksPendingView extends StatelessWidget {
  static const String id = '/Flinks-Pending-View';

  const FlinksPendingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //AuthController authController = Get.find<AuthController>();
    // log(authController.formateAndStandardizePhoneNumber());
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    return MBScrollableScaffold(
      appBar: XemoAppBar(leading: false),
      body: Container(
        margin: EdgeInsets.only(right: 0.06.sw, left: 0.05.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 30,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'flinks.success.connect.with.your.bank'.tr,
                style: XemoTypography.headLine1Black(context)!.copyWith(fontSize: 29.sp, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 33.h),
              child: SvgPicture.asset(
                'assets/xemo/flinks_cloud_icon.svg',
                color: Get.theme.primaryColorLight,
                height: 88.h,
                width: 88.w,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.h),
              child: SvgPicture.asset(
                'assets/xemo/flinks_pending_icon.svg',
                color: Get.theme.primaryColorLight,
                height: 61.h,
                width: 61.w,
              ),
            ),
            Padding(
              //        margin: EdgeInsets.only(right: 0.05.sw, left: 0.04.sw),
              padding: EdgeInsets.only(right: 0.05.sw, left: 0.04.sw, top: 55.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "flinks.success.thank.you.for".tr,
                    textAlign: TextAlign.center,
                    style: XemoTypography.headLine6Black(context),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Text(
                      "flinks.success.please.continue".tr,
                      textAlign: TextAlign.center,
                      style: XemoTypography.bodySemiBold(context),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // Get.toNamed(ConnectWithFlinksWebView.id, arguments: {'fromRegister': false});
                Get.offNamed(AuthRegisterUserInfosView.id);
              },
              child: Container(
                height: 50.h,
                width: 325.w,
                margin: EdgeInsets.only(top: 126.h),
                decoration: const BoxDecoration(
                    color: kLightDisplayPrimaryAction,
                    boxShadow: [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(1, 1))],
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    )),
                child: Center(
                  child: Text("common.continue".tr.toUpperCase(), style: XemoTypography.buttonAllCapsWhite(context)),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: null,
    );
  }
}
