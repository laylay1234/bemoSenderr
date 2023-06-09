import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class KycBankVerificationBottomText extends StatelessWidget {
  const KycBankVerificationBottomText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final ProfileController profileController = Get.find<ProfileController>();

    return Container(
      width: 360.w,
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h, bottom: 5.h),
      child: profileController.userInstance!.value.kyc_level == 0
          ? RichText(
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              text: TextSpan(children: [
                TextSpan(
                  text: 'userTier.widget.connect.transfer.bottom.up.to.1'.tr,
                  style: XemoTypography.captionSemiBold(context),
                ),
                TextSpan(
                  text: 'userTier.widget.connect.unverified'.tr,
                  style: XemoTypography.captionSemiBold(context)!.copyWith(color: kLightComplementryAction),
                )
              ]))
          : profileController.userInstance!.value.kyc_level == 1
              ? RichText(
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'userTier.widget.connect.transfer.bottom.up.to.2'.tr,
                      style: XemoTypography.captionSemiBold(context),
                    ),
                    TextSpan(
                      text: 'userTier.widget.connect.verified'.tr,
                      style: XemoTypography.captionSemiBold(context)!.copyWith(color: kLightComplementryAction),
                    )
                  ]))
              : Container(),
    );
  }
}
