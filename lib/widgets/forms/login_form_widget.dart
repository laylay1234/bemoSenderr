import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amplifysdk/errors.dart';
import 'package:flutter_amplifysdk/exception.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/constants/input_borders.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/utilities/text_phone_number_formatter.dart';
import 'package:mobileapp/widgets/common/common.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/common/xemo_clear_textFormField_widget.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/utils/phone_number.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/utils/selector_config.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/widgets/input_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../theme.dart';
import '../../utils/error_alerts_utils.dart';
import '../common/xemo_text_form_field_widget.dart';
import '../intl_phone_number_input-0.7.0+2/src/providers/country_provider.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    OriginController originController = Get.find<OriginController>();
    // log(originController.available_origin_countries.map((e) => e.iso_code!.toUpperCase()).toList().length.toString());
    return Obx(() {
      return Form(
        key: authController.loginFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      //padding: EdgeInsets.only(left: 3.w),
                      margin: EdgeInsets.only(top: 25.h, bottom: 5.h),
                      child: Text(
                        "common.label.phoneNumber".tr.toUpperCase(),
                        style: XemoTypography.bodyAllCapsBlack(context)!.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(right: 8.w),
                      height: 75.h,
                      padding: const EdgeInsets.only(left: 2),
                      // margin: EdgeInsets.only(left: 1.w),
                      child: InternationalPhoneNumberInput(
                        key: const Key('login_phone_key'),
                        phoneKey: authController.phoneKey.value,

                        width: 1.sw,
                        autoFocus: true,
                        initialValue: PhoneNumber(isoCode: originController.origin_country_iso.value.toUpperCase()),
                        //  countries: ['CA', 'DZ'],
                        countries: originController.available_origin_countries.map((e) => e.iso_code!.toUpperCase()).toList().isEmpty
                            ? ['CA']
                            : originController.available_origin_countries.map((e) => e.iso_code!.toUpperCase()).toList(),
                        selectorTextStyle: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction),
                        textFieldController: authController.phoneController.value,
                        inputFormatters: [
                          PhoneNumberInputFormatter(countryIso: originController.origin_country_iso.value.toUpperCase()),
                          //  FilteringTextInputFormatter.digitsOnly,
                        ],
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        selectorConfig: SelectorConfig(useEmoji: true, leadingPadding: 2.w, selectorType: PhoneInputSelectorType.DIALOG),
                        onInputChanged: (value) async {
                          //authController.phoneController.value.text = value.phoneNumber ?? '';
                          if ((originController.origin_country_iso.value != value.isoCode!.toLowerCase()) &&
                              originController.origin_country_iso.value.isNotEmpty) {
                            authController.getFlinksUrl(origine_iso_code: originController.origin_country_iso.value);
                          }
                          originController.origin_country_iso.value = value.isoCode!.toLowerCase();

                          //log(originController.origin_country_iso.value);
                          if (originController.origin_country_iso.value.toUpperCase() == 'US') {
                            originController.origin_calling_code.value = value.dialCode!.toLowerCase();
                            originController.origin_country_name.value = "united states of america";
                          } else {
                            originController.origin_calling_code.value = value.dialCode!.toLowerCase();
                            originController.origin_country_name.value = CountryProvider().getCountryByDialCode(value.dialCode!).name!;
                          }
                          InternationlPhoneValidator().update(originController.origin_country_iso.value.toUpperCase());

                          //log(value.isoCode);
                          //log('=>' + authController.phoneController.value.text);
                          if (authController.loginFormKey.currentState != null) {
                            if (authController.loginFormKey.currentState!.validate()) {
                              authController.enableLogin.value = true;
                            } else {
                              authController.enableLogin.value = false;
                            }
                          } else {
                            authController.enableLogin.value = false;
                          }
                        },
                        textStyle: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          return InternationlPhoneValidator().validator(
                            value: value,
                          );
                        },
                        spaceBetweenSelectorAndTextField: 0,

                        selectorButtonOnErrorPadding: 0,
                        searchBoxDecoration: InputDecoration(
                          prefix: const Icon(
                            Icons.search,
                            color: kDarkDisplayPrimaryAction,
                          ),
                          focusedErrorBorder: errorBorderDecoration,
                          errorBorder: borderDecoration,
                          enabledBorder: borderDecoration,
                          border: borderDecoration,
                          disabledBorder: borderDecoration,
                          focusedBorder: primayColorborderDecoration,
                        ),
                        inputDecoration: InputDecoration(
                          isDense: true,
                          suffix: ClearTextFormFieldWidget(
                            controller: authController.phoneController,
                            enabelNext: authController.enableLogin,
                            textFieldKey: authController.phoneKey,
                          ),
                          prefixStyle: Get.textTheme.headline2!.copyWith(color: Get.theme.primaryColorLight, fontSize: 16, fontWeight: FontWeight.w500),
                          contentPadding: const EdgeInsets.only(left: 0),
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
                ),
                // PhoneTextFieldWidget(
                //   fromLogin: true,
                // ),
                //DON'T use validator.passwordValidator there's a bug that will appears when we change the language
                //the error texts of validator will be use a false language , something related to phone input which make
                //not getting updated
                XemoTextFormWithTitleAndNote(
                  key: const Key('pass_word_key'),
                  width: 1.sw,
                  enableNote: false,
                  enableRightMargin: false,
                  controller: authController.passwordRxController,
                  formKey: authController.loginFormKey,
                  textFieldKey: authController.passwordKey,
                  enableNext: authController.enableLogin,
                  title: "common.password.title".tr,
                  note: "common.note.required".tr,
                  validator: XemoFormValidatorWidget().passwordValidator,
                  obscure: true,
                  isConfirmPasswordField: true,
                  showOrHide: authController.showPassword,
                ),
              ],
            ),
            //MBAuthFormInput(),
            Container(
              height: 55.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 0.02.sw),
                  child: InkWell(
                    onTap: () {
                      authController.goNextStep(state: authController.passwordResetState);
                    },
                    child: Text(
                      'auth.login.forgotPassword.text'.tr,
                      style: Get.textTheme.button!
                          .copyWith(decoration: TextDecoration.underline, color: kLightDisplaySecondaryTextColor, fontWeight: FontWeight.w700, fontSize: 16.sp),
                    ),
                  ),
                ),
                SizedBox(
                  height: XemoTransferTheme.heightScalingPercent(17),
                ),
                Container(
                  padding: EdgeInsets.only(left: 0.005.sw),
                  child: GestureDetector(
                    key: const Key('login_button_key'),
                    onTap: () async {
                      if (authController.enableLogin.value) {
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
                          await authController.login(
                            username: authController.formateAndStandardizePhoneNumber(),
                            password: authController.passwordRxController.value.text,
                          );
                        } on AuthUserNotConfirmed {
                          if (Get.isOverlaysOpen) {
                            Get.back(); // Removes loading dialog
                          }
                          authController.goNextStep(state: authController.confirmationNeededState);
                        } on SDKException catch (err) {
                          if (Get.isOverlaysOpen) {
                            Get.back(); // Removes loading dialog
                          }
                          CommonWidgets.buildErrorDialogue(
                              title: 'common.signIn'.tr, message: err.message, code: err.errorCode, snackPosition: SnackPosition.BOTTOM, context: context);
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
                              title: 'auth.register.error.title'.tr, code: '', message: _errMsg, snackPosition: SnackPosition.BOTTOM, context: context);
                        }
                      }
                    },
                    child: Opacity(
                      opacity: (authController.enableLogin.value && !authController.isAppNeedUpdate.value) ? 1 : 0.5,
                      child: Container(
                        height: 50.h,
                        width: 1.sw,
                        margin: EdgeInsets.only(top: 18.h),
                        decoration: const BoxDecoration(
                            color: kLightDisplayPrimaryAction,
                            boxShadow: [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                            borderRadius: BorderRadius.all(
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
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
