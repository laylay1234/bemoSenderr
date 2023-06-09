import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class BadgeUserTierLevelWidget extends StatelessWidget {
  const BadgeUserTierLevelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final ProfileController profileController = Get.find<ProfileController>();

    return SizedBox(
      height: 109.h,
      child: Column(
        children: [
          Container(
            height: 5.h,
          ),
          SvgImageByUserTierLevel(profileController.userInstance!.value.kyc_level),
          Container(
            height: 10.h,
          ),
          TextByUserTierLevel(profileController.userInstance!.value.kyc_level, context)
        ],
      ),
    );
  }

  Widget SvgImageByUserTierLevel(int level) {
    switch (level) {
      case 0:
        return SvgPicture.asset(
          'assets/xemo/icon-account-level-2.svg',
          height: 64.h,
          width: 64.w,
        );
      case 1:
        return SvgPicture.asset(
          'assets/xemo/icon-account-level-3.svg',
          height: 64.h,
          width: 64.w,
        );
      case 2:
        return SvgPicture.asset(
          'assets/xemo/icon-account-level-3.svg',
          height: 64.h,
          width: 64.w,
        );
      default:
        return SvgPicture.asset(
          'assets/xemo/icon-account-level-2.svg',
          height: 64.h,
          width: 64.w,
        );
    }
  }

  Widget TextByUserTierLevel(int level, BuildContext context) {
    switch (level) {
      case 0:
        return Text(
          "userTier.widget.connect.verified".tr,
          textAlign: TextAlign.center,
          style: XemoTypography.captionLightAllCaps(context),
        );
      case 1:
        return Text(
          "userTier.widget.connect.premium".tr,
          textAlign: TextAlign.center,
          style: XemoTypography.captionLightAllCaps(context),
        );
      case 2:
        return Text(
          "userTier.widget.connect.premium".tr,
          textAlign: TextAlign.center,
          style: XemoTypography.captionLightAllCaps(context),
        );
      default:
        return Text(
          "userTier.widget.connect.verified".tr,
          textAlign: TextAlign.center,
          style: XemoTypography.captionLightAllCaps(context),
        );
    }
  }
}
