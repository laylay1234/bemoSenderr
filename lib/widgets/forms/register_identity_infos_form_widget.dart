import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/views/auth/auth_register_email_view.dart';
import 'package:mobileapp/widgets/buttons/next_button_widget.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/widgets/common/xemo_text_form_field_widget.dart';
import 'package:mobileapp/widgets/dialogs/countrt_selector_dialog_widget.dart';
import 'package:mobileapp/widgets/dialogs/datetime_selector_dialog_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class RegisterIdentityInfosFormWidget extends StatelessWidget {
  const RegisterIdentityInfosFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    //  authController.clearIdentityForm();
    return Obx(() {
      return Form(
        key: authController.formKeys[2],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          margin: EdgeInsets.only(top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //type drop down
              GestureDetector(
                onTap: () {
                  openDocumentTypeDialog(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          openDocumentTypeDialog(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 5.h,
                                  ),
                                  child: Text(
                                    "auth.signup.iddoc.type".tr.toUpperCase(),
                                    style: XemoTypography.bodyAllCapsBlack(context)!.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 5.h,
                                  ),
                                  child: Text("common.note.required".tr,
                                      style: (authController.documentIdType!.value != null && authController.documentIdType!.value!.isNotEmpty)
                                          ? XemoTypography.captionItalic(context)!.copyWith(
                                              fontWeight: FontWeight.w300,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 14,
                                              color: kLightDisplaySecondaryTextColor,
                                            )
                                          : XemoTypography.captionItalic(context)!.copyWith(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14,
                                            )),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                openDocumentTypeDialog(context);
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 38.0, right: 0.015.sw),
                                child: const Icon(
                                  Icons.arrow_drop_down,
                                  size: 27,
                                  color: kLightDisplayPrimaryAction,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                          width: 1.sw,
                          margin: EdgeInsets.only(top: 10.h),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: authController.documentIdType!.value != null
                                      ? authController.documentIdType!.value!.isEmpty
                                          ? const BorderSide(width: 1.7, color: Color(0xFFFF3A40))
                                          : BorderSide(width: 1.7, color: Get.theme.primaryColorLight)
                                      : const BorderSide(width: 1.7, color: Color(0x9B9B9B80)))),
                          padding: EdgeInsets.only(left: 1.w),
                          child: Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                children: [
                                  authController.documentIdType!.value != null
                                      ? Text(authController.documentIdType!.value!.tr,
                                          style: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction))
                                      : const Text(''),
                                ],
                              ))),
                    ],
                  ),
                ),
              ),
              //document id number
              XemoTextFormWithTitleAndNote(
                enableRightMargin: false,
                width: 1.sw,
                controller: authController.documentIdNumber,
                formKey: authController.formKeys[2],
                textFieldKey: authController.documentIdKey,
                enableNext: authController.enableIdentityNext,
                title: "auth.signup.iddoc.number".tr,
                note: "common.note.required".tr,
                validator: XemoFormValidatorWidget().idNumberValidator,
              ),
              //document exp date
              //TODO to be refactored
              Container(
                //  padding: const EdgeInsets.only(left: 1.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 18.h),
                      child: Text(
                        "auth.signup.iddoc.exp".tr.toUpperCase(),
                        style: XemoTypography.bodyAllCapsBlack(context)!.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          top: 5.h,
                        ),
                        child: Text("common.note.required".tr,
                            style: (authController.documentExpDate.value != null)
                                ? XemoTypography.captionItalic(context)!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,
                                    color: kLightDisplaySecondaryTextColor,
                                  )
                                : XemoTypography.captionItalic(context)!.copyWith(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ))),
                    Container(
                      margin: EdgeInsets.only(top: 5.h, left: 2, right: 0.w),
                      child: SizedBox(
                        height: 38.h,
                        width: 1.sw,
                        child: GestureDetector(
                          onTap: () async {
                            var selected = await showDateTimeSelector(context,
                                init: DateTime.now().add(Duration(days: 3650)),
                                min: DateTime.now().add(Duration(days: 1)),
                                max: DateTime.now().add(Duration(days: 3650)));
                            //  log("?" + selected.toString());s
                            authController.documentExpDate.value = selected;
                            if (authController.formKeys[2].currentState!.validate() && (selected != null)) {
                              authController.enableIdentityNext.value = true;
                            } else {
                              authController.enableIdentityNext.value = false;
                            }
                          }

                          //    log("?" + selectedTime.toString());
                          /*
                         
                          },
*/
                          ,
                          child: Container(
                            height: 32.h,
                            //  width: 0.8.sw,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: !(authController.documentExpDate.value != null)
                                        ? const BorderSide(color: Color(0x9B9B9B80), width: 1.7)
                                        : BorderSide(color: Get.theme.primaryColorLight, width: 1.7))),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2, top: 8.0),
                              child: Text(
                                authController.documentExpDate.value != null ? authController.documentExpDate.toString().substring(0, 11) : '',
                                style: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //occupation
              Padding(
                padding: EdgeInsets.only(left: 0.w),
                child: XemoTextFormWithTitleAndNote(
                  enableRightMargin: false,
                  width: 1.sw,
                  controller: authController.occupationRxController,
                  formKey: authController.formKeys[2],
                  textFieldKey: authController.occupationKey,
                  enableNext: authController.enableIdentityNext,
                  title: "auth.signup.iddoc.occupation".tr,
                  note: "common.note.required".tr,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp('[a-zA-ZÀ-ÿZàâäæáãåāèéêëęėēîïīįíìôōøõóòöœùûüūúÿçćčńñÀÂÄÆÁÃÅĀÈÉÊËĘĖĒÎÏĪĮÍÌÔŌØÕÓÒÖŒÙÛÜŪÚŸÇĆČŃÑ ]')),
                  ],
                  validator: XemoFormValidatorWidget().occupationValidator,
                ),
              ),
              /*
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 25.h, left: 5.w),
                    child: Text(
                      "auth.signup.iddoc.occupation".tr,
                      style: XemoTypography.bodyAllCapsBlack(context),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.h, left: 5.w),
                    child: Text("auth.signup.required".tr,
                        style: !((authController.occupationKey.value.currentState != null) &&
                                (authController.occupationKey.value.currentState!.validate()))
                            ? XemoTypography.captionItalic(context)
                            : XemoTypography.captionItalic(context)!.copyWith(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                                color: kLightDisplaySecondaryTextColor,
                              )),
                  ),
                  Container(margin: EdgeInsets.only(right: 10.w), child: const OccupationTextField())
                ],
              ),
              */
              //country of birth
              Container(
                // padding: EdgeInsets.only(left: 1.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*
                    Icon(
                                FontAwesomeIcons.chevronDown,
                                size: 27,
                                color: kLightDisplayPrimaryAction,
                              )*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: 10.h,
                              ),
                              child: Text(
                                "auth.signup.iddoc.birth.country".tr.toUpperCase(),
                                style: XemoTypography.bodyAllCapsBlack(context)!.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 5.h,
                              ),
                              child: Text("common.note.required".tr,
                                  style: authController.countryOfBirth.value.isNotEmpty
                                      ? XemoTypography.captionItalic(context)!.copyWith(
                                          fontWeight: FontWeight.w300,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          color: kLightDisplaySecondaryTextColor,
                                        )
                                      : XemoTypography.captionItalic(context)!.copyWith(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                        )),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            var selected = await showCountrySelectorDialog(context);
                            if (selected != null) {
                              log(selected);
                              authController.countryOfBirth.value = selected.name!;
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 38.0, right: 0.015.sw),
                            child: const Icon(
                              Icons.arrow_drop_down,
                              size: 27,
                              color: kLightDisplayPrimaryAction,
                            ),
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        //TODO ask greg which one should be tapped to display the dialog
                        var selected = await showCountrySelectorDialog(context);
                        if (selected != null) {
                          log(selected);
                          authController.countryOfBirth.value = selected.name!;
                          if (authController.formKeys[2].currentState!.validate()) {
                            authController.enableIdentityNext.value = true;
                          } else {
                            authController.enableIdentityNext.value = false;
                          }
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 16.h, right: 0.w, left: 2),
                        padding: EdgeInsets.only(bottom: 4.h, left: 0.w),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: !(authController.countryOfBirth.value.isNotEmpty)
                                    ? const BorderSide(color: Color(0x9B9B9B80), width: 1.7)
                                    : BorderSide(color: Get.theme.primaryColorLight, width: 1.7))),
                        width: 1.sw,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: Colors.white,
                          ),
                          child: Text(
                            authController.countryOfBirth.value,
                            style: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction),
                          ),
                        ),
                      ),
                    ),
                  ],
                  //   authController.countryOfBirth.value = newValue.toString();
                ),
              ),
              //city of birth
              Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: XemoTextFormWithTitleAndNote(
                  enableRightMargin: false,
                  width: 1.sw,
                  controller: authController.cityOfBirth,
                  formKey: authController.formKeys[2],
                  textFieldKey: authController.cityOfBirthKey,
                  enableNext: authController.enableIdentityNext,
                  title: "auth.signup.iddoc.birth.city".tr,
                  note: "common.note.required".tr,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp('[a-zA-ZÀ-ÿZàâäæáãåāèéêëęėēîïīįíìôōøõóòöœùûüūúÿçćčńñÀÂÄÆÁÃÅĀÈÉÊËĘĖĒÎÏĪĮÍÌÔŌØÕÓÒÖŒÙÛÜŪÚŸÇĆČŃÑ ]')),
                  ],
                  validator: XemoFormValidatorWidget().requiredCity,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 38.h, bottom: 18.0, left: 2),
                child: NextButtonWidget(
                  width: 1.sw,
                  nextScreenId: AuthRegisterUserCredentialView.id,
                  enabled: (authController.enableIdentityNext.value &&
                      authController.countryOfBirth.value.isNotEmpty &&
                      authController.documentIdType != null &&
                      authController.documentIdType!.value!.isNotEmpty &&
                      authController.documentExpDate.value != null),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Future<void> openDocumentTypeDialog(BuildContext context) async {
    AuthController authController = Get.find<AuthController>();
    return showDialog(
        builder: (BuildContext context) {
          return Obx(() {
            return AlertDialog(
              contentPadding: const EdgeInsets.only(bottom: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: SizedBox(
                width: 0.8.sw,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: 20.h, left: 0.02.sw),
                      height: 39.h,
                      child: Text(
                        'auth.signup.iddoc.type'.tr.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: XemoTypography.headLine5Black(context),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 11.h),
                      // width: double.maxFinite,
                      height: 1,
                      color: const Color(0XFF737373),
                    ),
                    Column(
                      children: ['Passport', 'ID card', "Driver's license", 'Other']
                          .map((e) => GestureDetector(
                                onTap: () {
                                  authController.documentIdType!.value = (e);
                                },
                                child: Theme(
                                  data: Get.theme.copyWith(unselectedWidgetColor: const Color(0xFF9B9B9B), disabledColor: const Color(0xFF9B9B9B)),
                                  child: ListTile(
                                    title: Text(e.tr.toUpperCase(), style: XemoTypography.bodySemiBold(context)),
                                    leading: Container(
                                      margin: EdgeInsets.only(left: 0.025.sw),
                                      child: Radio<String>(
                                          activeColor: kLightDisplayPrimaryAction,
                                          hoverColor: Colors.black,

                                          //fillColor: MaterialStateColor.resolveWith((states) => Get.theme.primaryColorLight),
                                          focusColor: MaterialStateColor.resolveWith((states) => Colors.black),
                                          value: e,
                                          groupValue: authController.documentIdType != null ? authController.documentIdType!.value : '',
                                          onChanged: (value) {
                                            //log(value);
                                            authController.documentIdType!.value = (value ?? '');
                                          }),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 11.h),
                      height: 1,
                      color: const Color(0XFF737373),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 13.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 10.w,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  authController.documentIdType!.value = '';
                                  Get.back();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 28.w),
                                  height: 21.h,
                                  // width: 67.w,
                                  child: Text(
                                    'common.cancel'.tr.toUpperCase(),
                                    style: Get.textTheme.headline3!
                                        .copyWith(color: kLightDisplayPrimaryAction, fontSize: 14.sp, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  log(authController.documentIdType!.value);
                                  Get.back();
                                },
                                child: SizedBox(
                                  height: 21.h,
                                  width: 50.w,
                                  child: Text(
                                    'OK',
                                    style: Get.textTheme.headline3!
                                        .copyWith(color: kLightDisplayPrimaryAction, fontSize: 14.sp, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        },
        context: context);
  }
}
