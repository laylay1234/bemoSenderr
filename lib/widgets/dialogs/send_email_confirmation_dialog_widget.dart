import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/views/home_view.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/common/xemo_logo_circule_with_background.dart';
import 'package:mobileapp/widgets/dialogs/email_has_been_sent_dialog_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

Future<void> openConfirmEmailDialog() async {
  Get.dialog(const SendEmailConfirmationDialogWidget(), barrierDismissible: true, useSafeArea: true);
}

class SendEmailConfirmationDialogWidget extends StatelessWidget {
  const SendEmailConfirmationDialogWidget({Key? key}) : super(key: key);

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
        width: 355,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Positioned(top: -60, left: 115.w, child: const XemoLogoCirculeWhiteBackground()),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 80.h,
                      ),
                      Text(
                        "email.confirm".tr,
                        style: XemoTypography.headLine4FullName(context)!.copyWith(fontSize: 24.sp, color: Get.theme.primaryColorLight),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.h),
                        child: Text(
                          "email.confirm.text".tr,
                          textAlign: TextAlign.center,
                          style: XemoTypography.bodySemiBold(context)!.copyWith(color: kLightDisplayInfoText),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      //
                      Get.dialog(
                          WillPopScope(
                            //no going back :)
                            onWillPop: () {
                              return Future.value(false);
                            },
                            child: Center(
                              child: RotatedSpinner(
                                spinnerColor: SpinnerColor.GREEN,
                                height: 35,
                                width: 35,
                              ),
                            ),
                          ),
                          barrierDismissible: false);
                      try {
                        await profileController.sendConfirmationEmail();
                        Get.back();
                        Get.back();
                        openEmailHasBeenSentDialog();
                      } catch (e) {
                        if (Get.isOverlaysOpen) {
                          Get.back();
                        }
                      }
                      //display snackbar the email has been sent
                    },
                    child: Container(
                      width: 335.w,
                      height: Get.locale!.languageCode == 'fr' ? 50.h : 50.h,
                      margin: EdgeInsets.only(bottom: 8.h, left: 10.w, right: 10.w),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5)],
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: kLightDisplayPrimaryAction),
                      child: Center(
                        child: Text(
                          "email.send.email".tr,
                          textAlign: TextAlign.center,
                          style: XemoTypography.buttonAllCapsWhite(context),
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
