import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class SameInformationIDWidget extends StatelessWidget {
  // const SameInformationIDWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Spacer(),
        Container(
          width: 0.75.sw,
          // height: 72.h,
          decoration: const BoxDecoration(color: kLightDisplayToolTipBackgroundColor),
          padding: EdgeInsets.only(left: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                'assets/xemo/icon-id_register.svg',
                height: 22.h,
                width: 37.w,
                color: Get.theme.primaryColorLight,
              ),
              Expanded(
                child: Container(
                  height: 71.h,
                  padding: EdgeInsets.only(left: 7.w),
                  child: Center(
                    child: Text(
                      "auth.signup.details.desc".tr,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: XemoTypography.captionDefault(context),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Spacer(),
      ],
    );
  }
}
