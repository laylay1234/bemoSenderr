import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/errors.dart';
import 'package:flutter_amplifysdk/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/widgets/common/common.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/widgets/common/xemo_text_form_field_widget.dart';
import 'package:mobileapp/widgets/scaffolds/sb_scrollable_scaffold.dart';
import 'package:mobileapp/widgets/snackbars/successfully_updated_data_snackbar.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../../utils/error_alerts_utils.dart';

class ChangePasswordView extends StatelessWidget {
  static const String id = '/edit-profile-change-password-view';

  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    authController.resetChangePasswordData();
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    return WillPopScope(
      onWillPop: () {
        authController.resetLoginData();
        return Future.value(true);
      },
      child: MBScrollableScaffold(
        bottomSheet: null,
        appBar: XemoAppBar(leading: true),
        body: Obx(() {
          return Form(
            key: authController.changePasswordKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Container(
              margin: EdgeInsets.only(right: 0.06.sw, left: 0.05.sw, top: 55.h),
              child: Column(
                children: [
                  Container(
                    // padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'auth.changeYourPassword.text.title'.tr.capitalize!,
                      style: XemoTypography.headLine1Black(context)!.copyWith(fontSize: 25.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      'auth.EnterOld&NewPassword.text'.tr,
                      style: XemoTypography.captionDefault(context)!.copyWith(color: const Color(0xFF9B9B9B), fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    height: 30.h,
                  ),
                  //old password
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      XemoTextFormWithTitleAndNote(
                        width: 1.sw,
                        enableRightMargin: false,
                        enableNote: false,
                        controller: authController.passwordRxController,
                        formKey: authController.changePasswordKey, //changePasswordFormKey
                        textFieldKey: authController.passwordKey,
                        enableNext: authController.enableChangePassword,
                        title: "change.password.old.password".tr,
                        note: "auth.signup.required".tr,
                        validator: XemoFormValidatorWidget().passwordValidator,
                        obscure: true,
                        isConfirmPasswordField: false,
                        showOrHide: authController.showPassword,
                      ),
                      XemoTextFormWithTitleAndNote(
                        width: 1.sw,
                        enableRightMargin: false,
                        enableNote: false,
                        controller: authController.newPasswordController,
                        formKey: authController.changePasswordKey, //changePasswordFormKey
                        textFieldKey: authController.newPasswordControllerKey,
                        enableNext: authController.enableChangePassword,
                        title: "change.password.new.password".tr,
                        note: "auth.signup.required".tr,
                        validator: XemoFormValidatorWidget().passwordValidator,
                        obscure: true,
                        isConfirmPasswordField: false,
                        //   showOrHide: authController.showPassword,
                      ),
                      XemoTextFormWithTitleAndNote(
                        width: 1.sw,
                        enableRightMargin: false,
                        enableNote: false,
                        controller: authController.confirmPasswordController,
                        formKey: authController.changePasswordKey, //changePasswordFormKey
                        textFieldKey: authController.confirmPasswordKey,
                        enableNext: authController.enableChangePassword,
                        title: "change.password.confirm.new.password".tr,
                        note: "auth.signup.required".tr,
                        validator: XemoFormValidatorWidget().confirmNewPasswordValidator,
                        obscure: true,
                        isConfirmPasswordField: false,
                        showOrHide: authController.showPassword,
                      ),
                    ],
                  ),

                  //confirm new pass

                  Opacity(
                    opacity: authController.enableChangePassword.value ? 1 : 0.5,
                    child: GestureDetector(
                      onTap: () async {
                        if (authController.enableChangePassword.value) {
                          try {
                            Get.dialog(Center(
                              child: RotatedSpinner(
                                spinnerColor: SpinnerColor.GREEN,
                                height: 45,
                                width: 45,
                              ),
                            ));
                            await authController.updatePassword();
                            Get.back();
                            Get.back();
                            startSuccessfullyUpdatedDataSnackbar();
                          } on UserNotFoundException {
                            if (Get.isOverlaysOpen) {
                              Get.back();
                            }
                            CommonWidgets.buildErrorDialogue(
                                title: 'auth.changeYourPassword.text.error.title'.tr,
                                message: 'auth.changeYourPassword.text.error.content'.tr,
                                code: '',
                                snackPosition: SnackPosition.BOTTOM,
                                context: context);
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
                          } on SDKException catch (error, stackTrace) {
                            Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

                            if (Get.isOverlaysOpen) {
                              Get.back(); // Removes loading dialog
                            }
                            CommonWidgets.buildErrorDialogue(
                                title: 'auth.changeYourPassword.text.title'.tr,
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
                              error: error,
                            );
                            CommonWidgets.buildErrorDialogue(
                                title: 'auth.changeYourPassword.text.title'.tr,
                                message: _errMsg,
                                snackPosition: SnackPosition.BOTTOM,
                                context: context);
                          }
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 50.h, bottom: 10.h),
                        width: 1.sw,
                        height: 50.h,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            color: kLightDisplayPrimaryAction,
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 3))]),
                        child: Center(
                          child: Text(
                            'common.confirm'.tr.toUpperCase(),
                            style: XemoTypography.buttonAllCapsWhite(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
