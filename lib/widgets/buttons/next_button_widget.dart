import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/errors.dart';
import 'package:flutter_amplifysdk/exception.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/views/auth/auth_connect_flinks_view.dart';
import 'package:mobileapp/views/auth/auth_register_address_view.dart';
import 'package:mobileapp/views/auth/auth_register_phone_view.dart';
import 'package:mobileapp/widgets/common/common.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../constants/colors.dart';

// ignore: must_be_immutable
class NextButtonWidget extends StatelessWidget {
  bool? enabled;
  bool? signUp = false;
  String? nextScreenId;
  Void? function;
  double width = 330;
  NextButtonWidget({Key? key, this.enabled = true, this.nextScreenId, this.signUp = false, this.width = 330, this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();

    return Opacity(
      opacity: enabled! ? 1 : 0.5,
      child: GestureDetector(
        onTap: () async {
          //isPhoneNumberUnique
          if (signUp!) {
            if (authController.enablePhoneNext.value) {
              Get.dialog(
                  Center(
                    child: RotatedSpinner(
                      spinnerColor: SpinnerColor.GREEN,
                      height: 35,
                      width: 35,
                    ),
                  ),
                  barrierDismissible: false);
              try {
                await authController.signup();
                if (Get.isOverlaysOpen) {
                  Get.back();
                }
                //log('fromm address ' + authController.formateAndStandardizePhoneNumber());
              } on SDKException catch (err) {
                if (Get.isOverlaysOpen) {
                  Get.back(); // Removes loading dialog
                }
                CommonWidgets.buildErrorDialogue(
                  title: 'auth.register.error.title'.tr,
                  message: err.message,
                  code: err.errorCode,
                  context: context,
                  snackPosition: SnackPosition.BOTTOM,
                );
              } catch (err) {
                if (Get.isOverlaysOpen) {
                  Get.back(); // Removes loading dialog
                }
                // Theme as error
                String _errMsg = ErrorHandler.getErrMsg(
                  error: err,
                );
                CommonWidgets.buildErrorDialogue(
                  title: 'auth.register.error.title'.tr,
                  message: _errMsg,
                  code: '',
                  context: context,
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            }
            return;
          }
          if (nextScreenId == AuthRegisterPhoneView.id) {
            //authController.clearAll();
          }
          if (enabled!) {
            if (nextScreenId == AuthConnectWithFlinksView.id) {
              try {
                Get.dialog(
                    Center(
                      child: RotatedSpinner(
                        spinnerColor: SpinnerColor.GREEN,
                        height: 35,
                        width: 35,
                      ),
                    ),
                    barrierDismissible: false);
                bool result = await authController.isPhoneNumberUnique();
                if (Get.isOverlaysOpen) {
                  Get.back();
                }
                if (result) {
                  Get.toNamed(nextScreenId!, arguments: {'fromRegister': true});
                } else {
                  //display textError
                  CommonWidgets.buildErrorDialogue(
                    title: 'auth.register.error.title'.tr,
                    message: "auth.error.phoneIsUsed".tr,
                    code: "6000",
                    context: context,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              } catch (e) {
                if (Get.isOverlaysOpen) {
                  Get.back();
                }
                log(e.toString());
              }
            } else if (nextScreenId == AuthRegisterAddressView.id) {
              //
              try {
                Get.dialog(
                    Center(
                      child: RotatedSpinner(
                        spinnerColor: SpinnerColor.GREEN,
                        height: 35,
                        width: 35,
                      ),
                    ),
                    barrierDismissible: false);
                bool result = await authController.isEmailUnique();
                if (Get.isOverlaysOpen) {
                  Get.back();
                }
                if (result) {
                  Get.toNamed(nextScreenId!, arguments: {'fromRegister': true});
                } else {
                  //display textError
                  CommonWidgets.buildErrorDialogue(
                    title: 'auth.register.error.title'.tr,
                    message: "auth.error.emailIsUsed".tr,
                    code: "6001",
                    context: context,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              } catch (e) {
                if (Get.isOverlaysOpen) {
                  Get.back();
                }
                log(e.toString());
              }
              //
            } else {
              if (enabled!) {
                Get.toNamed(nextScreenId!, arguments: {'fromRegister': true});
                if (function != null) {
                  function;
                }
              }
            }
          }
        },
        child: Container(
          height: 50.h,
          width: width == 330 ? width.w : width,
          margin: EdgeInsets.only(top: 18.h),
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
              color: kLightDisplayPrimaryAction,
              boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(1, 1))],
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              )),
          child: Center(
            child: Text("common.next".tr.toUpperCase(), style: XemoTypography.buttonAllCapsWhite(context)),
          ),
        ),
      ),
    );
  }
}
