import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_amplifysdk/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/constants/input_borders.dart';
import 'package:mobileapp/controllers/contacts_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/models/Gender.dart';
import 'package:mobileapp/widgets/common/xemo_clear_textFormField_widget.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/widgets/common/xemo_text_form_field_widget.dart';
import 'package:mobileapp/widgets/dialogs/select_country_dialog_widget.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../../../utils/error_alerts_utils.dart';

class AddReceiverView extends StatelessWidget {
  static const String id = '/add-receiver-view';

  const AddReceiverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContactsController contactsController = Get.find<ContactsController>();
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    contactsController.clearData();

    return Scaffold(
      appBar: XemoAppBar(leading: true, function: sendMoneyController.prevStep),
      body: Padding(
        padding: EdgeInsets.only(left: 5.0.w, top: 20.h),
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'contact.newContact'.tr,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.headline3!.copyWith(color: const Color(0xFFF05137), fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),
                //gender selection
                Container(
                  margin: EdgeInsets.only(left: 15.5.w, top: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5.h),
                        child: Text(
                          "GENDER",
                          style: Get.textTheme.headline2!.copyWith(fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2.h),
                        child: Text("Required",
                            style: (contactsController.selectedGender.value != null)
                                ? XemoTypography.captionItalic(context)!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,
                                    color: kLightDisplaySecondaryTextColor,
                                  )
                                : XemoTypography.captionItalic(context)),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.h),
                        child: Row(
                          children: [
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  contactsController.selectedGender.value = Gender.Male;
                                  contactsController.selectedGender.refresh();
                                },
                                child: Container(
                                  height: 50.h,
                                  decoration: ((contactsController.selectedGender.value != null) &&
                                          contactsController.selectedGender.value!.name == Gender.Male.name)
                                      ? BoxDecoration(
                                          color: kLightDisplayPrimaryAction,
                                          boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                                          border: Border.all(color: kLightDisplayPrimaryAction, width: 2))
                                      : BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                                          border: Border.all(color: kLightDisplayPrimaryAction, width: 2)),
                                  child: Center(
                                    child: Text(
                                      "common.male".tr,
                                      style: Get.textTheme.headline4!.copyWith(
                                          color: ((contactsController.selectedGender.value != null) &&
                                                  contactsController.selectedGender.value!.name == Gender.Male.name)
                                              ? Colors.white
                                              : kLightDisplayPrimaryAction),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                contactsController.selectedGender.value = Gender.Female;
                                contactsController.selectedGender.refresh();
                                log(contactsController.selectedGender.value!.name);
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 4.w),
                                height: 50.h,
                                decoration: (((contactsController.selectedGender.value != null)) &&
                                        contactsController.selectedGender.value!.name == Gender.Female.name)
                                    ? BoxDecoration(
                                        color: kLightDisplayPrimaryAction,
                                        boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                                        border: Border.all(color: kLightDisplayPrimaryAction, width: 2))
                                    : BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                                        border: Border.all(color: kLightDisplayPrimaryAction, width: 2)),
                                child: Center(
                                  child: Text(
                                    "common.female".tr,
                                    style: Get.textTheme.headline4!.copyWith(
                                        color: (((contactsController.selectedGender.value != null)) &&
                                                contactsController.selectedGender.value!.name == Gender.Female.name)
                                            ? Colors.white
                                            : kLightDisplayPrimaryAction),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  contactsController.selectedGender.value = Gender.Other;
                                  contactsController.selectedGender.refresh();
                                  log(contactsController.selectedGender.value!.name);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 4.w),
                                  padding: const EdgeInsets.all(10.0),
                                  height: 50.h,
                                  decoration: (((contactsController.selectedGender.value != null)) &&
                                          contactsController.selectedGender.value!.name == Gender.Other.name)
                                      ? BoxDecoration(
                                          color: kLightDisplayPrimaryAction,
                                          // boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                                          borderRadius: const BorderRadius.all(Radius.circular(24)),
                                          border: Border.all(color: kLightDisplayPrimaryAction, width: 2))
                                      : BoxDecoration(
                                          color: Colors.white,
                                          // boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                                          borderRadius: const BorderRadius.all(Radius.circular(24)),
                                          border: Border.all(color: kLightDisplayPrimaryAction, width: 2)),
                                  child: Center(
                                    child: Text(
                                      "common.Other".tr.capitalizeFirst!,
                                      style: Get.textTheme.headline4!.copyWith(
                                          color: (((contactsController.selectedGender.value != null)) &&
                                                  contactsController.selectedGender.value!.name == Gender.Other.name)
                                              ? Colors.white
                                              : kLightDisplayPrimaryAction),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ), //name selection
                Column(
                  children: [
                    XemoTextFormWithTitleAndNote(
                      width: 1.sw,
                      enableRightMargin: false,
                      controller: contactsController.fnameController,
                      formKey: contactsController.formKey.value,
                      textFieldKey: contactsController.firstNameKey,
                      enableNext: contactsController.enableSave,
                      title: "common.forms.firstName.title".tr,
                      note: "auth.signup.details.nameError".tr,
                      validator: XemoFormValidatorWidget().requiredFirstName,
                    ),
                    //lname
                    XemoTextFormWithTitleAndNote(
                      width: 1.sw,
                      enableRightMargin: false,
                      controller: contactsController.lnameController,
                      formKey: contactsController.formKey.value,
                      textFieldKey: contactsController.lastNameKey,
                      enableNext: contactsController.enableSave,
                      title: "auth.register.lastName".tr,
                      note: "auth.signup.details.nameError".tr,
                      validator: XemoFormValidatorWidget().requiredLastName,
                    ),
                  ],
                ),
                //From country
                Container(
                  margin: EdgeInsets.only(
                    top: 25.h,
                    left: 25.5.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 28.w),
                        child: Text(
                          "contact.countryFrom".tr.toUpperCase(),
                          style: Get.textTheme.headline2!.copyWith(fontWeight: FontWeight.w400, fontSize: 16.sp),
                        ),
                      ),
                      Container(
                        //  padding: const EdgeInsets.all(5.0),
                        height: 45.h,
                        width: contactsController.selectedDestinationCountry!.value != null ? 180.w : 210.w,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            color: Colors.white,
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 3))]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ClipOval(
                              child: contactsController.selectedDestinationCountry?.value != null
                                  ? SvgPicture.asset(
                                      contactsController.selectedDestinationCountry?.value != null
                                          ? "assets/flags/${contactsController.selectedDestinationCountry!.value!.iso_code.toLowerCase()}.svg"
                                          : 'assets/images/placeholder.svg',
                                      height: 30,
                                      width: 30,
                                    )
                                  : Container(),
                            ),
                            contactsController.selectedDestinationCountry?.value != null
                                ? Padding(
                                    padding: EdgeInsets.only(
                                      left: 8.0,
                                      top: 15.h,
                                    ),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      // contactsController.exchangeRate!.value.isValid()
                                      Text(
                                        contactsController.selectedDestinationCountry!.value != null
                                            ? contactsController.selectedDestinationCountry!.value!.name
                                            : '',
                                        style: Get.textTheme.subtitle2!.copyWith(fontSize: 12, fontWeight: FontWeight.w700),
                                      )
                                    ]),
                                  )
                                : Text(
                                    'contact.selectCountry'.tr.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 13.sp),
                                  ),
                            GestureDetector(
                              onTap: () async {
                                //showDialog(context: context, builder: (context) => SelectCountryDialogWidget());
                                await selectCountryDialog(fromContact: true);
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1, color: Colors.black)),
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: Offset(1, 2))],
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black, width: 1)),
                                  child: SvgPicture.asset(
                                    'assets/xemo/icon-dropdown.svg',
                                    height: 30.h,
                                    width: 30.w,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //phone number field
                AbsorbPointer(
                  absorbing: !(contactsController.selectedDestinationCountry!.value != null),
                  child: Opacity(
                    opacity: contactsController.selectedDestinationCountry!.value != null ? 1 : 0.1,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 40.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "auth.signup.phone.field.title".tr.toUpperCase(),
                                  style: Get.textTheme.headline2!.copyWith(fontWeight: FontWeight.w400, fontSize: 16),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5.h),
                                child: Text("common.note.required".tr,
                                    style: !(contactsController.phoneNumberKey.value.currentState != null &&
                                            contactsController.phoneNumberKey.value.currentState!.validate())
                                        ? XemoTypography.captionItalic(context)
                                        : XemoTypography.captionItalic(context)!.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14,
                                            color: kLightDisplaySecondaryTextColor,
                                          )),
                              ),
                              Container(
                                width: 1.sw,
                                //margin: EdgeInsets.only(left: 6.w),
                                padding: EdgeInsets.only(left: 2),
                                child: TextFormField(
                                  controller: contactsController.phoneNumberController.value,
                                  keyboardType: TextInputType.phone,
                                  cursorColor: Get.theme.primaryColorLight,
                                  validator: XemoFormValidatorWidget().phoneValidator,
                                  style: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction),
                                  onChanged: (val) {
                                    contactsController.phoneNumberController.refresh();
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: SizedBox(
                                      width: 80.w,
                                      height: 24,
                                      child: contactsController.selectedDestinationCountry!.value != null
                                          ? Row(
                                              children: [
                                                Container(
                                                  width: 5.w,
                                                ),
                                                SvgPicture.asset(
                                                  "assets/flags/${contactsController.selectedDestinationCountry!.value!.iso_code.toLowerCase()}.svg",
                                                  height: 24,
                                                  width: 24,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                                Container(
                                                  width: 6,
                                                ),
                                                Text(
                                                  "+" + int.parse(contactsController.selectedDestinationCountry!.value!.calling_code!).toString(),
                                                  style: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction),
                                                )
                                              ],
                                            )
                                          : Container(),
                                    ),
                                    contentPadding: const EdgeInsets.only(left: 2.0, top: 7.0),
                                    suffix: ClearTextFormFieldWidget(
                                      controller: contactsController.phoneNumberController,
                                      enabelNext: contactsController.enableSave,
                                      textFieldKey: contactsController.phoneNumberKey,
                                    ),

                                    //prefixText: "+213",
                                    fillColor: Colors.transparent,
                                    filled: true,
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
                        ),
                        //address data

                        //
                        Container(
                          margin: EdgeInsets.only(top: 40.h),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            XemoTextFormWithTitleAndNote(
                              width: 1.sw,
                              enableRightMargin: false,
                              controller: contactsController.addressController,
                              formKey: contactsController.formKey.value,
                              textFieldKey: contactsController.addressKey,
                              enableNext: contactsController.enableSave,
                              title: "common.forms.fullAddress.title".tr,
                              note: "auth.signup.required".tr,
                              validator: XemoFormValidatorWidget().requiredFullAddress,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: XemoTextFormWithTitleAndNote(
                                      enableRightMargin: false,
                                      controller: contactsController.zipCodeController,
                                      formKey: contactsController.formKey.value,
                                      textFieldKey: contactsController.zipCodeKey,
                                      enableNext: contactsController.enableSave,
                                      title: "common.forms.zipCode.title".tr,
                                      note: "auth.signup.required".tr,
                                      validator: XemoFormValidatorWidget().postalCodeValidator,
                                    ),
                                  ),
                                  Expanded(
                                    child: XemoTextFormWithTitleAndNote(
                                      enableRightMargin: false,
                                      controller: contactsController.cityController,
                                      formKey: contactsController.formKey.value,
                                      textFieldKey: contactsController.cityKey,
                                      enableNext: contactsController.enableSave,
                                      title: "common.forms.city.title".tr,
                                      note: "auth.signup.required".tr,
                                      validator: XemoFormValidatorWidget().requiredCity,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                        //account number
                        Container(
                          margin: EdgeInsets.only(
                            top: 15.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //account number
                              XemoTextFormWithTitleAndNote(
                                width: 1.sw,
                                enableRightMargin: false,
                                controller: contactsController.accountNumberController,
                                formKey: contactsController.formKey.value,
                                textFieldKey: contactsController.accountNumberKey,
                                enableNext: contactsController.enableSave,
                                title: "contact.ibanOrSwift".tr,
                                note: ('(' + "common.form.field.note.optional".tr + ')'),
                                validator: XemoFormValidatorWidget().ibanValidator,
                              ),
                              //swift

                              XemoTextFormWithTitleAndNote(
                                width: 1.sw,
                                enableRightMargin: false,
                                controller: contactsController.swiftController,
                                formKey: contactsController.formKey.value,
                                textFieldKey: contactsController.swiftKey,
                                enableNext: contactsController.enableSave,
                                title: "SWIFT",
                                note: ('(' + "common.form.field.note.optional".tr + ')'),
                                validator: XemoFormValidatorWidget().ibanValidator,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 150.h,
                  width: 40.w,
                ),
                GestureDetector(
                  onTap: () async {
                    Get.dialog(Center(
                      child: LoadingIndicator(),
                    ));
                    try {
                      await contactsController.saveContact();
                    } catch (error, stackTrace) {
                      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
                      log(error.toString());
                    }
                    Get.back();
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: 58.h,
                    width: 0.1.sw,
                    //margin: EdgeInsets.only(right: 18.w),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Get.theme.primaryColorLight,
                    ),
                    child: Center(
                      child: Text(
                        'Save',
                        textAlign: TextAlign.center,
                        style: Get.textTheme.headline4!.copyWith(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
