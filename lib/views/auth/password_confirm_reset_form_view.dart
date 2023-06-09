import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/errors.dart';
import 'package:flutter_amplifysdk/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/theme.dart';
import 'package:mobileapp/views/auth/auth.dart';
import 'package:mobileapp/widgets/common/common.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/widgets/common/xemo_text_form_field_widget.dart';
import 'package:mobileapp/widgets/scaffolds/sb_scrollable_scaffold.dart';
import 'package:mobileapp/widgets/snackbars/password_updated_snackbar.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../utils/error_alerts_utils.dart';

class PasswordConfirmResetFormView extends StatelessWidget {
  static const String id = '/password-confirm-reset';

  const PasswordConfirmResetFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    OriginController originController = Get.find<OriginController>();
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);
    return MBScrollableScaffold(
        appBar: XemoAppBar(leading: true),
        bottomSheet: null,
        body: Obx(() {
          return Form(
            key: authController.confirmResetFormKey,
            child: Container(
              margin: EdgeInsets.only(right: 0.06.sw, left: 0.05.sw),
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text(
                          'auth.resetPasswordConfirm.title'.tr,
                          style: XemoTypography.headLine1Black(context)!.copyWith(fontSize: 26.sp),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          'auth.resetPasswordConfirm.text'.tr,
                          style: XemoTypography.captionDefault(context)!.copyWith(color: const Color(0xFF9B9B9B), fontSize: 16.sp),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 10.h,
                  ),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    XemoTextFormWithTitleAndNote(
                      width: 1.sw,
                      enableNote: false,
                      enableRightMargin: false,
                      controller: authController.confirmPassResetCodeController,
                      formKey: authController.confirmResetFormKey, //changePasswordFormKey
                      textFieldKey: authController.confirmPassResetCodeKey,
                      enableNext: authController.enableConfirmResetButton,
                      title: "auth.confirm.code".tr,
                      note: "auth.signup.required".tr,
                      validator: XemoFormValidatorWidget().requiredCode,
                      //obscure: true,
                      // isConfirmPasswordField: false,
                      //  showOrHide: authController.showPassword,
                    ),
                    Container(
                      height: 10.h,
                    ),
                    XemoTextFormWithTitleAndNote(
                      width: 1.sw,
                      enableNote: false,
                      enableRightMargin: false,

                      controller: authController.newPasswordController,
                      formKey: authController.confirmResetFormKey, //changePasswordFormKey
                      textFieldKey: authController.newPasswordControllerKey,
                      enableNext: authController.enableConfirmResetButton,
                      title: "change.password.new.password".tr,
                      note: "auth.signup.required".tr,
                      validator: XemoFormValidatorWidget().confirmNewPasswordValidator,
                      obscure: true,
                      //    isConfirmPasswordField: false,
                      showOrHide: authController.showPassword,
                    ),
                    Container(
                      height: 10.h,
                    ),
                    XemoTextFormWithTitleAndNote(
                      width: 1.sw,
                      enableNote: false,
                      enableRightMargin: false,

                      controller: authController.confirmPasswordController,
                      formKey: authController.confirmResetFormKey, //changePasswordFormKey
                      textFieldKey: authController.confirmPasswordKey,
                      enableNext: authController.enableConfirmResetButton,
                      title: "change.password.confirm.new.password".tr,
                      note: "auth.signup.required".tr,
                      validator: XemoFormValidatorWidget().confirmNewPasswordValidator,
                      obscure: true,
                      isConfirmPasswordField: true,
                      showOrHide: authController.showPassword,
                    ),
                  ]),
                  GestureDetector(
                    onTap: () async {
                      //for testing
                      if (authController.enableConfirmResetButton.value) {
                        Get.dialog(
                            Center(
                              child: RotatedSpinner(
                                spinnerColor: SpinnerColor.GREEN,
                                height: 45,
                                width: 45,
                              ),
                            ),
                            barrierDismissible: false);
                        try {
                          await authController.resetPassword();
                          Get.offAllNamed(LoginView.id);
                          onPasswordUpdatedSuccefully();
                        } on NotAuthorizedException {
                          if (Get.isOverlaysOpen) {
                            Get.back();
                          }
                          CommonWidgets.buildErrorDialogue(
                              title: 'auth.changeYourPassword.text.error.title'.tr,
                              message: 'auth.changeYourPassword.text.error.content'.tr,
                              code: '',
                              snackPosition: SnackPosition.BOTTOM,
                              context: context);
                        } on SDKException catch (err) {
                          if (Get.isOverlaysOpen) {
                            Get.back(); // Removes loading dialog
                          }
                          CommonWidgets.buildErrorDialogue(
                            title: 'auth.resetPassword.title'.tr,
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
                    child: Opacity(
                      opacity: authController.enableConfirmResetButton.value ? 1 : 0.5,
                      child: Container(
                        height: 50.h,
                        width: 1.sw,
                        margin: EdgeInsets.only(top: 120.h),
                        decoration: BoxDecoration(
                            color: Get.theme.primaryColorLight,
                            boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            )),
                        child: Center(
                          child: Text(
                            "common.confirm".tr.toUpperCase(),
                            style: XemoTypography.buttonAllCapsWhite(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        Get.dialog(
                            Center(
                              child: CircularProgressIndicator(
                                color: Get.theme.primaryColorLight,
                              ),
                            ),
                            barrierDismissible: false);
                        await authController.sendConfirmationCode(username: authController.formateAndStandardizePhoneNumber());
                        Get.back(); // Removes loading dialog
                        //TODO display a snackbar indicate the success of the operatioj

                      } on SDKException catch (error, stackTrace) {
                        if (Get.isOverlaysOpen) {
                          Get.back(); // Removes loading dialog
                        }
                        Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

                        CommonWidgets.buildErrorDialogue(
                            title: 'auth.login.title'.tr,
                            message: error.message,
                            code: error.errorCode,
                            snackPosition: SnackPosition.BOTTOM,
                            context: context);
                      } catch (error, stackTrace) {
                        Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

                        if (Get.isOverlaysOpen) {
                          Get.back(); // Removes loading dialog
                        }
                        // Theme as error
                        String _errMsg = ErrorHandler.getErrMsg(
                          error: err,
                        );
                        CommonWidgets.buildErrorDialogue(
                            title: 'auth.register.error.title'.tr, code: '', message: _errMsg, snackPosition: SnackPosition.BOTTOM, context: context);
                      }
                    },
                    child: Container(
                      height: 50.h,
                      width: 0.9.sw,
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
                  SizedBox(
                    height: XemoTransferTheme.heightScalingPercent(40),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
