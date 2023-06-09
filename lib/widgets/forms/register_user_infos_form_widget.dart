import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/views/auth/auth_register_identity_infos_view.dart';
import 'package:mobileapp/widgets/buttons/next_button_widget.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/widgets/common/xemo_text_form_field_widget.dart';
import 'package:mobileapp/widgets/dialogs/datetime_selector_dialog_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';
import 'selectors/gender_selector_widget.dart';

class RegisterUserInfosFormWidget extends StatelessWidget {
  const RegisterUserInfosFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
//    authController.clearUserInfoForm();
    return Obx(() {
      return Form(
        key: authController.formKeys[1],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Gender
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text("common.gender".tr.toUpperCase(),
                  textAlign: TextAlign.start, style: XemoTypography.bodyAllCapsBlack(context)!.copyWith(fontWeight: FontWeight.w600)),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text("common.note.required".tr,
                  textAlign: TextAlign.start,
                  style: !(authController.gender.value != null)
                      ? XemoTypography.captionItalic(context)!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        )
                      : XemoTypography.captionItalic(context)!.copyWith(
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          color: kLightDisplaySecondaryTextColor,
                        )),
            ),
            const GenderSelector(),
            //family name

            XemoTextFormWithTitleAndNote(
              width: 1.sw,
              controller: authController.firstNameRxController,
              formKey: authController.formKeys[1],
              textFieldKey: authController.firstNameKey,
              enableNext: authController.enableUserInfoNext,
              title: "common.forms.firstName.title".tr,
              note: "common.note.required".tr,
              enableRightMargin: false,
              validator: XemoFormValidatorWidget().requiredFirstName,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp('[a-zA-ZÀ-ÿZàâäæáãåāèéêëęėēîïīįíìôōøõóòöœùûüūúÿçćčńñÀÂÄÆÁÃÅĀÈÉÊËĘĖĒÎÏĪĮÍÌÔŌØÕÓÒÖŒÙÛÜŪÚŸÇĆČŃÑ ]')),
              ],
            ),
//last name form field
            XemoTextFormWithTitleAndNote(
              width: 1.sw,
              controller: authController.lastNameRxController,
              formKey: authController.formKeys[1],
              textFieldKey: authController.lastNameKey,
              enableNext: authController.enableUserInfoNext,
              title: "common.forms.lastName.title".tr,
              note: "common.note.required".tr,
              enableRightMargin: false,
              validator: XemoFormValidatorWidget().requiredLastName,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp('[a-zA-ZÀ-ÿZàâäæáãåāèéêëęėēîïīįíìôōøõóòöœùûüūúÿçćčńñÀÂÄÆÁÃÅĀÈÉÊËĘĖĒÎÏĪĮÍÌÔŌØÕÓÒÖŒÙÛÜŪÚŸÇĆČŃÑ ]')),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 2),
              margin: EdgeInsets.only(
                top: 12.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                        top: 13.h,
                      ),
                      child: Text("auth.signup.iddoc.birth.date".tr.toUpperCase(),
                          style: XemoTypography.bodyAllCapsBlack(context)!.copyWith(fontWeight: FontWeight.w600))),
                  Container(
                    margin: EdgeInsets.only(
                      top: 5.h,
                    ),
                    child: Text("common.note.required".tr,
                        style: ((authController.dob.value != null) && (DateTime.now().year - authController.dob.value!.year >= 18))
                            ? XemoTypography.captionItalic(context)!.copyWith(
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                                color: kLightDisplaySecondaryTextColor,
                              )
                            : XemoTypography.captionItalic(context)!.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.h, left: 0.w),
                    child: Obx(() {
                      return Container(
                        height: 44.h,
                        width: 0.99.sw,
                        //  margin: EdgeInsets.only(left: 8.w),
                        child: GestureDetector(
                          onTap: () async {
                            var selected = await showDateTimeSelector(context,
                                init: DateTime(DateTime.now().year - 16),
                                max: DateTime(DateTime.now().year - 16),
                                min: DateTime(DateTime.now().year - 115));
                            authController.dob.value = selected;
                            if (authController.formKeys[1].currentState!.validate() && (selected != null)) {
                              authController.enableIdentityNext.value = true;
                            } else {
                              authController.enableIdentityNext.value = false;
                            }

                            //                                                    authController.dob.value = val;
                          },
                          child: Container(
                            height: 44.h,
                            //  width: 0.8.sw,
                            decoration: BoxDecoration(
                                border: !((authController.dob.value != null) && (DateTime.now().year - authController.dob.value!.year >= 16))
                                    ? const Border(bottom: BorderSide(color: Color(0x9B9B9B80), width: 1.7))
                                    : Border(bottom: BorderSide(color: Get.theme.primaryColorLight, width: 1.7))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ((authController.dob.value != null) && (DateTime.now().year - authController.dob.value!.year >= 16))
                                      ? authController.dob.value.toString().substring(0, 11)
                                      : '',
                                  style: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 38.h, bottom: 18.h, left: 2.w),
              child: NextButtonWidget(
                width: 1.sw,
                nextScreenId: AuthRegisterIdentityInfosView.id,
                enabled: (authController.enableUserInfoNext.value && (authController.gender.value != null) && (authController.dob.value != null)),
              ),
            )
          ],
        ),
      );
    });
  }
}
