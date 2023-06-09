import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

void startSuccessfullyUpdatedDataSnackbar() {
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
    duration: const Duration(seconds: 5),
    titleText: Text(
      'send.money.congratulations'.tr,
      style: XemoTypography.bodySmallSemiBald(Get.context!)!.copyWith(color: kLightDisplayPrimaryAction),
    ),
    padding: EdgeInsets.only(left: 40.w, right: 10.w, top: 20.h, bottom: 20.h),
    messageText: Text(
      'snackbar.success.updatedData'.tr,
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
