import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/errors.dart';
import 'package:flutter_amplifysdk/exception.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_amplifysdk/widgets/loading_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/constants/input_borders.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/theme.dart';
import 'package:mobileapp/utilities/text_phone_number_formatter.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/common/xemo_clear_textFormField_widget.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/providers/country_provider.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/utils/phone_number.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/utils/selector_config.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/widgets/input_widget.dart';
import 'package:mobileapp/widgets/scaffolds/sb_scrollable_scaffold.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../utils/error_alerts_utils.dart';
import '../../widgets/common/common.dart';
import '../../widgets/common/xemo_form_validator.dart';
import 'password_confirm_reset_form_view.dart';

class PasswordResetView extends StatelessWidget {
  static const String id = '/password-reset';

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
          key: authController.resetPasswordFormKey,
          child: Container(
            margin: EdgeInsets.only(
              right: 0.06.sw,
              left: 0.05.sw,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: XemoTransferTheme.heightScalingPercent(40),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // padding: EdgeInsets.only(left: 3.w),
                      alignment: Alignment.center,
                      child: Text(
                        "auth.resetPassword.title".tr,
                        textAlign: TextAlign.center,
                        style: XemoTypography.headLine1Black(context)!.copyWith(fontSize: 27.sp),
                      ),
                    ),
                    Container(
                      height: 20.h,
                    ),
                    Container(
                      //padding: EdgeInsets.only(right: 28.0, left: 2.w),
                      child: Text(
                        "auth.resetPassword.text".tr,
                        textAlign: TextAlign.center,
                        style: XemoTypography.captionDefault(context)!.copyWith(color: const Color(0xFF9B9B9B), fontSize: 16.sp),
                      ),
                    ),
                    Container(
                      height: 20.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 25.h, bottom: 5.h),
                          child: Text(
                            "common.label.phoneNumber".tr.toUpperCase(),
                            style: XemoTypography.bodyAllCapsBlack(context)!.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5.h,
                          ),
                          child: Text("common.note.required".tr,
                              style: !(authController.phoneResetKey.value.currentState != null &&
                                      authController.phoneResetKey.value.currentState!.validate())
                                  ? XemoTypography.captionItalic(context)!.copyWith(
                                      fontWeight: FontWeight.w200,
                                    )
                                  : XemoTypography.captionItalic(context)!.copyWith(
                                      fontWeight: FontWeight.w200,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14,
                                      color: kLightDisplaySecondaryTextColor,
                                    )),
                        ),
                        Container(
                          //   width: 380,
                          padding: const EdgeInsets.only(left: 2),
                          child: InternationalPhoneNumberInput(
                            phoneKey: authController.phonepassResetKey.value,
                            width: 1.sw,
                            autoFocus: true,
                            initialValue: PhoneNumber(isoCode: originController.origin_country_iso.value.toUpperCase()),
                            selectorTextStyle: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction),
                            countries: originController.available_origin_countries.map((e) => e.iso_code!.toUpperCase()).toList().isEmpty
                                ? ['CA']
                                : originController.available_origin_countries.map((e) => e.iso_code!.toUpperCase()).toList(),
                            textFieldController: authController.phoneController.value,
                            selectorConfig: SelectorConfig(useEmoji: true, leadingPadding: 2.w, selectorType: PhoneInputSelectorType.DIALOG),
                            onInputChanged: (value) async {
                              //authController.phoneController.value.text = value.phoneNumber ?? '';
                              originController.origin_country_iso.value = value.isoCode!.toLowerCase();
                              //log(originController.origin_country_iso.value);
                              if (originController.origin_country_iso.value.toUpperCase() == 'US') {
                                originController.origin_calling_code.value = value.dialCode!.toLowerCase();
                                originController.origin_country_name.value = "united states of america";
                              } else if (originController.origin_country_iso.value.toUpperCase() == 'CA') {
                                originController.origin_calling_code.value = value.dialCode!.toLowerCase();
                                originController.origin_country_name.value = CountryProvider().getCountryByDialCode(value.dialCode!).name!;
                              } else {
                                originController.origin_calling_code.value = value.dialCode!.toLowerCase();
                                originController.origin_country_name.value = CountryProvider().getCountryByDialCode(value.dialCode!).name!;
                              }
                              InternationlPhoneValidator().update(originController.origin_country_iso.value.toUpperCase());

                              //log(value.dialCode);
                              authController.phoneResetKey.update((val) {});
                              if (authController.phonepassResetKey.value.currentState!.validate()) {
                                authController.enablePhoneNext.value = true;
                              } else {
                                authController.enablePhoneNext.value = false;
                              }
                              //authController.phoneRegisterKey.update((val) {});
                              originController.origin_country_iso.value = value.isoCode!.toLowerCase();
                              originController.origin_calling_code.value = value.dialCode!.toLowerCase();
                              originController.origin_country_name.value = CountryProvider().getCountryByDialCode(value.dialCode!).name!;
                            },
                            textStyle: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              return (InternationlPhoneValidator().validator(value: value));
                            },
                            inputFormatters: [
                              PhoneNumberInputFormatter(countryIso: originController.origin_country_iso.value.toUpperCase()),
                              //  FilteringTextInputFormatter.digitsOnly,
                            ],
                            spaceBetweenSelectorAndTextField: 0,
                            selectorButtonOnErrorPadding: 0,
                            searchBoxDecoration: InputDecoration(
                              focusedErrorBorder: errorBorderDecoration,
                              errorBorder: borderDecoration,
                              enabledBorder: borderDecoration,
                              border: borderDecoration,
                              disabledBorder: borderDecoration,
                              focusedBorder: primayColorborderDecoration,
                            ),
                            inputDecoration: InputDecoration(
                              suffix: ClearTextFormFieldWidget(
                                controller: authController.phoneController,
                                enabelNext: authController.enablePhoneNext,
                                textFieldKey: authController.phoneResetKey,
                              ),
                              prefixStyle:
                                  Get.textTheme.headline2!.copyWith(color: kLightDisplayPrimaryAction, fontSize: 16, fontWeight: FontWeight.w500),
                              contentPadding: EdgeInsets.only(left: 3.w),
                              fillColor: Colors.transparent,
                              focusedErrorBorder: errorBorderDecoration,
                              errorBorder: borderDecoration,
                              enabledBorder: borderDecoration,
                              border: borderDecoration,
                              disabledBorder: borderDecoration,
                              focusedBorder: primayColorborderDecoration,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    //for testing
                    //
                    if (authController.enablePhoneNext.value) {
                      try {
                        Get.dialog(Center(
                          child: RotatedSpinner(
                            spinnerColor: SpinnerColor.GREEN,
                            height: 45,
                            width: 45,
                          ),
                        ));
                        String phoneNumber = authController.formateAndStandardizePhoneNumber();
                        await authController.requestPasswordReset(
                          username: phoneNumber,
                        );
                        Get.back();
                        Get.toNamed(PasswordConfirmResetFormView.id);
                        //authController.goNextStep(state: authController.passwordResetConfirmState);
                      } on SDKException {
                        if (Get.isOverlaysOpen) {
                          Get.back();
                        }
                        CommonWidgets.buildErrorDialogue(
                            title: 'auth.changeYourPassword.text.error.title'.tr,
                            message: 'auth.changeYourPassword.text.error.content'.tr,
                            code: '',
                            snackPosition: SnackPosition.BOTTOM,
                            context: context);
                      } catch (error, stackTrace) {
                        if (err.runtimeType == UserNotFoundException) {
                          if (Get.isOverlaysOpen) {
                            Get.back();
                          }
                          Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

                          CommonWidgets.buildErrorDialogue(
                              title: 'auth.changeYourPassword.text.error.title'.tr,
                              message: 'auth.changeYourPassword.text.error.content'.tr,
                              code: '',
                              snackPosition: SnackPosition.BOTTOM,
                              context: context);
                        }
                        if (Get.isOverlaysOpen) {
                          Get.back(); // Removes loading dialog

                        }
                        CommonWidgets.buildErrorDialogue(
                            title: 'auth.changeYourPassword.text.title'.tr,
                            message: '',
                            code: '',
                            snackPosition: SnackPosition.BOTTOM,
                            context: context);
                      }
                    }
                  },
                  child: Opacity(
                    opacity: authController.enablePhoneNext.value ? 1 : 0.5,
                    child: Container(
                      height: 50.h,
                      width: 1.sw,
                      margin: EdgeInsets.only(top: 18.h, right: 0.w),
                      decoration: BoxDecoration(
                          color: Get.theme.primaryColorLight,
                          boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          )),
                      child: Center(
                        child: Text(
                          "common.next".tr.toUpperCase(),
                          style: XemoTypography.buttonAllCapsWhite(context),
                        ),
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
      }),
    );
  }
}
