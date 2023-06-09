import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/widgets/common/xemo_logo_circule_with_background.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';
import 'package:screen_size_test/screen_size_test.dart';

Future<void> openEmailHasBeenSentDialog() async {
  Get.dialog(const EmailHasBeenSentDialogWidget(), barrierDismissible: true, useSafeArea: true);
}

class EmailHasBeenSentDialogWidget extends StatelessWidget {
  const EmailHasBeenSentDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();

    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: 315.h,
        width: 335.w,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: -63,
              left: 75.w,
              right: 75.w,
              child: const XemoLogoCirculeWhiteBackground(),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 85.h,
                      ),
                      Text(
                        "email.has.been.sent".tr,
                        style: XemoTypography.headLine4FullName(context)!.copyWith(fontSize: 24.sp, color: Get.theme.primaryColorLight),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.h, left: 22.0, right: 22.0),
                        child: Text(
                          "email.has.been.sent.text".tr,
                          textAlign: TextAlign.center,
                          style: XemoTypography.bodySemiBold(context)!.copyWith(color: kLightDisplayInfoText),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      //
                      Get.back();
                      //display snackbar the email has been sent
                    },
                    child: Container(
                      width: 335.w,
                      height: 50.h,
                      margin: EdgeInsets.only(bottom: 12.h, left: 16.w, right: 16.w),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          //border: Border.all(color: Colors.black, width: 0.1),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.35), blurRadius: 5, offset: Offset(0, 2))],
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          color: kLightDisplaySecondaryActionAlt),
                      child: Center(
                        child: Text(
                          "dialog.close".tr.toUpperCase(),
                          style: XemoTypography.buttonAllCapsWhite(context)!.copyWith(color: kLightDisplayOnSecondaryAction),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
