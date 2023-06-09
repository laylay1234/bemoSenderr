import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/utilities/text_phone_number_formatter.dart';
import 'package:mobileapp/views/home/settings_views/edit_profile_view.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class SettingsProfileItemWidget extends StatelessWidget {
  const SettingsProfileItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find<ProfileController>();
    AuthController authController = Get.find<AuthController>();
    OriginController originController = Get.find<OriginController>();

    return GestureDetector(
      onTap: () async {
        authController.setInitialDataForEditProfile();
        InternationlPhoneValidator().update(originController.origin_country_iso.value.toUpperCase());
        authController.phoneController.value.text = FormatPlainTextPhoneNumberByNumber()
            .format((originController.origin_calling_code.value + authController.phoneController.value.text))
            .substring(3);
        Get.toNamed(EditProfileView.id);
      },
      child: Container(
        margin: EdgeInsets.only(top: 5.h, right: 10.w),
        height: 82.h,
        width: 0.95.sw,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(3, 3))]),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            margin: EdgeInsets.only(left: 14.w),
            child: SvgPicture.asset(
              'assets/xemo/account_settings_avatar.svg',
              height: 40.h,
              width: 40.w,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20.h,
              ),
              Text(
                profileController.userInstance!.value.profile!.first_name + " " + profileController.userInstance!.value.profile!.last_name,
                textAlign: TextAlign.center,
                style: XemoTypography.bodySemiBold(context),
              ),
              Container(
                height: 5.h,
              ),
              Text(
                FormatPlainTextPhoneNumberByNumber().format(profileController.userInstance!.value.phone_number.startsWith('+')
                    ? profileController.userInstance!.value.phone_number
                    : ('+' + profileController.userInstance!.value.phone_number)),
                textAlign: TextAlign.center,
                style: XemoTypography.captionLight(context),
              )
            ],
          ),
          Container(
            width: 5.w,
          ),
          Container(
            width: 5.w,
          ),
          Container(
            margin: EdgeInsets.only(right: 10.w, top: 5.h),
            child: Column(
              children: [
                Container(
                  height: 10.h,
                ),
                SvgPicture.asset(
                  profileController.userInstance!.value.kyc_level == 0
                      ? 'assets/xemo/icon-account-level-1.svg'
                      : profileController.userInstance!.value.kyc_level == 1
                          ? 'assets/xemo/icon-account-level-2.svg'
                          : 'assets/xemo/icon-account-level-3.svg',
                  height: 34.h,
                  width: 34.w,
                ),
                Container(
                  height: 5.h,
                ),
                Text(
                  profileController.userInstance!.value.kyc_level == 0
                      ? "userTier.widget.connect.unverified".tr
                      : profileController.userInstance!.value.kyc_level == 1
                          ? "userTier.widget.connect.verified".tr
                          : "userTier.widget.connect.premium".tr,
                  textAlign: TextAlign.center,
                  style: XemoTypography.captionLightAllCaps(context),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
