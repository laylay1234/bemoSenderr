import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/utilities/zip_code_formatter.dart';
import 'package:mobileapp/utils/app_utils.dart';
import 'package:mobileapp/widgets/buttons/create_account_button_widget.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/widgets/common/xemo_text_form_field_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';
import 'package:url_launcher/url_launcher.dart';

class AddressFormWidget extends StatelessWidget {
  const AddressFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    ProfileController profileController = Get.find<ProfileController>();
    OriginController originController = Get.find<OriginController>();
    InternationlZipCodesValidator().update(originController.origin_country_iso.value.toUpperCase());
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Obx(() {
        return Form(
          key: authController.formKeys[5],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              XemoTextFormWithTitleAndNote(
                width: 1.sw,
                controller: authController.fullAddressController,
                formKey: authController.formKeys[5],
                textFieldKey: authController.fullAddressKey,
                enableNext: authController.enableCreateAccount,
                title: "common.forms.fullAddress.title".tr,
                note: "common.note.required".tr,
                validator: XemoFormValidatorWidget().requiredFullAddress,
              ),
              //
              Container(
                margin: EdgeInsets.only(top: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: XemoTextFormWithTitleAndNote(
                        controller: authController.zipCodeController,
                        formKey: authController.formKeys[5],
                        textFieldKey: authController.zipCodeKey,
                        enableNext: authController.enableCreateAccount,
                        title: "common.forms.zipCode.title".tr,
                        note: "common.note.required".tr,
                        inputFormatters: [ZipCodeInputFormatter(countryIso: originController.origin_country_iso.value.toUpperCase())],
                        validator: InternationlZipCodesValidator().validator,
                      ),
                    ),
                    Expanded(
                      child: XemoTextFormWithTitleAndNote(
                        controller: authController.cityController,
                        formKey: authController.formKeys[5],
                        textFieldKey: authController.cityKey,
                        enableNext: authController.enableCreateAccount,
                        title: "common.form.address.city.label".tr,
                        note: "common.note.required".tr,
                        validator: XemoFormValidatorWidget().requiredCity,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  width: 1.sw,
                  margin: EdgeInsets.only(top: 58.h, bottom: 51.h, left: 8.w, right: 3.w),
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        Locale? currentLocal = Get.locale;
                        if (currentLocal != null) {
                          log(currentLocal.languageCode);
                          await launch(AppUtils.getGeneralConditionsUrl(
                              originController.origin_country_iso.value.toUpperCase(), currentLocal.languageCode.toLowerCase()));
                        }
                      } catch (e) {
                        log(e.toString());
                      }
                    },
                    child: RichText(
                      text: TextSpan(
                          style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 14.sp),
                          text: 'auth.signup.confirm.1'.tr,
                          children: [
                            TextSpan(
                                text: 'auth.signup.confirm.2'.tr,
                                style: XemoTypography.bodySemiBold(context)!
                                    .copyWith(color: Get.theme.primaryColorLight, fontSize: 14.sp, decoration: TextDecoration.underline)),
                            TextSpan(
                                text: 'auth.signup.confirm.3'.tr,
                                style: XemoTypography.bodySemiBold(context)!.copyWith(
                                  fontSize: 14.sp,
                                ))
                          ]),
                    ),
                  )),

              Container(
                margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Opacity(
                  opacity: authController.enableCreateAccount.value ? 1 : 0.5,
                  child: GestureDetector(
                      onTap: () async {
                        if (authController.enableCreateAccount.value) {
                          Get.dialog(
                              Center(
                                child: RotatedSpinner(
                                  spinnerColor: SpinnerColor.GREEN,
                                  height: 35,
                                  width: 35,
                                ),
                              ),
                              barrierDismissible: false);

                          await authController.saveUserIntoDataStore();
                          await authController.triggerKycVerification();

                          authController.loggedInState.enter();

                          //log('fromm address ' + authController.formateAndStandardizePhoneNumber());

                        }
                      },
                      child: const CreateAccountButtonWidget()),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
