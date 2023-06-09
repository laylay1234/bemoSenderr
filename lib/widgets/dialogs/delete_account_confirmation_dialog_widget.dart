import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/views/auth/auth_landing_view.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../controllers/auth_controller.dart';
import '../common/xemo_logo_circule_with_background.dart';

Future<void> openDeleteAccountConfirmationDialog() async {
  Get.dialog(DeleteAccountConfirmationDialogWidget(), barrierDismissible: true, useSafeArea: true);
}

class DeleteAccountConfirmationDialogWidget extends StatelessWidget {
  const DeleteAccountConfirmationDialogWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();

    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: 355.h,
        width: 350.w,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: -60.h,
              left: 75.w,
              right: 75.w,
              child: const XemoLogoCirculeWhiteBackground(),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
                  Container(
                    padding: EdgeInsets.only(left: 32.w, right: 32.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('settings.dialog.delete.account.title'.tr,
                              textAlign: TextAlign.center,
                              style: XemoTypography.bodySemiBold(context)!.copyWith(color: Get.theme.primaryColorLight, fontSize: 22.sp)),
                        ),
                        Container(
                          height: 20.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text('settings.dialog.delete.account.text'.tr,
                              textAlign: TextAlign.center,
                              style: XemoTypography.bodySemiBold(context)!.copyWith(color: Colors.black, fontSize: 16.sp)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 14.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            //   margin: EdgeInsets.only(left: 8.w),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 0.1),
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.35), blurRadius: 5, offset: Offset(0, 3))],
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: kLightDisplaySecondaryAction),
                            width: 150.w,
                            height: 50.h,
                            child: Center(
                              child: Text(
                                'common.no'.tr.capitalizeFirst!,
                                style: XemoTypography.buttonAllCapsWhite(context)!.copyWith(color: kLightDisplayOnSecondaryAction),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          //    margin: EdgeInsets.only(right: 8.w),
                          child: GestureDetector(
                            onTap: () async {
                              Get.dialog(Center(
                                child: RotatedSpinner(
                                  spinnerColor: SpinnerColor.GREEN,
                                  height: 35,
                                  width: 35,
                                ),
                              ));
                              try {
                                await authController.deleteAccount();
                              } catch (e) {
                                if (Get.isOverlaysOpen) {
                                  Get.back();
                                }
                              }
                            },
                            child: Container(
                              width: 150.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: kLightDisplayPrimaryAction,
                              ),
                              child: Center(
                                child: Text(
                                  'common.yes'.tr.capitalizeFirst!,
                                  style: XemoTypography.buttonAllCapsWhite(context),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
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
