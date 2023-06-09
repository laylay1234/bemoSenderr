import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/models/ModelProvider.dart';
import 'package:mobileapp/views/home_view.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

void onUserTierUpgradeErrorSnackBar(User user) {
  /*
  Get.showSnackbar(GetSnackBar(
    titleText: Text(
      'congratulations!',
      style: XemoTypography.bodySmallSemiBald(Get.context!),
    ),
    messageText: Text('your email was confirmed'),
    margin: EdgeInsets.only(left: 18.w, right: 18.w),
    snackPosition: SnackPosition.TOP,
    icon: SvgPicture.asset(
      'assets/xemo/yxLogo-small.svg',
      height: 40,
      width: 40,
    ),
  ));*/
  Get.closeAllSnackbars();
  Get.snackbar(
    '',
    '',
    onTap: (val) {
      ProfileController profileController = Get.find<ProfileController>();

      if (Get.currentRoute == HomeView.id) {
        profileController.currentIndex.value = 3;
        profileController.currentPage.value = profileController.views[3];
      } else {
        Get.offAllNamed(HomeView.id);
        profileController.currentIndex.value = 3;
        profileController.currentPage.value = profileController.views[3];
      }
    },
    duration: const Duration(seconds: 5),
    titleText: Text(
      'snackbar.error.userTierUpgrade'.tr + ' ${user.kyc_level}',
      style: XemoTypography.bodySmallSemiBald(Get.context!)!.copyWith(color: kLightDisplayErrorText),
    ),
    padding: EdgeInsets.only(left: 40.w, right: 10.w, top: 20.h, bottom: 20.h),
    messageText: Text(
      'common.dialog.text.tryAgainOrContact'.tr + ' ${user.kyc_level}',
      style: XemoTypography.captionSemiBold(Get.context!)!.copyWith(color: kLightDisplaySecondaryTextColor),
    ),
    icon: Container(
      decoration:
          BoxDecoration(boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 5)], shape: BoxShape.circle, color: Colors.white),
      padding: const EdgeInsets.all(12.0),
      child: SvgPicture.asset(
        'assets/xemo/yxLogo-small.svg',
        height: 30,
        width: 30,
      ),
    ),
    backgroundColor: kLightDisplayToolTipBackgroundColor,
  );
}
