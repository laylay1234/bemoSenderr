import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/constants/input_borders.dart';
import 'package:mobileapp/utilities/text_phone_number_formatter.dart';
import 'package:mobileapp/views/auth/auth_connect_flinks_view.dart';
import 'package:mobileapp/widgets/buttons/next_button_widget.dart';
import 'package:mobileapp/widgets/common/xemo_clear_textFormField_widget.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/widgets/common/xemo_text_form_field_widget.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/providers/country_provider.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/utils/phone_number.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/widgets/input_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/origin_controller.dart';
import '../intl_phone_number_input-0.7.0+2/src/utils/selector_config.dart';

class RegisterPhoneFormWidget extends StatelessWidget {
  const RegisterPhoneFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    OriginController originController = Get.find<OriginController>();
    //   authController.clearPhoneField();
    return Obx(() {
      return Form(
        key: authController.formKeys[0],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 25.h, left: 0.005.sw),
              child: Text(
                "common.label.phoneNumber".tr.toUpperCase(),
                style: XemoTypography.bodyAllCapsBlack(context)!.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h, left: 0.005.sw),
              child: Text("common.note.required".tr,
                  style:
                      !(authController.phoneRegisterKey.value.currentState != null && authController.phoneRegisterKey.value.currentState!.validate())
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
              height: 77,
              padding: EdgeInsets.only(left: 0.013.sw, right: 0.01.sw),
              child: InternationalPhoneNumberInput(
                phoneKey: authController.phoneRegisterKey.value,
                width: 0.99.sw,
                autoFocus: true,
                initialValue: PhoneNumber(isoCode: originController.origin_country_iso.value.toUpperCase()),
                //autoValidateMode: AutovalidateMode.onUserInteraction,
                countries: originController.available_origin_countries.map((e) => e.iso_code!.toUpperCase()).toList().isEmpty
                    ? ['CA']
                    : originController.available_origin_countries.map((e) => e.iso_code!.toUpperCase()).toList(),
                inputFormatters: [
                  PhoneNumberInputFormatter(countryIso: originController.origin_country_iso.value.toUpperCase()),
                  //  FilteringTextInputFormatter.digitsOnly,
                ],
                selectorTextStyle: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction),
                textFieldController: authController.phoneController.value,
                selectorConfig: SelectorConfig(
                  useEmoji: true,
                  leadingPadding: 1.w,
                  selectorType: PhoneInputSelectorType.DIALOG,
                ),
                validator: (value) {
                  return (InternationlPhoneValidator().validator(value: value));
                },
                onFieldSubmitted: (val) {
//
                },

                onInputChanged: (value) async {
                  if ((originController.origin_country_iso.value != value.isoCode!.toLowerCase()) &&
                      originController.origin_country_iso.value.isNotEmpty) {
                    authController.getFlinksUrl(origine_iso_code: originController.origin_country_iso.value);
                  }
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
                  InternationlZipCodesValidator().update(originController.origin_country_iso.value.toUpperCase());
                  //log(value.dialCode);
                  authController.phoneRegisterKey.update((val) {});
                  if (authController.phoneRegisterKey.value.currentState!.validate()) {
                    authController.enablePhoneNext.value = true;
                  } else {
                    authController.enablePhoneNext.value = false;
                  }
                  authController.phoneRegisterKey.update((val) {});
                  //log(authController.phoneController.value.text);
                  log(authController.formateAndStandardizePhoneNumber());
                  if (authController.formKeys[0].currentState!.validate()) {
                    authController.enablePhoneNext.value = true;
                  }
                  log(originController.origin_country_iso.value + "::::");
                },
                textStyle: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction),
                keyboardType: TextInputType.phone,
                //validator: phoneValidator,
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
                    textFieldKey: authController.phoneRegisterKey,
                  ),
                  prefixStyle: Get.textTheme.headline2!.copyWith(color: kLightDisplayPrimaryAction, fontSize: 16, fontWeight: FontWeight.w500),
                  contentPadding: EdgeInsets.only(left: 10.w),
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
            XemoTextFormWithTitleAndNote(
              width: 1.sw,
              enableRightMargin: false,
              controller: authController.passwordRxController,
              formKey: authController.formKeys[0],
              textFieldKey: authController.passwordKey,
              enableNext: authController.enablePhoneNext,
              title: "common.password.title".tr,
              note: "common.note.required".tr,
              validator: XemoFormValidatorWidget().passwordValidator,
              obscure: true,
              showOrHide: authController.showPassword,
            ),
            //CONFIRM PASSWORD
            XemoTextFormWithTitleAndNote(
              width: 1.sw,
              enableRightMargin: false,
              controller: authController.confirmPasswordController,
              formKey: authController.formKeys[0],
              textFieldKey: authController.confirmPasswordKey,
              enableNext: authController.enablePhoneNext,
              title: "auth.signup.password.cofirm".tr,
              note: "common.note.required".tr,
              validator: XemoFormValidatorWidget().confirmPasswordValidator,
              isConfirmPasswordField: true,
              obscure: true,
              showOrHide: authController.showPassword,
            ),
            Container(
              padding: EdgeInsets.only(
                top: 1.h,
                left: 0.01.sw,
              ),
              child: NextButtonWidget(
                signUp: true,
                width: 1.sw,
                nextScreenId: AuthConnectWithFlinksView.id,
                enabled: authController.formKeys[0].currentState == null
                    ? (authController.enablePhoneNext.value && !authController.isAppNeedUpdate.value)
                    : (authController.formKeys[0].currentState!.validate() && !authController.isAppNeedUpdate.value),
              ),
            )
          ],
        ),
      );
    });
  }
}
