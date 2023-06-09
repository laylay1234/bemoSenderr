import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/widgets/common/kyc_bank_verification_status_widget.dart';
import 'package:mobileapp/widgets/home/settings_widgets/about_xemo_item_widget.dart';
import 'package:mobileapp/widgets/home/settings_widgets/delete_my_account_item_widget.dart';
import 'package:mobileapp/widgets/home/settings_widgets/disconnect_item_widget.dart';
import 'package:mobileapp/widgets/home/settings_widgets/general_conditions_item_widget.dart';
import 'package:mobileapp/widgets/home/settings_widgets/help_support_item_widget.dart';
import 'package:mobileapp/widgets/home/settings_widgets/privay_policy_item_widget.dart';
import 'package:mobileapp/widgets/home/settings_widgets/settings_profile_item_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';
import 'package:platform/platform.dart';

class SettingsView extends StatelessWidget {
  static const String id = '/settings-view';

  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OriginController appSettingsController = Get.find<OriginController>();
    ProfileController profileController = Get.find<ProfileController>();

    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "menu.settings".tr,
                    style: XemoTypography.headLine1Black(context),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.h, bottom: 8),
                    child: Text(
                      "account.settings".tr,
                      style: XemoTypography.captionDefault(context)!.copyWith(color: kLightDisplaySecondaryTextColor),
                    ),
                  ),
                ],
              ),
            ),
            const SettingsProfileItemWidget(),
            KycBankVerificationStatusWidget(
              inSettings: true,
            ),
            Container(
              margin: EdgeInsets.only(top: 15.h, left: 14.0, bottom: 8),
              child: Text(
                "settings.item.aboutXemo".tr,
                style: XemoTypography.captionDefault(context)!.copyWith(color: kLightDisplaySecondaryTextColor),
              ),
            ),
            const AboutXemoItemWidget(),
            const HelpSupportItemWidget(),
            const GeneralConditionsItemWidget(),
            const PrivacyPolictyItemWidget(),
            const DeleteMyAccountItemWidget(),
            const DisconnectItemWidget(),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 15.h, bottom: 10.h),
                child: Text(
                  "Version " + appSettingsController.version.value,
                  style: XemoTypography.bodyDefault(context)!.copyWith(color: kLightDisplaySecondaryTextColor),
                ))
          ],
        ),
      ),
    );
  }
}
