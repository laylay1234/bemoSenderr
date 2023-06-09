import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../common/xemo_logo_circule_with_background.dart';

Future<void> openVersionValidationDialog() async {
  Get.dialog(const VersionValidationDialogWidget(), barrierDismissible: false, useSafeArea: true);
}

class VersionValidationDialogWidget extends StatelessWidget {
  const VersionValidationDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return Dialog(
        insetPadding: const EdgeInsets.all(10),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          height: 225.h,
          width: 380,
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: -60.h,
                left: 105.w,
                right: 105.w,
                child: const XemoLogoCirculeWhiteBackground(),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 65.h,
                      ),
                      Text(
                        "dialog.versionaValidation.title".tr,
                        textAlign: TextAlign.center,
                        style: XemoTypography.headLine4FullName(context)!.copyWith(fontSize: 20.sp, color: Get.theme.primaryColorLight),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.h),
                        child: Text(
                          "dialog.versionaValidation.message".tr,
                          textAlign: TextAlign.center,
                          style: XemoTypography.bodySemiBold(context)!.copyWith(color: kLightDisplayInfoText),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: GestureDetector(
                      onTap: () async {
                        //
                        //
                        authController.redirectToStore();
                        //display snackbar the email has been sent
                      },
                      child: Container(
                        width: 0.85.sw,
                        height: 50.h,
                        margin: EdgeInsets.only(bottom: 8.h),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: Offset(0, 3))],
                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                            color: kLightDisplayPrimaryAction),
                        child: Center(
                          child: Text(
                            //send.money.not.now
                            "dialog.versionaValidation.button".tr.toUpperCase(),
                            style: XemoTypography.buttonAllCapsWhite(context),
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
              )
            ],
          ),
        ));
  }
}
