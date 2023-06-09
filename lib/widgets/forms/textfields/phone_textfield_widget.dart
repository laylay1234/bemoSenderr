import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/constants/input_borders.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/utilities/text_phone_number_formatter.dart';
import 'package:mobileapp/widgets/common/xemo_clear_textFormField_widget.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/utils/phone_number.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/utils/selector_config.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/widgets/input_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

// ignore: must_be_immutable
class PhoneTextFieldWidget extends StatelessWidget {
  bool fromLogin = false;
  bool enabled = true;
  PhoneTextFieldWidget({Key? key, this.fromLogin = false, this.enabled = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    OriginController originController = Get.find<OriginController>();

    FormState? form = Form.of(context);
    //log(authController.phoneController.value.text);

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 25.h),
            child: Text(
              "common.label.phoneNumber".tr.toUpperCase(),
              style: XemoTypography.bodyAllCapsBlack(context)!.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.h),
            child: Text("common.note.required".tr,
                style: (authController.phoneKey.value.currentState != null && authController.phoneKey.value.currentState!.validate())
                    ? XemoTypography.captionItalic(context)!.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      )
                    : XemoTypography.captionItalic(context)!.copyWith(
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        color: kLightDisplaySecondaryTextColor,
                      )),
          ),
          Container(
            // margin: EdgeInsets.only(right: 8.w),
            height: 75.h,
            padding: const EdgeInsets.only(left: 2),
            // margin: EdgeInsets.only(left: 1.w),
            child: InternationalPhoneNumberInput(
              phoneKey: enabled ? authController.phoneKey.value : null,
              width: 1.sw,
              //    autoFocus: true,
              isEnabled: false,
              initialValue: PhoneNumber(isoCode: originController.origin_country_iso.value.toUpperCase()),
              countries: [originController.origin_country_iso.value.toUpperCase()],
              //  countries: originController.available_origin_countries.value.map((e) => e.iso_code!.toUpperCase()).toList(),
              selectorTextStyle: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction),
              textFieldController: authController.phoneController.value,
              selectorConfig: SelectorConfig(useEmoji: true, leadingPadding: 2.w, selectorType: PhoneInputSelectorType.DIALOG),
              onInputChanged: (value) async {
                if (form!.validate()) {
                  authController.enablePhoneNext.value = true;
                } else {
                  authController.enablePhoneNext.value = false;
                }

                authController.phoneKey.update((val) {});
                InternationlPhoneValidator().update(originController.origin_country_iso.value.toUpperCase());
              },
              inputFormatters: [
                PhoneNumberInputFormatter(countryIso: originController.origin_country_iso.value.toUpperCase()),
                //  FilteringTextInputFormatter.digitsOnly,
              ],
              textStyle: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction),
              keyboardType: TextInputType.phone,
              validator: XemoFormValidatorWidget().phoneValidator,
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
                  enabelNext: authController.enablePhoneNext,
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
      );
    });
  }
}
