import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/errors.dart';
import 'package:flutter_amplifysdk/exception.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/constants/input_borders.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/theme.dart';
import 'package:mobileapp/utilities/text_phone_number_formatter.dart';
import 'package:mobileapp/widgets/common/common.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/widgets/scaffolds/sb_scrollable_scaffold.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../utils/error_alerts_utils.dart';

class RegisterConfirmView extends StatelessWidget {
  static const String id = '/register-confirm';

  const RegisterConfirmView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    AuthController authController = Get.find<AuthController>();
    return MBScrollableScaffold(
      appBar: XemoAppBar(leading: true),
      bottomSheet: null,
      body: Obx(() {
        return Form(
          key: authController.formKeys[4],
          child: Container(
            margin: EdgeInsets.only(right: 0.06.sw, left: 0.05.sw, top: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "auth.register.title".tr,
                  style: XemoTypography.headLine1Black(context),
                ),
                SizedBox(height: 150.h),
                Container(
                  padding: EdgeInsets.only(right: 18.w),
                  alignment: Alignment.center,
                  child: Text(
                    'auth.register.confirm.code.sent.to.you'.tr +
                        " " +
                        FormatPlainTextPhoneNumberByNumber().format(authController.formateAndStandardizePhoneNumber()),
                    style: XemoTypography.titleH6BoldBlack(context)!.copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 175.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      //   padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 0.w),
                            child: Text(
                              "auth.confirm.code".tr.toUpperCase(),
                              style: XemoTypography.bodyAllCapsBlack(context),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.only(left: 2),
                              height: 75.h,
                              width: 1.sw,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: authController.confirmCodeController,
                                validator: XemoFormValidatorWidget().codeValidator,
                                onChanged: (val) {
                                  if (authController.formKeys[4].currentState!.validate()) {
                                    authController.enableCodeContinue.value = true;
                                  } else {
                                    authController.enableCodeContinue.value = false;
                                  }
                                },
                                decoration: const InputDecoration(
                                  //instead of icon country for which the app is targeting
                                  contentPadding: EdgeInsets.only(left: 23.0, top: 8.0),
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  focusedErrorBorder: errorBorderDecoration,
                                  errorBorder: borderDecoration,
                                  enabledBorder: borderDecoration,
                                  border: borderDecoration,
                                  disabledBorder: borderDecoration,
                                  focusedBorder: borderDecoration,
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: XemoTransferTheme.heightScalingPercent(20),
                    ),
                    Container(
                      //  padding: const EdgeInsets.all(8.0),
                      child: Opacity(
                        opacity: authController.enableCodeContinue.value ? 1 : 0.5,
                        child: GestureDetector(
                          onTap: () async {
                            if (authController.enableCodeContinue.value) {
                              try {
                                Get.dialog(
                                    Center(
                                      child: RotatedSpinner(
                                        spinnerColor: SpinnerColor.GREEN,
                                        height: 45,
                                        width: 45,
                                      ),
                                    ),
                                    barrierDismissible: false);
                                //
                                //
                                await authController.confirmSignUp();
                              } on SDKException catch (err) {
                                if (Get.isOverlaysOpen) {
                                  Get.back(); // Removes loading dialog
                                }
                                CommonWidgets.buildErrorDialogue(
                                  context: context,
                                  title: 'auth.resetPasswordConfirm.code'.tr,
                                  message: err.message,
                                  code: err.errorCode,
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
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                            }
                          },
                          child: Container(
                            height: 50.h,
                            width: 1.sw,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: kLightDisplayPrimaryAction,
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 3))]),
                            child: Center(
                              child: Text(
                                'common.continue'.tr,
                                style: XemoTypography.buttonWhiteDefault(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      //   padding: const EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(top: 15.h),
                      child: GestureDetector(
                        onTap: () async {
                          try {
                            Get.dialog(
                                Center(
                                  child: CircularProgressIndicator(
                                    color: Get.theme.primaryColorLight,
                                  ),
                                ),
                                barrierDismissible: false);
                            // String phone_number = target_country_code + authController.phoneController.value.text;
                           // log(authController.formateAndStandardizePhoneNumber());
                            await authController.sendConfirmationCode(username: authController.formateAndStandardizePhoneNumber());
                            if (Get.isOverlaysOpen) {
                              Get.back();
                            } // Removes loading dialog
                          } on SDKException catch (error, stackTrace) {
                            Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

                            if (Get.isOverlaysOpen) {
                              Get.back(); // Removes loading dialog
                            }
                            CommonWidgets.buildErrorDialogue(
                              title: 'auth.resetPasswordConfirm.code'.tr,
                              message: error.message,
                              code: error.errorCode,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          } catch (error, stackTrace) {
                            Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

                            // log(err.toString());

                            if (Get.isOverlaysOpen) {
                              Get.back(); // Removes loading dialog
                            }
                            // Theme as error
                            String _errMsg = ErrorHandler.getErrMsg(
                              error: error,
                            );
                            CommonWidgets.buildErrorDialogue(
                              title: 'auth.register.error.title'.tr,
                              message: _errMsg,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                        child: Container(
                          height: 50.h,
                          width: 1.sw,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(const Radius.circular(20)),
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 3))]),
                          child: Center(
                            child: Text(
                              "auth.register.confirm.resendCode".tr,
                              style: XemoTypography.buttonWhiteDefault(context)!.copyWith(color: kLightDisplayOnSecondaryAction),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _codeField({required AuthController controller}) {
    return TextField(
      autofocus: true,
      controller: controller.confirmCodeController,
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: 'auth.register.code'.tr,
      ),
    );
  }
}
